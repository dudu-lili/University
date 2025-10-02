package com.redtourism.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Lob;
@Data
public class News {
    private Integer id;
    private String title;
    private String coverImage;
    private String source;
    private String content;
    private String article;
    private String author;
    private String publishTime;
    private Integer viewCount;

    public  String getSource(){
        return source;
    }
    public void  setSource(String source){
        this.source = source;
    }
    // getters and setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getArticle() {
        return article;
    }

    public void  setArticle(String article){
        this.article = article;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    @Override
    public String toString() {
        return "News{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", author='" + author + '\'' +
                ", publishTime=" + publishTime +
                ", viewCount=" + viewCount +
                '}';
    }
}