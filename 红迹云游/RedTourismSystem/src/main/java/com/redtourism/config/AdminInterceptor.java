package com.redtourism.config;

import com.redtourism.entity.Admin;
import com.redtourism.util.ResponseResult;
import com.alibaba.fastjson.JSON;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

public class AdminInterceptor implements HandlerInterceptor {

    private static final List<String> EXCLUDE_PATHS = Arrays.asList(
            "/scenic/add",
            "/scenic/update",
            "/admin/login"
    );

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //排除不需要拦截的路径
        String path = request.getRequestURI().substring(request.getContextPath().length());
        if (EXCLUDE_PATHS.contains(path)) {
            return true;
        }

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JSON.toJSONString(ResponseResult.fail(401, "请先登录管理员账号")));
            return false;
        }
        return true;
    }
}