package com.redtourism.mapper;

import com.redtourism.entity.ScenicSpot;
import org.apache.ibatis.annotations.Param;

import com.redtourism.entity.ScenicSpot;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ScenicSpotMapper {
    List<ScenicSpot> selectAll();
    ScenicSpot selectById(Integer id);
    int insert(ScenicSpot scenicSpot);
    int update(ScenicSpot scenicSpot);
    int delete(Integer id);
    int increaseLikeCount(Integer id);
    List<ScenicSpot> selectByRouteId(@Param("routeId") Integer routeId);
    List<ScenicSpot> listTopScenics(@Param("limit") int limit);
    List<ScenicSpot> listFavoritesByUserId(@Param("userId") Integer userId);
    // 排序查询方法
    List<ScenicSpot> findAllOrderByLevel(@Param("order") String order);
    List<ScenicSpot> findAllOrderByLikes(@Param("order") String order);
    List<ScenicSpot> findAllOrderByFavorites(@Param("order") String order);
    List<ScenicSpot> findAll();
    List<ScenicSpot> findNearby(@Param("latitude") Double latitude,
                                @Param("longitude") Double longitude,
                                @Param("radius") Integer radius);
    void decreaseLikeCount(@Param("id") Integer scenicId);
    int batchDelete(@Param("scenicIds") List<Integer> scenicIds);
    List<ScenicSpot> searchScenics(String keyword);

}