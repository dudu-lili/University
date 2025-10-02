package com.redtourism.service;

import com.redtourism.entity.Geocoding;

import java.util.List;
import java.util.Map;

public interface RedGeocodingService {
    List<Geocoding> getAllRedScenics();
    List<Map<String, Object>> getProvinceCounts();  // 返回 Map 列表
}