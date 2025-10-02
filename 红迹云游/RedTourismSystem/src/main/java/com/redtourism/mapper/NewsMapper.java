package com.redtourism.mapper;

import com.redtourism.entity.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsMapper {
    List<News> selectAll();
    News selectById(Integer id);
    int insert(News news);
    int update(News news);
    int delete(Integer id);

    void increaseViewCount(@Param("newsId") Integer newsId);
    List<News> selectTopNews(int limit);

    int getViewCount(@Param("newsId") Integer newsId);
    int updateCoverImage(@Param("id") Integer id, @Param("coverImage") byte[] coverImage);

    int batchDelete(@Param("newsIds") List<Integer> newsIds);

}