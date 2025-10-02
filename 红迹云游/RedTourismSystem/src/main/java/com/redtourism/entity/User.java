package com.redtourism.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Lob;
import java.text.SimpleDateFormat;
import java.util.Date;
@Data
public class User {
    private Integer id;
    private String email;
    private String password;
    private String nickname;
    private Integer gender;
    private Date birthday;
    private String phone;
    private String address;
    private String signature;
    private Integer status;
    private String smsCode;  // 短信验证码
    private Date smsCodeTime; // 验证码发送时间
    private String avatar;
    //4.27
    @Column(name = "create_time")
    private Date createTime;
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public boolean isActive() {
        return status != null && status == 1;
    }


    public String getSmsCode() {
        return smsCode;
    }

    public void setSmsCode(String smsCode) {
        this.smsCode = smsCode;
    }

    public Date getSmsCodeTime() {
        return smsCodeTime;
    }

    public void setSmsCodeTime(Date smsCodeTime) {
        this.smsCodeTime = smsCodeTime;
    }

    public String getFormattedBirthday() {
        if (this.birthday == null) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(this.birthday);
    }
    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }



}