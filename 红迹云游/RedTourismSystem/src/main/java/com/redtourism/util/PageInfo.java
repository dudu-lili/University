package com.redtourism.util;

import java.util.List;

public class PageInfo<T> {
    private int pageNum;
    private int pageSize;
    private int total;
    private List<T> list;

    public PageInfo(int pageNum, int pageSize, int total, List<T> list) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.total = total;
        this.list = list;
    }

    //Getters and Setters
    public int getPageNum() { return pageNum; }
    public void setPageNum(int pageNum) { this.pageNum = pageNum; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
    public List<T> getList() { return list; }
    public void setList(List<T> list) { this.list = list; }
}