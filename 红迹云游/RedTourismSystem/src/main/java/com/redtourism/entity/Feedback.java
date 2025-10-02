package com.redtourism.entity;

import lombok.Data;
import java.util.Date;

@Data
public class Feedback {
    private Integer feedbackId;
    private Integer userId;//反馈的用户id
    private String feedbackType;//反馈类型
    private String content;//反馈类容
    private String status = "pending"; // 默认状态
    private Integer adminId;//管理员id
    private Date processTime;//处理时间
    private Date resolveTime;// 解决时间
    private Date createTime;// 创建时间

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}