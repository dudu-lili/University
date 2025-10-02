package com.redtourism.service.impl;

import com.redtourism.entity.Favorite;
import com.redtourism.entity.TravelNotes;
import com.redtourism.mapper.FavoriteMapper;
import com.redtourism.mapper.TravelNotesMapper;
import com.redtourism.service.CommentService;
import com.redtourism.service.TravelNotesService;
import com.redtourism.service.UserService;
import com.redtourism.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class TravelNotesServiceImpl implements TravelNotesService {

    @Autowired
    private TravelNotesMapper travelNotesMapper;

    @Autowired
    private CommentService commentService;

    @Autowired
    private FavoriteMapper favoriteMapper;



    @Override
    public List<TravelNotes> listAll() {
        return travelNotesMapper.selectAll();
    }


    @Override
    public PageInfo<TravelNotes> listByPage(int pageNum, int pageSize) {
        List<TravelNotes> list = travelNotesMapper.selectAll();
        return new PageInfo<>(pageNum, pageSize, list.size(), list);
    }

    @Override
    public TravelNotes getById(Integer id) {
        return travelNotesMapper.selectById(id);
    }

    @Override
    public List<TravelNotes> listTopTravelNotes(int limit) {
        return travelNotesMapper.listTopTravelNotes(limit);
    }

    @Override
    public void favorite(Integer userId, Integer travelNotesId) {
        // 检查是否已收藏
        Favorite existing = favoriteMapper.selectByUserAndTravelNotes(userId, travelNotesId);
        if (existing != null) {
            throw new RuntimeException("该游记已被收藏");
        }

        // 创建新的收藏记录
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setTravelNotesId(travelNotesId);
        favorite.setCreateTime(new Date());

        favoriteMapper.insert(favorite);

        // 增加收藏数
        travelNotesMapper.increaseFavoriteCount(travelNotesId);
    }


    @Override
    public void increaseViewCount(Integer id) {
        travelNotesMapper.increaseViewCount(id);
    }

    @Override
    public void increaseFavoriteCount(Integer id) {
        travelNotesMapper.increaseFavoriteCount(id);
    }

    @Override
    public void deleteTravelNotes(Integer id) {
        favoriteMapper.deleteByTravelNotesId(id);
        travelNotesMapper.delete(id);
    }

    @Override
    public void delete(Integer id) {
        travelNotesMapper.delete(id);
    }

    @Override
    public int getViewCount(Integer travelNotesId) {
        TravelNotes travelNotes = travelNotesMapper.selectById(travelNotesId);
        return travelNotes != null ? travelNotes.getViewCount() : 0;
    }

    @Override
    public int getFavoriteCount(Integer travelNotesId) {
        TravelNotes travelNotes = travelNotesMapper.selectById(travelNotesId);
        return travelNotes != null ? travelNotes.getFavoriteCount() : 0;
    }


    @Override
    public void addTravelNotes(TravelNotes travelNotes) {
        try {
            // 设置默认数为0
            if (travelNotes.getViewCount() == null) {
                travelNotes.setViewCount(0);
            }
            if (travelNotes.getFavoriteCount() == null) {
                travelNotes.setFavoriteCount(0);
            }

            // 确保 images 字段已经是逗号分隔的字符串
            if (travelNotes.getImages() != null && !travelNotes.getImages().isEmpty()) {
                travelNotes.setImages(travelNotes.getImages());
            }

            System.out.println("Add travelNotes: " + travelNotes);
            travelNotesMapper.insert(travelNotes);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加游记失败", e);
        }
    }

    @Override
    public List<TravelNotes> listFavoritesByUserId(Integer userId) {
        return travelNotesMapper.listFavoritesByUserId(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateTravelNotes(TravelNotes travelNotes) {
        //保留原有的数
        TravelNotes original = travelNotesMapper.selectById(travelNotes.getId());
        if(original != null) {
            travelNotes.setViewCount(original.getViewCount());
            travelNotes.setFavoriteCount(original.getFavoriteCount());
        }

        // 将 List<String> 转换为逗号分隔的字符串
        if (travelNotes.getImages() != null) {
            travelNotes.setImages(String.join(",", travelNotes.getImages()));
        }

        travelNotesMapper.update(travelNotes);
    }


    @Override
    public void unfavoriteTravelNotes(Integer userId, Integer travelNotesId) {
        // 删除收藏记录
        favoriteMapper.unfavoriteTravelNotes(userId, travelNotesId);

        // 查询当前收藏数
        Integer currentFavoriteCount = travelNotesMapper.getFavoriteCount(travelNotesId);

        // 只有当收藏数大于0时才减少
        if (currentFavoriteCount != null && currentFavoriteCount > 0) {
            travelNotesMapper.decreaseFavoriteCount(travelNotesId);
        }
    }

    @Override
    public List<TravelNotes> listByUserId(Integer userId) {
        return travelNotesMapper.selectByUserId(userId);
    }


}