package com.redtourism.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.persistence.Transient;
import java.util.Base64;
@Data
public class ScenicSpot {
    private Integer id;
    private String name;
    private String coverImage;
    private String description;
    private String address;
    private Integer likeCount;
    private String level;
    private String province;
    private String city;
    private String openningHours;
    private String ticketInfo;
    private String keywords;
    // 纬度 (范围 -90 到 90)4.13
    private Double latitude;

    // 经度 (范围 -180 到 180)4.13
    private Double longitude;

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }
    //距离3.13
    @Transient
    private Double distance;

    public Double getDistance() {
        return distance;
    }

    public void setDistance(Double distance) {
        this.distance = distance;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getOpenningHours() {
        return openningHours;
    }

    public void setOpenningHours(String openningHours) {
        this.openningHours = openningHours;
    }

    public String getTicketInfo() {
        return ticketInfo;
    }

    public void setTicketInfo(String ticketInfo) {
        this.ticketInfo = ticketInfo;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }
    //-----------------------------------------------

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    @Override
    public String toString() {
        return "ScenicSpot{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", coverImage='" + coverImage + '\'' +
                ", description='" + description + '\'' +
                ", address='" + address + '\'' +
                ", likeCount=" + likeCount +
                ", level='" + level + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", openningHours='" + openningHours + '\'' +
                ", ticketInfo='" + ticketInfo + '\'' +
                ", keywords='" + keywords + '\'' +
                '}';
    }
}