package com.redtourism.service.impl;

import com.redtourism.entity.Video;
import com.redtourism.mapper.VideoMapper;
import com.redtourism.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    private VideoMapper videoMapper;

    @Override
    public List<Video> listAll() {
        return videoMapper.selectAll();
    }

    @Override
    public Video getById(Integer id) {
        return videoMapper.selectById(id);
    }

    @Override
    public List<Video> listByCategory(String category) {
        return videoMapper.selectByCategory(category);
    }

    @Override
    public List<Video> searchVideos(String keyword) {
        return videoMapper.searchVideos(keyword);
    }

    @Override
    @Transactional
    public int increaseViewCount(Integer id) {
        // 添加日志记录，方便调试
        System.out.println("正在增加视频ID为 " + id + " 的浏览数");
        int rowsAffected = videoMapper.increaseViewCount(id);
        System.out.println("受影响的行数: " + rowsAffected);
        return rowsAffected;
    }
    @Override
    public void increaseLikeCount(Integer id) {
        videoMapper.increaseLikeCount(id);
    }

    @Override
    public void decreaseLikeCount(Integer id) {
        videoMapper.decreaseLikeCount(id);
    }

    @Override
    public void addVideo(Video video) {
        videoMapper.insert(video);
    }

    @Override
    public void updateVideo(Video video) {
        videoMapper.update(video);
    }

    @Override
    public void deleteVideo(Integer id) {
        videoMapper.delete(id);
    }

    @Override
    public List<Video> getRelatedVideos(Integer id) {
        Video video = videoMapper.selectById(id);
        if (video != null) {
            return videoMapper.selectByCategory(video.getCategory());
        }
        return Collections.emptyList();
    }

    @Override
    public void batchDelete(List<Integer> videoIds) {
        videoMapper.batchDelete(videoIds);
    }
    // 新增：用户点赞相关实现
    @Override
    public boolean checkIfUserLikedVideo(Integer userId, Integer videoId) {
        int count = videoMapper.checkIfUserLikedVideo(userId, videoId);
        return count > 0;
    }

    @Override
    public void recordUserLikeVideo(Integer userId, Integer videoId) {
        videoMapper.recordUserLikeVideo(userId, videoId);
    }

    @Override
    public void cancelUserLikeVideo(Integer userId, Integer videoId) {
        videoMapper.cancelUserLikeVideo(userId, videoId);
    }

    @Override
    public int getLikeCount(Integer videoId) {
        return videoMapper.getLikeCount(videoId);
    }
    @Override
    public List<Video> getSameCategoryVideosExcludeSelf(Integer excludeId, String category) {
        return videoMapper.selectSameCategoryVideosExcludeSelf(excludeId, category);
    }

    @Override
    public Double getAverageLikeCount() {
        return videoMapper.getAverageLikeCount();
    }

}