package com.redtourism.mapper;

import com.redtourism.entity.TravelRoute;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TravelRouteMapper {
    List<TravelRoute> selectAll();
    TravelRoute selectById(Integer id);
    int insert(TravelRoute travelRoute);
    /// 修改update方法参数类型
    int update(TravelRoute travelRoute);
    int delete(Integer id);
    int increaseLikeCount(Integer id);
    List<TravelRoute> selectTopRoutes(int limit);
    List<TravelRoute> listFavoritesByUserId(@Param("userId") Integer userId);

    int getLikeCountByRouteId(@Param("routeId") Integer routeId);
    int updateCoverImage(@Param("id") Integer id, @Param("coverImage") byte[] coverImage);
    void decreaseLikeCount(@Param("id") Integer routeId);
    int batchDelete(@Param("routeIds") List<Integer> routeIds);
}