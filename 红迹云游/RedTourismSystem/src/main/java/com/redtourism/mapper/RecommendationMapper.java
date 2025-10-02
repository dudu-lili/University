package com.redtourism.mapper;

import com.redtourism.entity.ScenicSpot;
import com.redtourism.entity.TravelRoute;

import java.util.List;
import java.util.Map;


public interface RecommendationMapper {
    //获取用户收藏的景点ID列表
    List<Integer> getUserFavoriteScenics(int userId);
//    获取用户收藏的路线ID列表
    List<Integer> getUserFavoriteRoutes(int userId);
    //获取所有景点信息
    List<ScenicSpot> getAllScenics();
    //获取所有路线信息
    List<TravelRoute> getAllRoutes();
    //获取指定用户收藏的所有项目
    List<Map<String, Object>> getUserFavorites(int userId);
    //获取所有用户的收藏记录 -
    List<Map<String, Object>> getAllUserFavorites();


    // 获取所有景点信息（带默认排序）
    List<ScenicSpot> getAllScenicsWithDefaultOrder();

    // 获取所有路线信息（带默认排序）
    List<TravelRoute> getAllRoutesWithDefaultOrder();
}