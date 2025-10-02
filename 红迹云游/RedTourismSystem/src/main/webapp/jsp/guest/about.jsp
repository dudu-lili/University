<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 关于我们</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 保持原有样式不变 -->
    <style>

        /* 调整卡片布局避免按钮消失后的空隙 */
        .card-body > div {
            justify-content: flex-end;
        }
        body {
            padding-top: 56px;
            /* 新增：设置底部边距避免内容被页脚遮挡 */
            padding-bottom: 80px;
        }
        .navbar {
            background-color: #90201f;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 0px;
        }
        .navbar-brand, .nav-link {
            color: white!important;
            font-weight: bold;
        }
        .nav-link:hover {
            color: #ffc107!important;
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
        /*footer {*/
            /*background-color: #343a40;*/
            /*color: white;*/
            /*padding: 20px 0;*/
            /*margin-top: 50px;*/
        /*}*/
        /*类容区域样式------------------------------*/
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

        /*"网站布局"模块样式------------*/
        /* 新增网站地图样式优化 */
        /* 优化后的网站地图样式 */
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
        <!-- 修正Logo路径：使用上下文路径确保跨环境适配 -->
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
                <li class="nav-item">
                    <a class="nav-link" href="scenic-list.jsp">景点信息</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="route-list.jsp">旅游路线</a>
                </li>
                <%--补充部分--%>
                <li class="nav-item">
                    <a class="nav-link" href="red-Geocoding.jsp">地图展示</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="study-list.jsp">红色研学</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="news-list.jsp">新闻公告</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../user/login.jsp">注册/登录</a>
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
                    <p>系统由xxxxxx指导，xxxxxxxx提供学术支持，汇聚了全国n+红色教育基地资源，服务超过m用户。</p>
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
                        <p>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</p>
                    </div>
                </div>

                <!-- 意见反馈 -->
                <div id="feedback" class="content-section">
                    <h3 class="section-title mb-4">意见反馈</h3>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">反馈类型</label>
                            <select class="form-select">
                                <option>功能建议</option>
                                <option>内容纠错</option>
                                <option>合作咨询</option>
                                <option>其他</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">详细描述</label>
                            <textarea class="form-control" rows="5" placeholder="请输入您的宝贵意见"></textarea>
                        </div>
                        <button type="submit" class="btn btn-danger"
                                onclick="checkLogin(event)"
                                style="margin-top: 10px;">提交反馈</button>
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
                            <li><a href="scenic-list.jsp">景点信息</a></li>
                            <li><a href="route-list.jsp">旅游路线</a></li>
                            <li><a href="red-Geocoding.jsp">地图展示</a></li>
                            <li><a href="study-list.jsp">红色研学</a></li>
                        </ul>
                        <ul>
                            <li><a href="news-list.jsp">新闻公告</a></li>
                            <li><a href="about.jsp">关于我们</a></li>
                            <%--<li><a href="help-center.jsp">帮助中心</a></li>--%>
                            <li><a href="privacy.jsp">隐私政策</a></li>
                            <%--<li><a href="terms.jsp">服务条款</a></li>--%>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    <%--<div class="container">--%>
        <%--<!-- 友情链接区域 -->--%>
        <%--<div class="row mt-4">--%>
            <%--<div class="col-12">--%>
                <%--<h4 style="font-weight: bold; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid rgba(255,255,255,0.2);">--%>
                    <%--友情链接--%>
                <%--</h4>--%>
                <%--<div class="row">--%>
                    <%--<!-- 第一列链接 -->--%>
                    <%--<div class="col-md-3 mb-3">--%>
                        <%--<a href="https://www.redtourism.com.cn/" class="footer-link" target="_blank" rel="noopener noreferrer">中国红色旅游网</a><br>--%>
                        <%--<a href="https://www.hswh.org.cn/" class="footer-link" target="_blank" rel="noopener noreferrer">红色文化网</a><br>--%>
                        <%--<a href="http://www.sasagov.com/" class="footer-link" target="_blank" rel="noopener noreferrer">红色传承教育官网</a>--%>
                    <%--</div>--%>
                    <%--<!-- 第二列链接 -->--%>
                    <%--<div class="col-md-3 mb-3">--%>
                        <%--<a href="http://www.crt.com.cn/" class="footer-link" target="_blank" rel="noopener noreferrer">中红网</a><br>--%>
                        <%--<a href="http://cpc.people.com.cn/" class="footer-link" target="_blank" rel="noopener noreferrer">中国共产党新闻网</a><br>--%>
                        <%--<a href="http://www.hsjycc.org.cn/gmww/index.shtml" class="footer-link" target="_blank" rel="noopener noreferrer">红色基因传承研究中心</a>--%>
                    <%--</div>--%>
                    <%--<!-- 第三列链接 -->--%>
                    <%--<div class="col-md-3 mb-3">--%>
                        <%--<a href="https://www.hongchuanwang.com/" class="footer-link" target="_blank" rel="noopener noreferrer">红传网</a><br>--%>
                        <%--<a href="http://www.zhongguolaoqu.com/" class="footer-link" target="_blank" rel="noopener noreferrer">中国老区网</a><br>--%>
                        <%--<a href="https://www.mct.gov.cn/" class="footer-link" target="_blank" rel="noopener noreferrer">中华人民共和国文化和旅游部</a>--%>
                    <%--</div>--%>
                    <%--<!-- 第四列链接 -->--%>
                    <%--<div class="col-md-3 mb-3">--%>
                        <%--<a href="https://www.cctv.com/" class="footer-link" target="_blank" rel="noopener noreferrer">央视网</a><br>--%>
                        <%--<a href="http://dangshi.people.cn/GB/index.html" class="footer-link" target="_blank" rel="noopener noreferrer">党史学习教育官网</a><br>--%>
                        <%--<a href="https://www.lzp360.com/" class="footer-link" target="_blank" rel="noopener noreferrer">中国近代影像资料库</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>

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

    function checkLogin(event) {
        // 阻止表单默认提交行为
        event.preventDefault();

        // 模拟登录状态检测（实际应替换为真实验证逻辑）
        const isLoggedIn = localStorage.getItem('userToken') ? true : false;

        if (!isLoggedIn) {
            // 未登录状态处理
            alert('请先登录后提交反馈！');
            // 可选：跳转登录页
            // window.location.href = '/login';
        } else {
            // 已登录状态处理
            // 移除阻止默认行为并提交表单
            event.target.closest('form').submit();

            // 或者执行其他提交逻辑
            // console.log('提交反馈内容...');
        }
    }

</script>
</body>
</html>