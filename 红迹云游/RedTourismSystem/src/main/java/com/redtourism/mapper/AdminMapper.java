package com.redtourism.mapper;

import com.redtourism.entity.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    int insert(Admin admin);
    int deleteById(Integer id);
    int update(Admin admin);
    Admin selectById(Integer id);
    Admin selectByUsername(String username);
    int updatePassword(@Param("id") Integer id, @Param("password") String password);

    int batchDelete(@Param("userIds") List<Integer> userIds);
}