package com.redtourism.entity;

import java.util.Date;

public class Favorite {
    private Integer id;
    private Integer userId;
    private Integer scenicId;
    private Integer routeId;
    private Integer travelNotesId;
    private Date createTime;

    //getters and setters
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

    public Integer getTravelNotesId() {
        return travelNotesId;
    }

    public void setTravelNotesId(Integer travelNotesId) {
        this.travelNotesId = travelNotesId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}