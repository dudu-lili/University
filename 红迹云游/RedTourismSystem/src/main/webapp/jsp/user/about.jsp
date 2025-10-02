<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 关于我们</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 保持原有样式不变 -->
    <style>

        /* 适配导航栏固定定位 */
        body {
            padding-top: 82px; /* 与导航栏高度一致 */
            padding-bottom: 80px; /* 页脚固定时的底部边距 */
        }


        /* --------------------------- 导航栏样式（与首页统一） --------------------------- */
        /* 导航栏整体容器 */
        .navbar {
            background-color: #90201f !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: fixed; /* 固定定位，确保高度生效 */
            width: 100%;
            /*height: 82px; !* 明确高度，与 body padding 一致 *!*/
            z-index: 1000;
        }

        /* 导航链接通用样式 */
        .nav-link {
            color: white !important;
            font-weight: bold;
            padding: 0 15px; /* 左右内边距 */
            height: 50px; /* 关键：与导航栏等高 */
            display: flex;
            align-items: center; /* 垂直居中 */
            transition: color 0.3s;
        }

        /* Logo 样式 */
        .navbar-brand {
            display: flex;
            align-items: center;
            height: 100%;
            padding: 0; /* 清除默认内边距 */
        }

        .navbar-brand img {
            height: 56px; /* 与首页 Logo 高度一致（原代码中为40px，建议统一为56px） */
            margin-right: 10px;
        }
        .nav-link:hover {
            color: #ffc107 !important; /* 悬停黄色 */
            background-color: rgba(255, 255, 255, 0.1); /* 悬停半透明背景（与首页一致） */
        }
        /* 当前页激活样式（带底部指示线） */
        .nav-link.active {
            color: #ffc107 !important;
            font-weight: 600;
            position: relative;
            border-radius: 4px;
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 3px;
            background: #ffc107;
            border-radius: 2px; /* 底部黄色指示线 */
        }

        /* 头像样式 */
        .avatar-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 头像阴影 */
        }

        /*高亮显示当前模块框-------------------------------*/
        /* 导航栏当前页高亮样式 */
        .navbar-nav .nav-link.active {
            position: relative;
            background-color: rgba(255,255,255,0.15) !important;
            color: #ffc107 !important;
            border-radius: 4px;
            font-weight: 600;
        }

        /* 添加底部指示线（可选增强效果） */
        .navbar-nav .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 3px;
            background: #ffc107;
            border-radius: 2px;
        }

        /* 悬停效果保持协调 */
        .navbar-nav .nav-link:hover {
            color: #ffc107 !important;
            background-color: rgba(255,255,255,0.1);
        }

        /* 调整卡片布局避免按钮消失后的空隙---------------- */
        .card-body > div {
            justify-content: flex-end;
        }

        .carousel-item {
            height: 500px;
            background-color: #777;
        }
        .carousel-item img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }
        .section-title {
            color: #B3100f;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #B3100f;
            padding-left: 15px;
        }
        .card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-img-top {
            height: 180px;
            object-fit: cover;
        }
        .card-title {
            font-weight: bold;
            color: #333;
        }
        .btn-action {
            padding: 5px 10px;
            font-size: 12px;
        }

        /*类容区域样式------------------------------------*/
        /* 保留原有样式不变，新增以下样式 */
        .about-container {
            background: #f8f9fa;
            padding: 40px 0;
            margin-top: 20px;
        }

        .about-nav {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            z-index: 999;
        }

        .about-nav-link {
            display: block;
            padding: 12px 20px;
            color: #333;
            border-left: 3px solid transparent;
            transition: all 0.3s;
            text-decoration: none;
        }

        .about-nav-link:hover {
            background: #f8f9fa;
            border-left: 3px solid #B3100f;
            color: #B3100f;
        }

        .about-nav-link.active {
            background: #B3100f1a;
            border-left: 3px solid #B3100f;
            color: #B3100f;
            font-weight: 500;
        }

        .about-content {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            min-height: 400px;
        }

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .contact-item {
            margin: 15px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 6px;
        }

        /*"网站布局"模块样式--------------------*/
        .sitemap-list {
            columns: 2;
            gap: 20px;
            margin-top: 20px;
        }

        .sitemap-list ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sitemap-list li {
            margin-bottom: 10px;
            position: relative;
            padding-left: 20px; /* 增加左侧间距 */
            min-height: 24px; /* 保证行高一致 */
        }

        .sitemap-list li::before {
            content: "•";
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%); /* 垂直居中 */
            color: #B3100f;
            font-size: 1.5em;
            line-height: 1;
        }

        .sitemap-list a {
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
            font-size: 0.95em;
            padding: 5px 10px;
            border-radius: 4px;
            display: inline-flex; /* 改用flex布局 */
            align-items: center; /* 垂直居中 */
            min-height: 32px; /* 统一链接高度 */
        }

        .sitemap-list a:hover {
            background: #B3100f1a;
            color: #B3100f;
            transform: translateX(5px);
        }


        /* 页脚样式 ----------------------------------------------*/
        .footer-link {
            color: rgba(255,255,255,0.8) !important;
            font-size: 0.95em;
            line-height: 2.2;
            transition: color 0.3s;
            text-decoration: none; /* 添加这行代码去除下划线 */
        }

        .footer-link:hover {
            color: white !important;
            text-decoration: none;
            text-decoration: none; /* 悬停时也保持无下划线 */
        }

        .footer-nav {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
        }

        .footer-nav-link {
            color: rgba(255,255,255,0.8) !important;
            font-size: 0.9em;
            transition: color 0.3s;
            text-decoration: none;
        }

        .footer-nav-link:hover {
            color: white !important;
        }

        /* 调整原有页脚样式（关键修改） */
        footer {
            background-color: #8b1515 !important; /* 改为红色主题 */
            margin-top: 0; /* 移除顶部边距 */
            position: fixed; /* 固定定位到视口底部 */
            left: 0;
            bottom: 0;
            right: 0;
            padding: 15px 0; /* 压缩页脚自身高度 */
        }

        /* 移除页脚顶部的渐变线（与首页保持一致） */
        footer::before {
            display: none;
        }

        /* 统一所有锚点链接样式 */
        a[href^="#"] {
            cursor: pointer;
            text-decoration: none !important;
            transition: all 0.3s;
        }

        a[href^="#"]:hover {
            color: #B3100f !important;
            transform: translateX(3px);
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <!-- 将文字替换为Logo图片 -->
        <a class="navbar-brand" href="index.jsp">
            <img src="${pageContext.request.contextPath}/assets/images/banners/logo2.png" alt="红色旅游" height="56">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">首页</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="scenicDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        景点信息
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="scenicDropdown">
                        <li><a class="dropdown-item" href="scenic-list.jsp">景点智选</a></li>
                        <li><a class="dropdown-item" href="scenic-list-recommend.jsp">景点智荐</a></li>
                        <li><a class="dropdown-item" href="red-Geocoding.jsp">全国景点地图展示</a></li>
                    </ul>
                </li>

                <!-- 路线信息菜单 -->
                <%--                <li class="nav-item dropdown">--%>
                <%--                    <a class="nav-link dropdown-toggle" href="#" id="routeDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">--%>
                <%--                        路线信息--%>
                <%--                    </a>--%>
                <%--                    <ul class="dropdown-menu" aria-labelledby="routeDropdown">--%>
                <%--                        <li><a class="dropdown-item" href="route-list.jsp">旅游路线</a></li>--%>
                <%--                        <li><a class="dropdown-item" href="route-list-recommend.jsp">路线推荐</a></li>--%>
                <%--                    </ul>--%>
                <%--                </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="route-list-recommend.jsp">路线智荐</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="studyDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        红色研学
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="routeDropdown">
                        <li><a class="dropdown-item" href="study-list.jsp">研学活动</a></li>
                        <li><a class="dropdown-item" href="video-list.jsp">影像课堂</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="travelnotes-list.jsp">游记论坛</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="news-list.jsp">新闻公告</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  active" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <img src="${pageContext.request.contextPath}/user/avatar/${user.id}?t=<%=System.currentTimeMillis()%>"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar.png'"
                             class="avatar-circle"
                             alt="用户头像">
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="loadUserCenterData(event)">个人中心</a></li>
                        <li><a class="dropdown-item" href="#" onclick="logout()">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-5 pt-4">
    <div class="row about-container">
        <!-- 左侧导航栏 -->
        <div class="col-md-3">
            <div class="about-nav sticky-top" style="top: 80px;">
                <a href="#intro" class="about-nav-link active">网站介绍</a>
                <a href="#contact" class="about-nav-link">联系方式</a>
                <a href="#feedback" class="about-nav-link">意见反馈</a>
                <a href="#copyright" class="about-nav-link">版权声明</a>
                <a href="#privacy" class="about-nav-link">隐私声明</a>
                <a href="#sitemap" class="about-nav-link">网站地图</a>
            </div>
        </div>

        <!-- 右侧内容区 -->
        <div class="col-md-9">
            <div class="about-content">
                <!-- 机构介绍 -->
                <div id="intro" class="content-section active">
                    <h3 class="section-title mb-4">网站介绍</h3>
                    <p>红色旅游系统是专注于红色文化传承与旅游服务的专业平台，致力于整合全国红色旅游资源，提供：</p>
                    <ul>
                        <li>权威的红色景点信息查询</li>
                        <li>专业的红色研学路线规划</li>
                        <li>丰富的红色文化教育内容</li>
                        <li>便捷的旅游服务预订功能</li>
                    </ul>
                    <p>系统由xxxxx指导，xxxxxxx提供学术支持，汇聚了全国n+红色教育基地资源，服务超过m用户。</p>
                </div>

                <!-- 联系方式 -->
                <div id="contact" class="content-section">
                    <h3 class="section-title mb-4">联系方式</h3>
                    <div class="contact-item">
                        <h5>客服热线</h5>
                        <p>xxx-xxx-xxxx（工作日 9:00-18:00）</p>
                    </div>
                    <div class="contact-item">
                        <h5>电子邮箱</h5>
                        <p>service@redtourism.com.cn</p>
                    </div>
                    <div class="contact-item">
                        <h5>通信地址</h5>
                        <p>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</p>
                    </div>
                </div>

                <!-- 意见反馈 -->
                <div id="feedback" class="content-section">
                    <h3 class="section-title mb-4">意见反馈</h3>
                    <!-- 添加表单 ID 和隐藏的标题字段 -->
                    <form id="feedbackForm">
                        <div class="mb-3">
                            <label class="form-label">反馈类型</label>
                            <select class="form-select" id="feedbackType" name="feedbackType"> <!-- 添加 name 属性 -->
                                <option value="功能建议">功能建议</option>
                                <option value="内容纠错">内容纠错</option>
                                <option value="合作咨询">合作咨询</option>
                                <option value="其他">其他</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">详细描述</label>
                            <textarea class="form-control" id="feedbackContent" rows="5" placeholder="请输入您的宝贵意见（不超过1000字）"></textarea>
                        </div>
                        <!-- 添加隐藏的标题字段（根据后端需求，若无标题字段可忽略） -->
                        <%--<input type="hidden" id="feedbackTitle" value="用户反馈">--%>
                        <button type="submit" class="btn btn-danger">提交反馈</button>
                    </form>
                </div>

                <!-- 版权声明 -->
                <div id="copyright" class="content-section">
                    <h3 class="section-title mb-4">版权声明</h3>
                    <p>本网站所有内容（包括但不限于文字、图片、音频、视频）的版权均归红色旅游系统及相应权利人所有。未经书面授权，任何单位或个人不得以任何形式转载、摘编、复制或建立镜像。</p>
                    <p>对于侵权行为，本系统将依法追究法律责任。如需转载或使用本站内容，请通过以下方式联系我们获取授权：</p>
                    <p>授权邮箱：copyright@redtourism.com.cn</p>
                </div>
                <%--隐私声明--%>
                <div id="privacy" class="content-section">
                    <h3 class="section-title mb-4">隐私声明</h3>
                    <p>红色旅游系统高度重视用户隐私保护，我们郑重承诺：</p>
                    <ul>
                        <li>严格遵守《中华人民共和国网络安全法》等相关法律法规</li>
                        <li>仅收集实现服务所必需的最少用户信息</li>
                        <li>未经用户同意不向第三方共享用户个人信息</li>
                        <li>采用行业领先的数据加密技术保护用户数据安全</li>
                    </ul>
                    <p>具体隐私条款详见<a href="privacy.jsp">《隐私政策》</a>完整文件</p>
                </div>

                <!-- 网站地图 -->
                <div id="sitemap" class="content-section">
                    <h3 class="section-title mb-4">网站地图</h3>
                    <div class="sitemap-list">
                        <ul>
                            <li><a href="index.jsp">首页</a></li>
                            <li><a href="scenic-list-recommend.jsp">景点信息</a></li>
                            <li><a href="scenic-list.jsp">景点智选</a></li>
                            <li><a href="route-list-recommend.jsp">旅游路线</a></li>
                            <li><a href="red-Geocoding.jsp">全国景点地图展示</a></li>
                        </ul>
                        <ul>
                            <li><a href="study-list.jsp">红色研学</a></li>
                            <li><a href="news-list.jsp">新闻公告</a></li>
                            <li><a href="#">游记论坛</a></li>
                            <li><a href="about.jsp">关于我们</a></li>
                            <li><a href="privacy.jsp">隐私政策</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<footer class="text-center" style="background-color: #8b1515; color: white; padding: 20px 0 10px;">
    <div class="container">
        <!-- 原 mt-5（margin-top:20px）改为 mt-1（margin-top:4px）或 mt-2（margin-top:8px），按需选择 -->
        <div class="row mt-2">
            <div class="col-12">
                <div class="footer-nav" style="margin-top: 10px; gap: 10px;">
                    <a href="about.jsp#intro" class="footer-nav-link">关于我们</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#feedback" class="footer-nav-link">意见反馈</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#copyright" class="footer-nav-link">版权声明</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#privacy" class="footer-nav-link">隐私声明</a>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-12">
                <p class="mb-0" style="font-size: 0.9em; color: rgba(255,255,255,0.7);">
                    © 2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function smoothScrollTo(targetId, offset = 120) {
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
            const targetPosition = targetElement.offsetTop - offset;
            const maxScroll = document.documentElement.scrollHeight - window.innerHeight;

            window.scrollTo({
                top: Math.min(targetPosition, maxScroll),
                behavior: 'smooth'
            });
        }
    }
    // 修复原有导航切换逻辑（添加hash处理）
    document.querySelectorAll('.about-nav-link').forEach(link => {
        link.addEventListener('click', function(e) {
        e.preventDefault();
        const target = this.getAttribute('href').substring(1); // 去除#号

        // 切换导航状态
        document.querySelector('.about-nav-link.active').classList.remove('active');
        this.classList.add('active');

        // 切换内容区域
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
    });
        document.getElementById(target).classList.add('active');

        // 同步URL hash
        history.pushState(null, null, `#${target}`);

        // 执行平滑滚动
        smoothScrollTo(target);
    });
    });

    window.addEventListener('load', () => {
        // 1. 获取滚动参数（优先localStorage）
        const pendingScroll = window.localStorage.getItem('pendingScroll');
    const hash = window.location.hash.substring(1) || pendingScroll;

    // 2. 清除存储
    if (pendingScroll) window.localStorage.removeItem('pendingScroll');

    // 3. 执行滚动
    if (hash) {
        smoothScrollTo(hash, 120); // 120px补偿值
        activateNavLink(hash);
    }
    });
    function loadUserCenterData(event) {
        event.preventDefault(); // 阻止默认的链接跳转行为

        // 显示加载状态（可选）
        showLoading();

        // 发送AJAX请求到后端
        fetch('${pageContext.request.contextPath}/user/refreshSessionData', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'same-origin' // 确保携带cookie/session
        })
            .then(response => {
            if (response.ok) {
            // 请求成功后跳转到个人中心页面
            window.location.href = 'user-center.jsp';
        } else {
            // 处理错误情况
            hideLoading();
            alert('加载用户数据失败，请重试');
        }
    })
    .catch(error => {
            hideLoading();
        console.error('请求失败:', error);
        alert('网络错误，请检查连接');
    });
    }

    // 加载状态显示/隐藏函数（可选）
    function showLoading() {
        // 实现您的加载动画或提示
        console.log("正在加载用户数据...");
    }

    function hideLoading() {
        // 隐藏加载动画或提示
        console.log("加载完成");
    }
    // 在每次操作前添加状态检查
    function checkUserStatus() {
        return fetch('${pageContext.request.contextPath}/user/info', {
            method: 'GET',
            credentials: 'same-origin' // 确保携带cookie/session
        })
            .then(response => response.json())
    .then(data => {
            if (data.code === 200) {
            const user = data.data;
            if (user.status === 0) { // 0 表示禁用状态
                alert('您的账号已被禁用，无法进行此操作');
                return false;
            }
            return true;
        } else {
            alert('获取用户状态失败');
            return false;
        }
    })
    .catch(() => {
            alert('获取用户状态失败');
        return false;
    });
    }
    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin' // 确保携带cookie/session
        })
            .then(response => {
            // 无论后端返回什么，都跳转到登录页
            window.location.href = '../user/login.jsp';
    })
    .catch(error => {
            console.error('退出登录失败:', error);
        window.location.href = '../login-admin.jsp';
    });
    }


    // 意见反馈提交处理
    document.getElementById('feedbackForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const feedbackType = document.getElementById('feedbackType').value;
        const feedbackContent = document.getElementById('feedbackContent').value.trim();

        // 新增反馈类型前端校验
        if (feedbackType.trim() === '') {
            alert('请选择反馈类型');
            return;
        }

        // 原有内容校验
        if (!feedbackContent) {
            alert('反馈内容不能为空');
            return;
        }
        if (feedbackContent.length > 1000) {
            alert('反馈内容不能超过1000字');
            return;
        }

        // 发送 AJAX 请求
        fetch('${pageContext.request.contextPath}/feedback/submit', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest' // 标识 AJAX 请求
            },
            body: JSON.stringify({
                feedbackType: feedbackType,
                content: feedbackContent
            }),
            credentials: 'same-origin' // 携带 Cookie 以验证登录状态
        })
            .then(response => response.json())
    .then(result => {
            if (result.code === 200) { // 假设成功状态码为 200（根据后端实际响应调整）
            alert('反馈提交成功！我们会尽快处理');
            this.reset(); // 清空表单
        } else {
            alert('提交失败：' + result.msg || '请检查网络或重试');
        }
    })
    .catch(error => {
            console.error('提交失败:', error);
        alert('网络请求失败，请稍后再试');
    });
    });
</script>
</body>
</html>