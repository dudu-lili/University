package com.redtourism.service;

import com.redtourism.entity.News;
import com.redtourism.util.ResponseResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NewsService {
    List<News> listAll();
    List<News> listTopNews(int limit);
    News getById(Integer id);
    void addNews(News news);
    int updateNews(News news);
    void deleteNews(Integer id);
//    void increaseViewCount(Integer id);
    void increaseViewCount(Integer newsId);
    int getViewCount(Integer newsId);
    ResponseResult<String> uploadCoverImage(Integer id, MultipartFile file);

    void batchDeleteNews(List<Integer> newsIds);

}