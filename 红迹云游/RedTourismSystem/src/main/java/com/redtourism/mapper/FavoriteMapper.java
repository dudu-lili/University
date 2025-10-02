package com.redtourism.mapper;

import com.redtourism.entity.Favorite;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FavoriteMapper {
    int insert(Favorite favorite);
    int delete(Integer id);
    Favorite selectByUserAndScenic(@Param("userId") Integer userId, @Param("scenicId") Integer scenicId);
    Favorite selectByUserAndRoute(@Param("userId") Integer userId, @Param("routeId") Integer routeId);
    Favorite selectByUserAndTravelNotes(@Param("userId") Integer userId, @Param("travelNotesId") Integer travelNotesId);
    List<Favorite> selectByUserId(Integer userId);
    //方法 根据用户ID和景点ID取消收藏
    int unfavoriteScenic(@Param("userId") Integer userId, @Param("scenicId") Integer scenicId);

    //方法 根据用户ID和路线ID取消收藏
    int unfavoriteRoute(@Param("userId") Integer userId, @Param("routeId") Integer routeId);

    int unfavoriteTravelNotes(@Param("userId") Integer userId, @Param("travelNotesId") Integer travelNotesId);

    //方法 根据景点ID删除收藏
    int deleteByScenicId(@Param("scenicId") Integer scenicId);

    void deleteByRouteId(Integer id);
    int deleteByTravelNotesId(@Param("travelNotesId") Integer travelNotesId);
    int deleteByScenicIds(@Param("scenicIds") List<Integer> scenicIds);
    int deleteByRouteIds(@Param("routeIds") List<Integer> routeIds);
}