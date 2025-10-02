package com.redtourism.service;

import com.redtourism.entity.User;
import com.redtourism.util.ResponseResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserService {
    // 用户基础操作
    User register(User user);
    User login(String email, String password); // 修改为 email


    // 用户信息管理
    User getUserDetail(Integer userId);
    User getUserById(Integer id);
    List<User> getAllUsers();
    List<User> searchUsers(String keyword, Integer page, Integer size);

    // 用户信息修改
    User update(User user);
    void updateById(User user);
    void editUser(User user);
    int updateUser(User user);

    // 密码相关
    boolean changePassword(Integer userId, String oldPassword, String newPassword);
    void updatePasswordByEmail(Integer userId, String newPassword);

    // 头像上传
    ResponseResult<String> uploadAvatar(Integer userId, MultipartFile file);


    // 用户状态管理
    int updateStatus(Integer userId, Integer status);

    // 验证相关
    boolean existsByEmail(String email); // 修改为 email
    User findByEmail(String email); // 修改为 email
    void updateSmsCode(String email, String code); // 修改为 email
    boolean validateEmailCode(User user, String emailCode); // 修改为 emailcode);

    // 用户增删
    void addUser(User user);
    void deleteUser(Integer id);

    User getById(Integer userId);

    User loginByEmail(String email, String password);

    String getUsernameById(Integer userId);

}
