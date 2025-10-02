package com.redtourism.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/jsp/admin/*", dispatcherTypes = DispatcherType.REQUEST)
public class AdminAccessFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession(false);

        // 允许访问管理员登录页面
        if (requestURI.endsWith("login-admin.jsp")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 检查管理员是否已登录（session 中存在 "admin" 属性）
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/admin/login-admin.jsp");
            return;
        }

        // 已登录，继续处理请求
        filterChain.doFilter(request, response);
    }
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化方法，可用于加载资源等操作
    }

    @Override
    public void destroy() {
        // 销毁方法，可用于释放资源等操作
    }
}