package com.redtourism.service;

import com.redtourism.entity.Admin;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface AdminService {
    Admin login(String username, String password);
    void batchDeleteUsers(List<Integer> userIds);
    //+++++
    Admin getById(Integer id);
    Admin getByUsername(String username);


}