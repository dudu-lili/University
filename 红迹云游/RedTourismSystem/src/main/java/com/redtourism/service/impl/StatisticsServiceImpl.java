package com.redtourism.service.impl;

import com.redtourism.mapper.StatisticsMapper;
import com.redtourism.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class StatisticsServiceImpl implements StatisticsService {
    @Autowired
    private StatisticsMapper statisticsMapper;

    @Override
    public Map<String, Object> getDashboardData() {
        Map<String, Object> result = new LinkedHashMap<>();

        // 用户数据
        result.put("totalUsers", statisticsMapper.selectTotalUsers());
        result.put("todayNewUsers", statisticsMapper.selectTodayNewUsers());

        // 收藏前三
        result.put("top3Favorites", statisticsMapper.selectTop3FavoritedScenics());

        // 最多景点省份
        result.put("topProvince", statisticsMapper.selectProvinceWithMostScenics());

//        // 地图数据
//        result.put("scenicCoordinates", statisticsMapper.selectAllScenicCoordinates());

        // 新增: 用户增长趋势(最近30天)
        result.put("userGrowthTrend", statisticsMapper.selectUserGrowthTrend(30));

        // 新增: 互动趋势(最近30天)
        result.put("interactionTrend", statisticsMapper.selectInteractionTrend(30));


        // 评论前十
        result.put("top10Comments", statisticsMapper.selectTop10CommentedScenics());

        // 用户行为统计数据
        // ...其他数据...
        result.put("userBehaviorStats", statisticsMapper.selectUserBehaviorStats());
        result.put("scenicDistribution", statisticsMapper.selectScenicDistributionByProvince());
        return result;
    }
}


