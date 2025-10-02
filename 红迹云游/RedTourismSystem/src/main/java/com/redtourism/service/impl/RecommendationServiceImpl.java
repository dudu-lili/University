package com.redtourism.service.impl;

import com.redtourism.entity.ScenicSpot;
import com.redtourism.entity.TravelRoute;
import com.redtourism.mapper.RecommendationMapper;
import com.redtourism.mapper.ScenicSpotMapper;
import com.redtourism.mapper.TravelRouteMapper;
import com.redtourism.service.RecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import java.util.concurrent.TimeUnit;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class RecommendationServiceImpl implements RecommendationService {

    @Autowired
    private RecommendationMapper recommendationMapper;
    @Autowired
    private ScenicSpotMapper scenicSpotMapper;
    @Autowired
    private TravelRouteMapper travelRouteMapper;

    // 缓存相似度计算结果（30分钟自动过期）
    private final Cache<Integer, List<Map.Entry<Integer, Double>>> similarityCache =
            CacheBuilder.newBuilder()
                    .expireAfterWrite(30, TimeUnit.MINUTES)
                    .build();

    // ==== 景点推荐逻辑 ====
    @Override
    public List<ScenicSpot> recommendScenics(int userId) {
        // 1. 基础数据准备
        List<Integer> userFavorites = recommendationMapper.getUserFavoriteScenics(userId);
        List<ScenicSpot> allScenics = recommendationMapper.getAllScenicsWithDefaultOrder();
        Map<Integer, Double> scenicScores = new HashMap<>();

        // 2. 特殊场景处理（新用户/冷启动）
        if (handleNewUserOrColdStart(userId, userFavorites, scenicScores, true)) {
            return sortAllWithScores(allScenics, scenicScores, userFavorites);
        }

        // 3. 协同过滤计算
        Map<Integer, List<Integer>> userScenicMap = getAllUserFavoritesMap();
        List<Map.Entry<Integer, Double>> sortedUsers = getSortedSimilarUsers(userId, userScenicMap);

        // 4. 推荐得分计算（相似度加权求和）
        for (ScenicSpot scenic : allScenics) {
            double totalScore = 0;
            for (Map.Entry<Integer, Double> entry : sortedUsers) {
                int similarUser = entry.getKey();
                double similarity = entry.getValue();

                List<Integer> similarUserFavorites = userScenicMap.get(similarUser);
                if (similarUserFavorites != null && similarUserFavorites.contains(scenic.getId())) {
                    totalScore += similarity;
                }
            }
            scenicScores.put(scenic.getId(), totalScore);
        }

        // 5. 已收藏项强制置底
        userFavorites.forEach(fid -> scenicScores.put(fid, Double.MIN_VALUE));

        return sortAllWithScores(allScenics, scenicScores, userFavorites);
    }

    // ==== 路线推荐逻辑 ====
    @Override
    public List<TravelRoute> recommendRoutes(int userId) {
        // 1. 基础数据准备
        List<Integer> userFavorites = recommendationMapper.getUserFavoriteRoutes(userId);
        List<TravelRoute> allRoutes = recommendationMapper.getAllRoutesWithDefaultOrder();
        Map<Integer, Double> routeScores = new HashMap<>();

        // 2. 特殊场景处理（新用户/冷启动）
        if (handleNewUserOrColdStart(userId, userFavorites, routeScores, false)) {
            return sortAllWithScores(allRoutes, routeScores, userFavorites);
        }

        // 3. 协同过滤计算
        Map<Integer, List<Integer>> userRouteMap = getAllUserFavoritesMapForRoutes();
        List<Map.Entry<Integer, Double>> sortedUsers = getSortedSimilarUsers(userId, userRouteMap);

        // 4. 推荐得分计算（相似度加权求和）
        for (TravelRoute route : allRoutes) {
            double totalScore = 0;
            for (Map.Entry<Integer, Double> entry : sortedUsers) {
                int similarUser = entry.getKey();
                double similarity = entry.getValue();

                List<Integer> similarUserFavorites = userRouteMap.get(similarUser);
                if (similarUserFavorites != null && similarUserFavorites.contains(route.getId())) {
                    totalScore += similarity;
                }
            }
            routeScores.put(route.getId(), totalScore);
        }

        // 5. 已收藏项强制置底
        userFavorites.forEach(rid -> routeScores.put(rid, Double.MIN_VALUE));

        return sortAllWithScores(allRoutes, routeScores, userFavorites);
    }

    /**
     * 处理新用户/冷启动场景
     * @param isScenic 标记是否处理景点推荐
     * @return 是否需要跳过协同过滤计算
     */
    private boolean handleNewUserOrColdStart(int userId, List<?> userFavorites,
                                             Map<Integer, Double> scoreMap, boolean isScenic) {
        // 场景1：完全新用户（无任何收藏）
        if (userFavorites.isEmpty()) {
            applyHybridStrategy(scoreMap, isScenic, true);
            return true;
        }

        // 场景2：系统冷启动（所有用户收藏数据为空）
        if (getAllUserFavoritesMap().isEmpty()) {
            applyHybridStrategy(scoreMap, isScenic, false);
            return true;
        }

        // 场景3：当前用户是唯一有收藏的用户
        if (!hasSimilarUsers(userId)) {
            applyHybridStrategy(scoreMap, isScenic, false);
            return true;
        }

        return false;
    }

    /**
     * 应用混合推荐策略（热门+随机）
     * @param scoreMap 得分映射表
     * @param isScenic 是否为景点推荐
     * @param isNewUser 是否为新用户
     */
    private void applyHybridStrategy(Map<Integer, Double> scoreMap, boolean isScenic, boolean isNewUser) {
        int hotLimit = isNewUser ? 5 : 3; // 新用户更多依赖热门
        int randomLimit = 10 - hotLimit;

        // 获取热门数据
        if (isScenic) {
            List<ScenicSpot> hotScenics = scenicSpotMapper.listTopScenics(hotLimit);
            hotScenics.forEach(scenic -> scoreMap.put(scenic.getId(), 1.0));
        } else {
            List<TravelRoute> hotRoutes = travelRouteMapper.selectTopRoutes(hotLimit);
            hotRoutes.forEach(route -> scoreMap.put(route.getId(), 1.0));
        }

        // 获取随机数据补足
        if (randomLimit > 0) {
            List<?> allItems = isScenic
                    ? (List<?>) recommendationMapper.getAllScenicsWithDefaultOrder()
                    : (List<?>) recommendationMapper.getAllRoutesWithDefaultOrder();

            List<?> randomItems = new ArrayList<>(allItems);
            if (isScenic) {
                randomItems.removeAll(scenicSpotMapper.listTopScenics(hotLimit));
            } else {
                randomItems.removeAll(travelRouteMapper.selectTopRoutes(hotLimit));
            }
            Collections.shuffle((List<?>) randomItems);

            ((List<?>) randomItems).stream()
                    .limit(randomLimit)
                    .forEach(item -> scoreMap.put(getId(item), 0.5));
        }
    }

    // ==== 以下为公共方法 ====

    /**
     * 全量排序逻辑（包含已收藏项置底）
     * @param allItems 所有景点/路线
     * @param scoreMap 得分映射表
     * @param userFavorites 用户已收藏列表
     * @return 排序后的推荐列表
     */
    private <T> List<T> sortAllWithScores(List<T> allItems,
                                          Map<Integer, Double> scoreMap,
                                          List<Integer> userFavorites) {
        return allItems.stream()
                .sorted((a, b) -> {
                    // 主排序：推荐得分降序
                    int scoreCompare = Double.compare(
                            scoreMap.getOrDefault(getId(b), 0.0),
                            scoreMap.getOrDefault(getId(a), 0.0)
                    );
                    if (scoreCompare != 0) return scoreCompare;

                    // 次排序：是否已收藏（已收藏置底）
                    boolean aFav = userFavorites.contains(getId(a));
                    boolean bFav = userFavorites.contains(getId(b));
                    return Boolean.compare(bFav, aFav);
                })
                .collect(Collectors.toList());
    }

    /**
     * 获取排序后的相似用户列表（带缓存）
     */
    private List<Map.Entry<Integer, Double>> getSortedSimilarUsers(int userId,
                                                                   Map<Integer, List<Integer>> userMap) {
        List<Map.Entry<Integer, Double>> cachedResult = similarityCache.getIfPresent(userId);
        if (cachedResult != null) {
            return cachedResult;
        }

        Map<Integer, Double> similarityScores = new HashMap<>();
        for (Map.Entry<Integer, List<Integer>> entry : userMap.entrySet()) {
            int otherUserId = entry.getKey();
            if (otherUserId == userId) continue;

            List<Integer> otherFavorites = entry.getValue();
            double similarity = calculateJaccardSimilarity(
                    userId, otherUserId, userMap);
            similarityScores.put(otherUserId, similarity);
        }

        List<Map.Entry<Integer, Double>> sorted = similarityScores.entrySet().stream()
                .sorted(Map.Entry.<Integer, Double>comparingByValue().reversed())
                .collect(Collectors.toList());

        similarityCache.put(userId, sorted);
        return sorted;
    }

    // ==== 工具方法 ====

    /**
     * 计算Jaccard相似度
     */
    private double calculateJaccardSimilarity(int userId1, int userId2, Map<Integer, List<Integer>> userMap) {
        List<Integer> set1 = userMap.getOrDefault(userId1, Collections.emptyList());
        List<Integer> set2 = userMap.getOrDefault(userId2, Collections.emptyList());

        Set<Integer> setA = new HashSet<>(set1);
        Set<Integer> setB = new HashSet<>(set2);

        int intersection = 0;
        for (Integer item : setA) {
            if (setB.contains(item)) intersection++;
        }

        return (double) intersection / (setA.size() + setB.size() - intersection);
    }

    // 泛型ID提取方法
    private <T> Integer getId(T item) {
        if (item instanceof ScenicSpot) {
            return ((ScenicSpot) item).getId();
        } else if (item instanceof TravelRoute) {
            return ((TravelRoute) item).getId();
        }
        return null;
    }

    // ==== 数据访问层相关方法 ====

    private Map<Integer, List<Integer>> getAllUserFavoritesMap() {
        List<Map<String, Object>> allFavorites = recommendationMapper.getAllUserFavorites();
        return buildUserItemMap(allFavorites, "scenic_id");
    }

    private Map<Integer, List<Integer>> getAllUserFavoritesMapForRoutes() {
        List<Map<String, Object>> allFavorites = recommendationMapper.getAllUserFavorites();
        return buildUserItemMap(allFavorites, "route_id");
    }

    private Map<Integer, List<Integer>> buildUserItemMap(List<Map<String, Object>> data, String itemKey) {
        Map<Integer, List<Integer>> userItemMap = new HashMap<>();
        for (Map<String, Object> row : data) {
            int userId = (Integer) row.get("user_id");
            Integer itemId = (Integer) row.get(itemKey);
            if (itemId != null) {
                userItemMap.computeIfAbsent(userId, k -> new ArrayList<>()).add(itemId);
            }
        }
        return userItemMap;
    }

    private boolean hasSimilarUsers(int userId) {
        Map<Integer, List<Integer>> userFavoritesMap = getAllUserFavoritesMap();
        return userFavoritesMap.keySet().stream()
                .anyMatch(uid -> uid != userId && !userFavoritesMap.get(uid).isEmpty());
    }
}
