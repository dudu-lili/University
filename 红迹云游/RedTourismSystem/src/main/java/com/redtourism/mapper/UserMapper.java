package com.redtourism.mapper;

import com.redtourism.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface UserMapper {
    int insert(User user);
    User selectById(Integer id);
    User selectByEmail(String email);
    int update(User user);
    void delete(Integer id);//删除用户
    List<User> getAllUsers();//获取所有用户

    int updateUser(User user);
    User getUserDetail(Integer userId);
    int changePassword(@Param("userId") Integer userId,
                       @Param("oldPassword") String oldPassword,
                       @Param("newPassword") String newPassword);
    List<User> searchUsers(@Param("keyword") String keyword,
                           @Param("offset") Integer offset,
                           @Param("size") Integer size);

    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    User selectByPhone(String phone);
    int updateSmsCode(@Param("email") String email,
                      @Param("smsCode") String smsCode,
                      @Param("smsCodeTime") Date smsCodeTime);
    int updatePassword(@Param("userId") Integer userId,
                       @Param("newPassword") String newPassword);

    int updateById(@Param("user") User user);
    int updateAvatar(@Param("userId") Integer userId, @Param("avatar") String avatar);

//    int updateAvatar(@Param("userId") Integer userId, @Param("avatar") byte[] avatar);
}
