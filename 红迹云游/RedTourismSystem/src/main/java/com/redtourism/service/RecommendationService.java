package com.redtourism.service;


import com.redtourism.entity.ScenicSpot;
import com.redtourism.entity.TravelRoute;

import java.util.List;

public interface RecommendationService {
    List<ScenicSpot> recommendScenics(int userId);
    List<TravelRoute> recommendRoutes(int userId);
}