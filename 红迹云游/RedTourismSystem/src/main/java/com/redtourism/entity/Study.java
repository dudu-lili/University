package com.redtourism.entity;

import lombok.Data;

@Data
public class Study {
    private Integer id;
    private String title;
    private String author;
    private String content;
    private Integer viewCount; // 注意字段名大小写
    private String source;
    private String time;
    private String coverImage; // 注意字段名大小写

    @Override
    public String toString() {
        return "Study{" +
                "id=" + id +
                ", name='" + title + '\'' +
                ", coverImage='" + coverImage + '\'' +
                ", content='" + content + '\'' +
                ", viewCount='" + viewCount + '\'' +
                ", source=" + source +
                ", author='" + author + '\'' +
                ", time='" + time  + '\'' +
                '}';
    }

}
