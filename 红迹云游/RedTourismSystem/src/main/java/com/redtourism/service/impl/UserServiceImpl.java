package com.redtourism.service.impl;

import com.redtourism.entity.User;
import com.redtourism.mapper.UserMapper;
import com.redtourism.service.UserService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

import javax.servlet.http.HttpServletRequest;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private HttpServletRequest request;
    private static final String USER_UPLOAD_DIR = "/assets/images/user/";
    private static final String USER_ACCESS_PATH = "assets/images/user/";

    private final Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);

    @Override
    @Transactional
    public User register(User user) {
        // Check if username exists
        if (userMapper.selectByEmail(user.getEmail()) != null) {
            throw new RuntimeException("Email already exists");
        }

        if (user.getStatus() == null) {
            user.setStatus(1); // Default active status
        }
        char[] passwordChars = user.getPassword().toCharArray();
        String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
        user.setPassword(encryptedPassword);
        System.out.println("user1111:"+user);

        userMapper.insert(user);

        // 清除密码字符数组，防止内存泄漏
        java.util.Arrays.fill(passwordChars, '\0');

        return user;
    }

    @Override
    public User login(String email, String password) {
        User user = userMapper.selectByEmail(email);
//        if (user != null && user.getPassword().equals(password)) {
//            return user;
//        }
        if (user != null) {
            char[] passwordChars = password.toCharArray();
            if (argon2.verify(user.getPassword(), passwordChars)) {
                // 清除密码字符数组，防止内存泄漏
                java.util.Arrays.fill(passwordChars, '\0');
                return user;
            }
            // 清除密码字符数组，防止内存泄漏
            java.util.Arrays.fill(passwordChars, '\0');
        }
        return null;
    }

    @Override
    public User update(User user) {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            // 对新密码进行加密
            char[] passwordChars = user.getPassword().toCharArray();
            String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
            user.setPassword(encryptedPassword);
            // 清除密码字符数组，防止内存泄漏
            java.util.Arrays.fill(passwordChars, '\0');
        }

        int rows = userMapper.update(user);
        if (rows > 0) {
            return userMapper.selectById(user.getId());
        } else {
            return null;
        }
    }

    @Override
    public void addUser(User user) {
        // 对密码进行加密
        char[] passwordChars = user.getPassword().toCharArray();
        String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
        user.setPassword(encryptedPassword);
        // 清除密码字符数组，防止内存泄漏
        java.util.Arrays.fill(passwordChars, '\0');
        if (user.getStatus() == null) {
            user.setStatus(1); // Default active status
        }
        userMapper.insert(user);
    }

    @Override
    public void deleteUser(Integer id) {
        userMapper.delete(id);
    }

    @Override
    public User getById(Integer userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public List<User> getAllUsers() {
        return userMapper.getAllUsers();
    }

    @Override
    public void editUser(User user) {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            // 对新密码进行加密
            char[] passwordChars = user.getPassword().toCharArray();
            String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
            user.setPassword(encryptedPassword);
            // 清除密码字符数组，防止内存泄漏
            java.util.Arrays.fill(passwordChars, '\0');
        }
        //更新用户信息
        userMapper.update(user);
    }

    @Override
    public User getUserById(Integer id) {
        return userMapper.selectById(id);
    }

    @Override
    public int updateUser(User user) {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            // 对新密码进行加密
            char[] passwordChars = user.getPassword().toCharArray();
            String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
            user.setPassword(encryptedPassword);
            // 清除密码字符数组，防止内存泄漏
            java.util.Arrays.fill(passwordChars, '\0');
        }
        return userMapper.updateUser(user);
    }

    @Override
    public User getUserDetail(Integer userId) {
        return userMapper.getUserDetail(userId);
    }

    @Override
    public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
        // 1. 获取用户当前加密密码
        User user = userMapper.selectById(userId);
        if (user == null) return false;

        // 2. 验证旧密码（Argon2验证）
        char[] oldPassChars = oldPassword.toCharArray();
        boolean isOldCorrect = argon2.verify(user.getPassword(), oldPassChars);
        Arrays.fill(oldPassChars, '\0'); // 清除内存

        if (!isOldCorrect) return false;

        // 3. 加密新密码
        char[] newPassChars = newPassword.toCharArray();
        String encryptedNew = argon2.hash(10, 65536, 1, newPassChars);
        Arrays.fill(newPassChars, '\0');

        // 4. 更新数据库
        return userMapper.updatePassword(userId, encryptedNew) > 0;

    }


    @Override
    public List<User> searchUsers(String keyword, Integer page, Integer size) {
        int offset = (page - 1) * size;
        return userMapper.searchUsers(keyword, offset, size);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateStatus(Integer id, Integer status) {
        return userMapper.updateStatus(id, status);
    }
    @Override
    public boolean existsByEmail(String email) {
        return userMapper.selectByEmail(email) != null;
    }

    @Override
    public User findByEmail(String email) {
        return userMapper.selectByEmail(email);
    }

    @Override
    public void updateSmsCode(String email, String code) {
        userMapper.updateSmsCode(email, code, new Date());
    }

    @Override
    public boolean validateEmailCode(User user, String code) {
        if(user == null || user.getSmsCode() == null || user.getSmsCodeTime() == null) {
            return false;
        }
        long timeDiff = System.currentTimeMillis() - user.getSmsCodeTime().getTime();
        return user.getSmsCode().equals(code) && timeDiff <= 5 * 60 * 1000;
    }
    public void updatePasswordByEmail(Integer userId, String newPassword) {
        userMapper.updatePassword(userId, newPassword);
    }

    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(USER_UPLOAD_DIR);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + USER_UPLOAD_DIR;
        }
        return realPath;
    }
        private String saveImage(MultipartFile file) throws IOException, URISyntaxException {
            String uploadDir = getRealUploadPath();
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString() + fileExtension;

            File dest = new File(uploadDir + fileName);
            file.transferTo(dest);

            return fileName;
        }
    @Override
    public ResponseResult<String> uploadAvatar(Integer userId, MultipartFile file) {
        try {
            User user = userMapper.selectById(userId);
            if (user == null) {
                return ResponseResult.fail("用户不存在");
            }

            // 验证图片大小
            if (file.getSize() > 5 * 1024 * 1024) {
                return ResponseResult.fail("图片大小不能超过5MB");
            }

            // 设置图片路径
            String avatarPath = saveImage(file);
            user.setAvatar(USER_ACCESS_PATH + avatarPath);
            userMapper.updateById(user);

            return ResponseResult.success("头像上传成功");
        } catch (Exception e) {
            return ResponseResult.fail("头像上传失败");
        }
    }

    @Override
    public void updateById(User user) {
        if (user == null || user.getId() == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        userMapper.updateById(user);
    }
    @Override
    public User loginByEmail(String email, String password) {
        User user = userMapper.selectByEmail(email);
        if (user != null && argon2.verify(user.getPassword(), password.toCharArray())) {
            return user;
        }
        return null;
    }

    @Override
    public String getUsernameById(Integer userId) {
        if (userId == null) {
            return "匿名用户"; // 或者返回 null
        }
        User user = userMapper.selectById(userId);
        return user != null ? user.getNickname() : "匿名用户";
    }

}
