package com.redtourism.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer userId;
    private Integer scenicId;
    private Integer routeId;
    private Integer studyId;
    private Integer travelNotesId;
    private String content;
    private Date createTime;
    private User user; //评论用户信息
    private ScenicSpot scenicSpot; //关联景点信息

    //Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getScenicId() {
        return scenicId;
    }

    public void setScenicId(Integer scenicId) {
        this.scenicId = scenicId;
    }

    public Integer getRouteId() {
        return routeId;
    }

    public void setRouteId(Integer routeId) {
        this.routeId = routeId;
    }

    public Integer getStudyId() {
        return studyId;
    }

    public void setStudyId(Integer studyId) {
        this.studyId = studyId;
    }
    public Integer getTravelNotesId() {
        return travelNotesId;
    }
    public void setTravelNotesId(Integer travelNotesId) {
        this.travelNotesId = travelNotesId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ScenicSpot getScenicSpot() {
        return scenicSpot;
    }

    public void setScenicSpot(ScenicSpot scenicSpot) {
        this.scenicSpot = scenicSpot;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", userId=" + userId +
                ", scenicId=" + scenicId +
                ", routeId=" + routeId +
                ", studyId=" + studyId +
                ", travelNotesId=" + travelNotesId +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                ", user=" + (user != null ? user.toString() : "null") +
                ", scenicSpot=" + (scenicSpot != null ? scenicSpot.toString() : "null") +
                '}';
    }
}