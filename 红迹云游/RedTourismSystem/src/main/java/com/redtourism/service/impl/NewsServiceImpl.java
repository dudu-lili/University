package com.redtourism.service.impl;

import com.redtourism.entity.News;
import com.redtourism.mapper.NewsMapper;
import com.redtourism.service.NewsService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {

    @Autowired
    private NewsMapper newsMapper;

    @Override
    public List<News> listAll() {
        return newsMapper.selectAll();
    }

    @Override
    public List<News> listTopNews(int limit) {
        return newsMapper.selectTopNews(limit);
    }

    @Override
    public News getById(Integer id) {
        return newsMapper.selectById(id);
    }

    @Override
    public void addNews(News news) {
        newsMapper.insert(news);
    }

    @Override
    public int updateNews(News news) {
        News existingNews = newsMapper.selectById(news.getId());
        if (existingNews != null) {
            news.setViewCount(existingNews.getViewCount());
        }
        return newsMapper.update(news);
    }

    @Override
    public int getViewCount(Integer newsId){

        return newsMapper.getViewCount(newsId);
    }

    @Override
    public void deleteNews(Integer id) {
        newsMapper.delete(id);
    }

    @Override
    public void increaseViewCount(Integer newId)
    {
        newsMapper.increaseViewCount(newId);

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

            int result = newsMapper.updateCoverImage(id, file.getBytes());
            if (result > 0) {
                return ResponseResult.success("新闻封面图片上传成功");
            }
            return ResponseResult.fail("新闻封面图片更新失败");
        } catch (IOException e) {
            return ResponseResult.fail("图片上传失败: " + e.getMessage());
        }
    }
    @Override
    @Transactional
    public void batchDeleteNews(List<Integer> newsIds) {
        if (newsIds == null || newsIds.isEmpty()) {
            throw new IllegalArgumentException("新闻ID列表不能为空");
        }
        newsMapper.batchDelete(newsIds);
    }

}