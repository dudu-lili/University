package com.redtourism.mapper;

import com.redtourism.entity.Video;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface VideoMapper {
    // 基本CRUD操作
    List<Video> selectAll();
    Video selectById(Integer id);
    int insert(Video video);
    int update(Video video);
    int delete(Integer id);

    // 视频分类和筛选
    List<Video> selectByCategory(@Param("category") String category);
    List<Video> searchVideos(@Param("keyword") String keyword);

    int increaseLikeCount(Integer id);
    int decreaseLikeCount(Integer id);

    int increaseViewCount(Integer id);

    void batchDelete(@Param("videoIds") List<Integer> videoIds);
    // 用户点赞相关方法
    int checkIfUserLikedVideo(@Param("userId") Integer userId, @Param("videoId") Integer videoId);
    void recordUserLikeVideo(@Param("userId") Integer userId, @Param("videoId") Integer videoId);
    void cancelUserLikeVideo(@Param("userId") Integer userId, @Param("videoId") Integer videoId);
    int getLikeCount(@Param("id") Integer videoId);

    List<Video> selectSameCategoryVideosExcludeSelf(@Param("excludeId") Integer excludeId,
                                                    @Param("category") String category);
    @Select("SELECT AVG(like_count) FROM video")
    Double getAverageLikeCount();

}