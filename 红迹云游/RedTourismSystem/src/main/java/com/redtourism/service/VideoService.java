package com.redtourism.service;

import com.redtourism.entity.Video;
import java.util.List;

public interface VideoService {
    List<Video> listAll();
    Video getById(Integer id);
    void addVideo(Video video);
    void updateVideo(Video video);
    void deleteVideo(Integer id);
    void batchDelete(List<Integer> videoIds);
    int increaseViewCount(Integer id);
    void increaseLikeCount(Integer id);
    void decreaseLikeCount(Integer id);
    List<Video> listByCategory(String category);
    List<Video> searchVideos(String keyword);
    List<Video> getRelatedVideos(Integer id);

    boolean checkIfUserLikedVideo(Integer id, Integer videoId);

    void cancelUserLikeVideo(Integer id, Integer videoId);

    void recordUserLikeVideo(Integer id, Integer videoId);

    int getLikeCount(Integer videoId);
    List<Video> getSameCategoryVideosExcludeSelf(Integer excludeId, String category);
    Double getAverageLikeCount();


}