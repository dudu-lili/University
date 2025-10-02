package com.redtourism.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class GaodeMapUtil {

    @Value("${gaode.map.key}")
    private String key; // 高德地图开发者密钥

    private static final String GEOCODING_API = "https://restapi.amap.com/v3/geocode/geo";

    public Map<String, Double> getLatLng(String address) {
        RestTemplate restTemplate = new RestTemplate();

        String url = String.format("%s?address=%s&output=JSON&key=%s",
                GEOCODING_API, address, key);

        Map<String, Object> response = restTemplate.getForObject(url, HashMap.class);

        if (response != null && "1".equals(response.get("status")) &&
                ((List)response.get("geocodes")).size() > 0) {
            String location = (String)((Map)((List)response.get("geocodes")).get(0)).get("location");
            String[] latLng = location.split(",");

            Map<String, Double> result = new HashMap<>();
            result.put("lng", Double.parseDouble(latLng[0])); // 高德经度在前
            result.put("lat", Double.parseDouble(latLng[1])); // 高德纬度在后
            return result;
        }
        return null;
    }
}
