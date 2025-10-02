package com.redtourism.service;

import com.redtourism.entity.ScenicSpot;
import com.redtourism.util.PageInfo;
import java.util.List;

public interface ScenicService {
    List<ScenicSpot> listAll();
    PageInfo<ScenicSpot> listByPage(int pageNum, int pageSize);
    ScenicSpot getById(Integer id);
    void increaseLikeCount(Integer id);
    List<ScenicSpot> listTopScenics(int limit);
    //方法 根据用户ID查询收藏的景点
    List<ScenicSpot> listFavoritesByUserId(Integer userId);

    int getLikeCount(Integer scenicId);
    void favorite(Integer id, Integer scenicId);
    void deleteScenicSpot(Integer id);
    void addScenicSpot(ScenicSpot spot);
    void updateScenicSpot(ScenicSpot spot);

//    List<ScenicSpot> getScenicsSortedByDistance(double userLat, double userLng, boolean ascending);
    // 按等级排序4.13
    List<ScenicSpot> getScenicsSortedByLevel(boolean ascending);
    List<ScenicSpot> getScenicsSortedByLikes(boolean ascending);
    List<ScenicSpot> getScenicsSortedByFavorites(boolean ascending);
    List<ScenicSpot> getScenicsSortedByDistance(double userLat, double userLng, boolean ascending);
    List<ScenicSpot> findNearbyScenics(Double latitude, Double longitude, Integer radius);

    double haversineDistance(double lat1, double lon1, double lat2, double lon2) ;

    List<ScenicSpot> findAllOrderByLevel(String order);
    boolean checkIfFavorited(Integer id, Integer scenicId);
    // 检查用户是否点赞过景点
    boolean checkIfUserLikedScenic(int userId, int scenicId);

    // 记录用户点赞景点
    void recordUserLikeScenic(int userId, int scenicId);

    // 取消用户点赞景点
    void cancelUserLikeScenic(int userId, int scenicId);
    void decreaseLikeCount(Integer scenicId);
    void batchDeleteScenics(List<Integer> scenicIds);
    List<ScenicSpot> searchScenics(String keyword);

}