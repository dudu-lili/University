package com.redtourism.mapper;

import org.apache.ibatis.annotations.Param;

public interface LikeMapper {

    // 检查用户是否点赞过路线
    int checkIfUserLikedRoute(@Param("userId") int userId, @Param("routeId") int routeId);

    // 记录用户点赞路线
    void insertUserLikeRoute(@Param("userId") int userId, @Param("routeId") int routeId);

    // 取消用户点赞路线
    void deleteUserLikeRoute(@Param("userId") int userId, @Param("routeId") int routeId);

    // 检查用户是否点赞过景点
    int checkIfUserLikedScenic(@Param("userId") int userId, @Param("scenicId") int scenicId);

    // 记录用户点赞景点
    void insertUserLikeScenic(@Param("userId") int userId, @Param("scenicId") int scenicId);

    // 取消用户点赞景点
    void deleteUserLikeScenic(@Param("userId") int userId, @Param("scenicId") int scenicId);

}
