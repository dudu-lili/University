package com.redtourism.util;

import java.io.Serializable;

public class ResponseResult<T> implements Serializable {
    private int code;//状态码
    private String msg;//消息
    private T data;//数据

    //默认成功响应
    public static <T> ResponseResult<T> success() {
        return new ResponseResult<>(200, "操作成功", null);
    }
    //带数据的成功响应
    public static <T> ResponseResult<T> success(T data) {
        return new ResponseResult<>(200, "操作成功", data);
    }
    //带自定义消息的成功响应
    public static <T> ResponseResult<T> success(String msg) {
        return new ResponseResult<>(200, msg, null);
    }
    //带数据和自定义消息的成功响应
    public static <T> ResponseResult<T> success(T data, String msg) {
        return new ResponseResult<>(200, msg, data);
    }
    //默认失败响应
    public static <T> ResponseResult<T> fail() {
        return new ResponseResult<>(500, "操作失败", null);
    }
    //带自定义消息的失败响应
    public static <T> ResponseResult<T> fail(String msg) {
        return new ResponseResult<>(500, msg, null);
    }
    //带自定义状态码和消息的失败响应
    public static <T> ResponseResult<T> fail(int code, String msg) {
        return new ResponseResult<>(code, msg, null);
    }
    //构造函数
    public ResponseResult(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    //Getters and Setters
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}