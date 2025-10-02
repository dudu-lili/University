package com.redtourism.mapper;

import java.util.List;
import java.util.Map;

public interface StatisticsMapper {
    // 用户统计
    int selectTotalUsers();
    int selectTodayNewUsers();

    // 景点统计
    List<Map<String, Object>> selectTop3FavoritedScenics();
    List<Map<String, Object>> selectTop10CommentedScenics();
    Map<String, Object> selectProvinceWithMostScenics();


    List<Map<String, Object>> selectUserGrowthTrend(int days);
    List<Map<String, Object>> selectInteractionTrend(int days);

    Map<String, Object> selectUserBehaviorStats();
    List<Map<String, Object>> selectScenicDistributionByProvince();

}

