package com.redtourism.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Lob;
import java.util.Arrays;
@Data
public class TravelRoute {
    private Integer id;
    private String name;
    private String coverImage;
    private String description;
    private Integer likeCount;


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

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }
//getters and setters


    @Override
    public String toString() {
        return "TravelRoute{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", coverImage='" + coverImage + '\'' +
                ", description='" + description + '\'' +
                ", likeCount=" + likeCount +
                '}';
    }
}