package com.redtourism.mapper;

import com.redtourism.entity.Geocoding;

import java.util.List;
import java.util.Map;

public interface RedGeocodingMapper {
    List<Geocoding> selectAll();
    // 新增方法：按省份统计数量
    List<Map<String, Object>> selectProvinceCount();  // 返回 Map 列表

}
