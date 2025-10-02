package com.redtourism.entity;

import lombok.Data;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class TravelNotes {
    private Integer id;
    private String title;
    private String author;
    private String content;
    private Integer viewCount; // 注意字段名大小写
    private Integer favoriteCount; // 注意字段名大小写
    private String createtime;
    private String place;
    private String images; // 注意字段名大小写
    private String banImage;  //头图
    private String video;
    private Integer userId;

    @Override
    public String toString() {
        return "travelNotes{" +
                "id=" + id +
                ", name='" + title + '\'' +
                ", images='" + images + '\'' +
                ", content='" + content + '\'' +
                ", viewCount='" + viewCount + '\'' +
                ", favoriteCount='" + favoriteCount + '\'' +
                ", author='" + author + '\'' +
                ", createtime='" + createtime  + '\'' +
                ", place='" + place  + '\'' +
                ", banImage='" + banImage  + '\'' +
                ", video='" + video  + '\'' +
                ", userId='" + userId  + '\'' +
                '}';
    }
}

