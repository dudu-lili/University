package com.redtourism.service.impl;

import com.redtourism.entity.Geocoding;
import com.redtourism.mapper.RedGeocodingMapper;
import com.redtourism.service.RedGeocodingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RedGeocodingServiceImpl implements RedGeocodingService {
    @Autowired
    private RedGeocodingMapper redGeocodingMapper;

    @Override
    public List<Geocoding> getAllRedScenics() {
        List<Geocoding> result = redGeocodingMapper.selectAll();
        System.out.println("getAllRedScenics result size: " + (result != null ? result.size() : "null"));
        for (Geocoding geocoding : result) {
            System.out.println("Geocoding: " + geocoding);
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getProvinceCounts() {

        return redGeocodingMapper.selectProvinceCount();
    }
}
