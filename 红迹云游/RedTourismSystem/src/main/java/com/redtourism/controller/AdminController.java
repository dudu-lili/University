package com.redtourism.controller;

import com.redtourism.entity.Admin;
import com.redtourism.service.AdminService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @PostMapping("/login")
    public ResponseResult<Admin> login(@RequestBody Admin admin, HttpSession session) {
        //检查用户名或密码是否为空
        if (admin.getUsername() == null || admin.getUsername().trim().isEmpty()) {
            return ResponseResult.fail("账号不能为空");
        }
        if (admin.getPassword() == null || admin.getPassword().trim().isEmpty()) {
            return ResponseResult.fail("密码不能为空");
        }

        try {
            Admin loggedInAdmin = adminService.login(admin.getUsername(), admin.getPassword());
            if (loggedInAdmin == null) {
                return ResponseResult.fail("账号或密码错误");
            }
            session.setAttribute("admin", loggedInAdmin);
            return ResponseResult.success(loggedInAdmin);
        } catch (Exception e) {
            return ResponseResult.fail("登录失败，请稍后再试");
        }
    }

    @PostMapping("/logout")
    public ResponseResult<Void> logout(HttpSession session) {
        session.removeAttribute("admin");
        return ResponseResult.success();
    }

    @GetMapping("/info")
    public ResponseResult<Admin> getInfo(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        return ResponseResult.success(admin);
    }
    @PostMapping("/user/batch-delete")
    public ResponseResult<Void> batchDeleteUsers(@RequestBody Map<String, List<Integer>> request) {
        try {
            List<Integer> userIds = request.get("userIds");
            if (userIds == null || userIds.isEmpty()) {
                return ResponseResult.fail("请选择要删除的用户");
            }

            adminService.batchDeleteUsers(userIds);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("批量删除失败: " + e.getMessage());
        }
    }

}