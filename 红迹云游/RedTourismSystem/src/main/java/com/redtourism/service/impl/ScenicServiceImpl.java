package com.redtourism.service.impl;

import com.redtourism.mapper.FavoriteMapper;
import com.redtourism.mapper.LikeMapper;
import com.redtourism.mapper.ScenicSpotMapper;
import com.redtourism.entity.Favorite;
import com.redtourism.entity.ScenicSpot;
import com.redtourism.service.ScenicService;
import com.redtourism.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@Service
public class ScenicServiceImpl implements ScenicService {

    @Autowired
    private ScenicSpotMapper scenicSpotMapper;
    @Autowired
    private FavoriteMapper favoriteMapper;
    @Autowired
    private LikeMapper likeMapper;

    @Override
    public List<ScenicSpot> listAll() {
        return scenicSpotMapper.selectAll();
    }

    @Override
    public PageInfo<ScenicSpot> listByPage(int pageNum, int pageSize) {
        List<ScenicSpot> list = scenicSpotMapper.selectAll();
        return new PageInfo<>(pageNum, pageSize, list.size(), list);
    }

    @Override
    public ScenicSpot getById(Integer id) {
        return scenicSpotMapper.selectById(id);
    }

    @Override
    public void increaseLikeCount(Integer id) {
        scenicSpotMapper.increaseLikeCount(id);
    }

    @Override
    public List<ScenicSpot> listTopScenics(int limit) {
        return scenicSpotMapper.listTopScenics(limit);
    }

    @Override
    public List<ScenicSpot> listFavoritesByUserId(Integer userId) {
        return scenicSpotMapper.listFavoritesByUserId(userId);
    }

    @Override
    public int getLikeCount(Integer scenicId) {
        ScenicSpot scenicSpot = scenicSpotMapper.selectById(scenicId);
        return scenicSpot != null ? scenicSpot.getLikeCount() : 0;
    }

    @Override
    public void favorite(Integer userId, Integer scenicId) {
        //检查是否已收藏
        Favorite existing = favoriteMapper.selectByUserAndScenic(userId, scenicId);
        if (existing != null) {
            return;//已收藏则不再重复添加
        }

        //创建新的收藏记录
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setScenicId(scenicId);
        favorite.setCreateTime(new Date());

        favoriteMapper.insert(favorite);
    }


    @Override
    public void deleteScenicSpot(Integer id) {
        //先删除收藏关系
        favoriteMapper.deleteByScenicId(id);
        //再删除景点
        scenicSpotMapper.delete(id);
    }

    @Override
    public void addScenicSpot(ScenicSpot spot) {
        //设置默认点赞数为0
        if(spot.getLikeCount() == null) {
            spot.setLikeCount(0);
        }

        scenicSpotMapper.insert(spot);
    }

    @Override

    public void updateScenicSpot(ScenicSpot spot) {
        //保留原有的点赞数
        ScenicSpot original = scenicSpotMapper.selectById(spot.getId());
        System.out.println("111"+original);
        System.out.println("1211"+spot);
        if(original != null) {
            spot.setLikeCount(original.getLikeCount());
            // 如果没有上传新图片，保留原有图片
            if(spot.getCoverImage() == null) {
                spot.setCoverImage(original.getCoverImage());
            }
        }
        scenicSpotMapper.update(spot);
    }

    //取消收藏景点
    public void unfavoriteScenic(Integer userId, Integer scenicId) {
        favoriteMapper.unfavoriteScenic(userId, scenicId);
    }

    @Override
    public List<ScenicSpot> getScenicsSortedByLevel(boolean ascending) {
        String order = ascending ? "ASC" : "DESC";
        return scenicSpotMapper.findAllOrderByLevel(order);
    }

    @Override
    public List<ScenicSpot> getScenicsSortedByLikes(boolean ascending) {
        String order = ascending ? "ASC" : "DESC";
        return scenicSpotMapper.findAllOrderByLikes(order);
    }

    @Override
    public List<ScenicSpot> getScenicsSortedByFavorites(boolean ascending) {
        String order = ascending ? "ASC" : "DESC";
        return scenicSpotMapper.findAllOrderByFavorites(order);
    }

    @Override
    public List<ScenicSpot> getScenicsSortedByDistance(double userLat, double userLng, boolean ascending) {
        List<ScenicSpot> spots = scenicSpotMapper.findAll();

        spots.forEach(spot -> {
            double distance = haversineDistance(userLat, userLng,
                    spot.getLatitude(), spot.getLongitude());
            spot.setDistance(distance);
        });

        spots.sort(Comparator.comparingDouble(ScenicSpot::getDistance));
        if (!ascending) {
            Collections.reverse(spots);
        }

        return spots;
    }
    @Override
    public double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // 地球半径(公里)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                        Math.sin(dLon/2) * Math.sin(dLon/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return R * c;
    }

    @Override
    public List<ScenicSpot> findAllOrderByLevel(String order) {
        return scenicSpotMapper.findAllOrderByLevel(order);
    }

    @Override
    public List<ScenicSpot> findNearbyScenics(Double latitude, Double longitude, Integer radius) {
        System.out.println("xxx"+scenicSpotMapper.findNearby(latitude, longitude, radius));
        // 使用Haversine公式计算距离并筛选
        return scenicSpotMapper.findNearby(latitude, longitude, radius);
    }


    @Override
    public boolean checkIfFavorited(Integer userId, Integer scenicId) {
        //使用FavoriteMapper查询用户是否已收藏该路线
        Favorite favorite = favoriteMapper.selectByUserAndScenic(userId, scenicId);
        //如果查询结果不为null则表示已收藏
        return favorite != null;
    }

    @Override
    public void recordUserLikeScenic(int userId, int scenicId) {
        // 先检查是否已点赞
        if (likeMapper.checkIfUserLikedScenic(userId, scenicId) > 0) {
            throw new RuntimeException("用户已点赞过该景点");
        }
        likeMapper.insertUserLikeScenic(userId, scenicId);

    }

    @Override
    public void cancelUserLikeScenic(int userId, int scenicId) {
        // 先检查是否已点赞
        if (likeMapper.checkIfUserLikedScenic(userId, scenicId) == 0) {
            throw new RuntimeException("用户未点赞过该景点");
        }
        likeMapper.deleteUserLikeScenic(userId, scenicId);

    }

    // 新增实现方法
    @Override
    public boolean checkIfUserLikedScenic(int userId, int scenicId) {
        return likeMapper.checkIfUserLikedScenic(userId, scenicId) > 0;
    }
    @Override
    public void decreaseLikeCount(Integer scenicId) {
        scenicSpotMapper.decreaseLikeCount(scenicId);
    }
    @Override
    public void batchDeleteScenics(List<Integer> scenicIds) {
        if (scenicIds == null || scenicIds.isEmpty()) {
            throw new IllegalArgumentException("景点ID列表不能为空");
        }

        // 先删除相关收藏记录
        favoriteMapper.deleteByScenicIds(scenicIds);
        // 再删除景点
        scenicSpotMapper.batchDelete(scenicIds);
    }

    @Override
    public List<ScenicSpot> searchScenics(String keyword) {
        return scenicSpotMapper.searchScenics(keyword);
    }


}