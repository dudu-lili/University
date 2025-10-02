package com.redtourism.service;

import com.redtourism.entity.TravelRoute;
import com.redtourism.util.ResponseResult;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface RouteService {
    List<TravelRoute> listAll();
    List<TravelRoute> listTopRoutes(int limit);
    TravelRoute getByIdWithScenics(Integer id);
    void increaseLikeCount(Integer id);
    List<TravelRoute> listFavoritesByUserId(Integer userId);
    void unfavoriteRoute(Integer userId, Integer routeId);//取消收藏路线
    void favorite(Integer userId, Integer routeId);//收藏

    int getLikeCount(Integer routeId);

    void addRoute(TravelRoute route);

    TravelRoute getById(Integer id);

    int updateRoute(TravelRoute route);



    void deleteRoute(Integer id);

    boolean checkIfFavorited(Integer id, Integer routeId);

    @Transactional
    ResponseResult<String> uploadCoverImage(Integer id, MultipartFile file);
//    boolean checkIfFavorited(Integer id, Integer routeId);

    boolean checkIfUserLikedRoute(int userId, int routeId);

    // 记录用户点赞路线
    void recordUserLikeRoute(int userId, int routeId);

    // 取消用户点赞路线
    void cancelUserLikeRoute(int userId, int routeId);
    void decreaseLikeCount(Integer routeId);
    void batchDeleteRoutes(List<Integer> routeIds);

}