package com.redtourism.service.impl;

import com.redtourism.entity.Favorite;
import com.redtourism.mapper.*;
import com.redtourism.entity.TravelRoute;
import com.redtourism.service.RouteService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
public class RouteServiceImpl implements RouteService {


    @Autowired
    private TravelRouteMapper travelRouteMapper;

    @Autowired
    private ScenicSpotMapper scenicSpotMapper;
    @Autowired
    private FavoriteMapper favoriteMapper;
    @Autowired
    private LikeMapper likeMapper;


    @Override
    public List<TravelRoute> listFavoritesByUserId(Integer userId) {
        return travelRouteMapper.listFavoritesByUserId(userId);
    }
    @Override
    public List<TravelRoute> listAll() {
        return travelRouteMapper.selectAll();
    }

    @Override
    public List<TravelRoute> listTopRoutes(int limit) {
        return travelRouteMapper.selectTopRoutes(limit);
    }

    @Override
    public TravelRoute getByIdWithScenics(Integer id) {
        TravelRoute route = travelRouteMapper.selectById(id);

        return route;
    }

    @Override
    public void increaseLikeCount(Integer id) {
        travelRouteMapper.increaseLikeCount(id);
    }
    //新增取消收藏路线的方法
    public void unfavoriteRoute(Integer userId, Integer routeId) {
        favoriteMapper.unfavoriteRoute(userId, routeId);
    }
    @Override
    public void favorite(Integer userId, Integer routeId) {
        //创建Favorite对象并设置属性
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setRouteId(routeId);
        favorite.setCreateTime(new Date());//当前时间

        //调用FavoriteMapper的insert方法
        favoriteMapper.insert(favorite);
    }

    @Override
    public int getLikeCount(Integer routeId) {
        return travelRouteMapper.getLikeCountByRouteId(routeId);
    }

    @Override
    public void addRoute(TravelRoute route) {
        //设置默认点赞数为0
        if(route.getLikeCount() == null) {
            route.setLikeCount(0);
        }
        travelRouteMapper.insert(route);
    }


    @Override
    public TravelRoute getById(Integer id) {
        return travelRouteMapper.selectById(id);
    }

    @Override
    @Transactional
    public int updateRoute(TravelRoute route) {
        // 获取现有路线数据
        TravelRoute existingRoute = travelRouteMapper.selectById(route.getId());

        // 如果没有上传新图片，保留原有图片
        if(route.getCoverImage() == null && existingRoute != null) {
            route.setCoverImage(existingRoute.getCoverImage());
        }

        return travelRouteMapper.update(route); // 直接传递TravelRoute对象
    }



    @Override
    public void deleteRoute(Integer id) {
        //先删除收藏关系
        favoriteMapper.deleteByRouteId(id);
        //最后删除路线
        travelRouteMapper.delete(id);
    }

    @Override
    public boolean checkIfFavorited(Integer userId, Integer routeId) {
        //使用FavoriteMapper查询用户是否已收藏该路线
        Favorite favorite = favoriteMapper.selectByUserAndRoute(userId, routeId);
        //如果查询结果不为null则表示已收藏
        return favorite != null;
    }
    @Override
    @Transactional
    public ResponseResult<String> uploadCoverImage(Integer id, MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return ResponseResult.fail("请选择要上传的图片");
            }

            if (file.getSize() > 5 * 1024 * 1024) {
                return ResponseResult.fail("图片大小不能超过5MB");
            }

            int result = travelRouteMapper.updateCoverImage(id, file.getBytes());
            if (result > 0) {
                return ResponseResult.success("景点图片上传成功");
            }
            return ResponseResult.fail("景点图片更新失败");
        } catch (IOException e) {
            return ResponseResult.fail("图片上传失败: " + e.getMessage());
        }
    }
    @Override
    public void recordUserLikeRoute(int userId, int routeId) {

        // 先检查是否已点赞
        if (likeMapper.checkIfUserLikedRoute(userId, routeId) > 0) {
            throw new RuntimeException("用户已点赞过该路线");
        }
        likeMapper.insertUserLikeRoute(userId, routeId);
//
    }

    @Override
    public void cancelUserLikeRoute(int userId, int routeId) {

        // 先检查是否已点赞
        if (likeMapper.checkIfUserLikedRoute(userId, routeId) == 0) {
            throw new RuntimeException("用户未点赞过该路线");
        }
        likeMapper.deleteUserLikeRoute(userId, routeId);

    }

    // 新增实现方法
    @Override
    public boolean checkIfUserLikedRoute(int userId, int routeId) {
        // 调用 LikeMapper 检查用户是否已点赞该路线
        return likeMapper.checkIfUserLikedRoute(userId, routeId) > 0;
    }
    @Override
    public void decreaseLikeCount(Integer routeId) {
        travelRouteMapper.decreaseLikeCount(routeId);
    }
    @Override
    @Transactional
    public void batchDeleteRoutes(List<Integer> routeIds) {
        if (routeIds == null || routeIds.isEmpty()) {
            throw new IllegalArgumentException("路线ID列表不能为空");
        }

        // 先删除相关收藏
        favoriteMapper.deleteByRouteIds(routeIds);

        // 再删除路线
        travelRouteMapper.batchDelete(routeIds);
    }
}