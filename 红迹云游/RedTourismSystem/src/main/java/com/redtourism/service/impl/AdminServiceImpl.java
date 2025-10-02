package com.redtourism.service.impl;

import com.redtourism.mapper.AdminMapper;
import com.redtourism.entity.Admin;
import com.redtourism.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(String username, String password) {
        Admin admin = adminMapper.selectByUsername(username);
        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }
    @Override
    @Transactional
    public void batchDeleteUsers(List<Integer> userIds) {
        if (userIds == null || userIds.isEmpty()) {
            throw new IllegalArgumentException("用户ID列表不能为空");
        }

        // 批量删除用户
        adminMapper.batchDelete(userIds);
    }
    //新加+++++==
    @Override
    public Admin getById(Integer id) {
        return adminMapper.selectById(id);
    }

    @Override
    public Admin getByUsername(String username) {
        return adminMapper.selectByUsername(username);

    }


}