package com.redtourism.entity;

import lombok.Data;

@Data
public class Video {
    private Integer id;
    private String title;
    private String description;
    private String coverImage;
    private String videoUrl;
    private Integer viewCount;
    private String duration;
    private String createTime;
    private String category; // 新增分类字段
//    private Integer likeCount;
    private boolean liked = false;
    private int likeCount = 0;
    private double score;

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }


    // Getter / Setter
    public boolean isLiked() { return liked; }
    public void setLiked(boolean liked) { this.liked = liked; }

    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }


    @Override
    public String toString() {
        return "Video{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", coverImage='" + coverImage + '\'' +
                ", viewCount=" + viewCount +
                ", category='" + category + '\'' + // 更新 toString 方法以包含 category 字段
                '}';
    }
}