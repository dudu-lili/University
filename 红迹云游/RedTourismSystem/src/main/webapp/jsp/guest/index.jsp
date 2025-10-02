<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<html>
<head>
    <title>红色旅游系统 - 首页</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <%--<link rel="stylesheet" href="../../css/footer.css">--%>
    <%--<link rel="stylesheet" href="../../css/navbar.css">--%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 调整卡片布局避免按钮消失后的空隙 */
        .card-body > div {
            justify-content: flex-end;
        }
        body {
            padding-top: 56px;
        }
        html, body {
            height: 100%;
        }

        body {
            display: flex;
            flex-direction: column;
            padding-top: 56px;
        }

        .container {
            flex: 1;
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
        /* 可选：如果需要保持响应式折叠功能 */
        .navbar-toggler {
            border: none;
            padding: 0.25rem 0.75rem;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255,255,255,1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
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


        .carousel-item {
            height: 550px;
            background-color: #777;
        }
        .carousel-item img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }
        .section-title {
            /*color: #dc3545;*/
            color: white;
            margin: 30px 0 20px;
            font-weight: bold;
            /*border-left: 5px solid  rgba(179, 16, 15, 1);*/
            padding-left: 15px;
            /*background-color: #e0e0e0;*/
            background-color:#90201f;
            height: 48px;
            line-height: 48px;
        }
        .section-title2 {
            /*color: #dc3545;*/
            color: white;
            font-weight: bold;
            /*border-left: 5px solid rgba(179, 16, 15, 1);*/
            padding-left: 15px;
            /*background-color: #e0e0e0;*/
            background-color: #90201f;
            height: 48px;
            line-height: 48px;
        }
        .card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);

        }
        .card:hover {
            transform: translateY(-5px);
            z-index: 1000;

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
        .btn-like {
            color: #90201f;
        }
        .btn-like.active {
            background-color: #90201f;
            color: white;
        }
        .btn-favorite {
            color: #ffc107;
        }
        .btn-favorite.active {
            background-color: #ffc107;
            color: white;
        }
        .carousel-inner {
            padding-top: 0px;
            position: relative;
            width: 100%;
            overflow: hidden;
        }
        .card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        @media (min-width: 768px) {
            .col-md-3 {
                margin-bottom: 20px;
                width: 25%;
            }
        }
        .card-body {
            flex: 1;
        }
        .btn-back-to-top {
            position: fixed;
            bottom: 30px;
            right: 100px;
            display: none;
            z-index: 1000;
            background-color: #e0e0e0;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            text-align: center;
            line-height: 50px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-back-to-top:hover {
            background-color: rgb(128, 128, 128);
        }

        .btn-back-to-top i {
            font-size: 1.5rem;
        }

        .wheel-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            /*新加5.2*/
            display: flex; /* 使用flex布局 */
            flex-direction: column; /* 垂直排列子元素 */
            max-height: 530px;
        }
        /* 结果展示区 */
        .result-container {
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            /*min-height: 100px;*/
            height: 400px; /* 固定结果区域高度 新加5.2*/
            overflow-y: auto; /* 内容超出时显示滚动条 */
            margin-bottom: 15px;
            border: 1px solid #ddd;
        }

        .side-carousel .carousel-item {
            height: 300px;
        }

        .side-carousel .carousel-item img {
            position: absolute;
            top: 0;
            left: 0;
            min-height: 300px;
        }
        .carousel-caption {
            bottom: 20px;
            color: white;
            text-shadow: 0px 1px 1px #fff;
        }
        /*4.24*/
        .news-title {
            white-space: nowrap; /* 防止文本换行 */
            overflow: hidden; /* 隐藏溢出的内容 */
            text-overflow: ellipsis; /* 使用省略号表示被隐藏的文本 */
            max-width: 100%; /* 确保标题宽度不超过容器宽度 */
        }
        .news-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .news-title {
            font-size: 18px; /* 这里将字体大小设置为18px，你可以根据需要调整 4.29*/
            font-weight: bold; /* 将字体设置为加粗 */
            white-space: nowrap; /* 防止文本换行 */
            overflow: hidden; /* 隐藏溢出的内容 */
            text-overflow: ellipsis; /* 使用省略号表示被隐藏的文本 */
            max-width: 70%; /* 确保标题宽度不超过容器宽度 */
            flex: 1; /* 占据剩余空间 */
            margin-right: 20px; /* 与时间之间的间隔 */

        }

        .news-time {
            background-color: #f8f9fa; /* 时间框背景颜色 */
            padding: 5px 10px; /* 内边距 */
            border-radius: 5px; /* 圆角 */
            flex-shrink: 0; /* 不缩小 */
            text-align: right; /* 时间靠右 */
            width: 30%;
        }
        .text-decoration-none{
            color: black;
        }
        .text-decoration-none:hover{
            color: red;
        }
        /*4.27*/
        .weather-container {
            width: 100%;
            /*border: 1px solid #ccc;*/
            border-collapse: collapse;
        }

        .header {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background-color: #f4f4f4;
        }

        .update-time {
            font-weight: bold;
        }

        .location {
            font-weight: bold;
        }

        .date-table table,
        .icon-table table,
        .weather-temp-table table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .date-table td,
        .icon-table td,
        .weather-temp-table td {
            border-bottom: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            width: calc(100% / 3);
        }

        .icon-table img {
            width: 50px;
            height: 50px;
        }
        .spin-btn {
            cursor: pointer; /* 确保鼠标悬停时显示手指 */
            transition: all 0.3s ease; /* 添加平滑过渡效果 */
        }

        .spin-btn:hover {
            background-color: #c82333; /* 悬停时颜色变深 */
            transform: scale(1.05); /* 轻微放大效果 */
        }

        .spin-btn:disabled {
            opacity: 0.65; /* 禁用状态透明度 */
            cursor: not-allowed; /* 禁用状态显示禁止图标 */
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

        /* 调整原有页脚样式 */
        footer {
            background-color: #8b1515 !important; /* 改为红色主题 */
            margin-top: auto;
            /*position: relative;*/
            padding:20px 0;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg,
            rgba(255,255,255,0.1) 0%,
            rgba(255,255,255,0.3) 50%,
            rgba(255,255,255,0.1) 100%
            );
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
        /*按钮样式*/
        .btn-sm {
            background-color: #c82333; /* 更深的红色 */
            border-color: #bd2130;
            color: white;
        }

        .btn-sm:hover {
            background-color: #a71d2a;
            border-color: #a71d2a;
            color: white;
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
                    <a class="nav-link active" href="index.jsp">首页</a>
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
                    <a class="nav-link" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../user/login.jsp">注册/登录</a>
                </li>

            </ul>
        </div>
    </div>
</nav>


<!-- 轮播图 -->
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" title=""></button>
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" title=""></button>
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" title=""></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="../../assets/images/banners/bg.png" class="d-block w-100" alt="红色旅游">
            <div class="carousel-caption d-none d-md-block">
                <h5>红色记忆</h5>
                <p>重温革命历史，传承红色精神</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="../../assets/images/banners/bj2.png" class="d-block w-100" alt="红色旅游">
            <div class="carousel-caption d-none d-md-block">
                <h5>革命圣地</h5>
                <p>探访革命圣地，感受红色文化</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="../../assets/images/banners/bj1.png" class="d-block w-100" alt="红色旅游">
            <div class="carousel-caption d-none d-md-block">
                <h5>红色教育</h5>
                <p>开展红色教育，弘扬革命传统</p>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>
<div class="container mt-4">
    <div class="row mt-3">
        <div class="d-flex justify-content-end">
            <img src="../../assets/images/tishi.jpg" height="60" id="hint-image" class="cursor-pointer">
            <div id="hintContent" style="display:none;">
                <p>1、提前规划行程，提前了解目的地天气情况并选择合适的衣物</p>
                <p>2、保管好个人贵重物品，防止丢失</p>
                <p>3、注意保护个人隐私</p>
                <p>4、随身携带应急药品，以应对突发的身体不适</p>
                <p>5、注意饮食卫生，避免食用不洁食物或饮用生水</p>
                <p>6、遵守景区规定，注意安全警示标识，不冒险行事</p>
                <p>7、在山区或偏远地区出行，结伴而行，避免单独行动</p>
                <p>8、遇到危险，保持冷静，及时拨打110</p>
                <p>最后祝大家旅途愉快，一路平安！</p>
            </div>

            <!-- Bootstrap Modal 结构 -->
            <div class="modal fade" id="hintModal" tabindex="-1" aria-labelledby="hintModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="hintModalLabel">特别提醒广大游客文明安全出行！</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="hintModalBody" style="max-height: 70vh; overflow-y: auto;">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- left --%>
        <div class="col-md-7">
            <div class="bg-light">
                <h3 class="section-title2">天气预报</h3>
                <iframe allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=22&color=FFA500" width="100%"
                        height="180" style="border: none;"></iframe>
                <div id="myCarousel" class="carousel slide side-carousel" data-bs-ride="carousel" data-bs-interval="3000" data-bs-wrap="true">
                    <div class="carousel-inner mb-3">
                        <div class="carousel-item active">
                            <a href="scenic-list.jsp">
                                <img src="../../assets/images/scenic/lead.jpg" class="d-block w-80" alt="...">
                            </a>
                        </div>
                    </div>
                </div>


                <!-- 修改后的全国景点分布部分 -->
                <h3 class="section-title2 mt-4">全国红色景点分布</h3>
                <div class="container">
                    <div id="chinaMap" style="width: 100%; height: 400px; border: 1px solid #ddd; border-radius: 5px;"></div>
                    <div class="text-end mt-2">
                        <button onclick="resetMapView()" class="btn btn-sm btn-secondary me-2">
                            <i class="fas fa-sync-alt"></i> 恢复视图
                        </button>
                        <a href="red-Geocoding.jsp" class="btn btn-sm btn-danger">
                            查看全屏地图 &raquo;
                        </a>
                    </div>
                </div>



            </div>
        </div>



        <%-- right --%>
        <div class="col-md-5">
            <div class="bg-light">
                <h3 class="section-title2 mb-4">新闻动态</h3>
                <div class="container">
                    <div class="row g-4">

                        <!-- 新闻列表将动态插入到这里 4.24-->
                    </div>
                </div>
                <h3 class="section-title2">景点随机选</h3>
                <div class="container mt-4" style="height: 550px;">
                    <div class="wheel-container text-center">
                        <div class="text-center mt-4" style="height: 60px;">
                            <button id="spin-btn" class="btn btn-danger">开始随机</button>
                        </div>

                        <div id="result" class="result-container mt-4 text-center">
                            <h4><span id="result-name">点击上方按钮开始随机选择景点</span></h4>
                            <p><span id="result-desc"></span></p>
                            <a id="result-link" href="#" class="btn btn-danger mt-2" data-href-template="${pageContext.request.contextPath}/jsp/user/scenic-detail.jsp?id={{id}}" style="display:none;">查看详情</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="container mt-4">
    <!-- 热门景点 -->
    <h3 class="section-title">前八热门景点</h3>
    <div class="row" id="scenicCards">
        <%--<c:forEach var="scenic" items="${scenicList}" begin="0" end="7">--%>
        <%--<div class="col-md-3">--%>
        <%--&lt;%&ndash;<a href="${pageContext.request.contextPath}/jsp/user/scenic-detail.jsp?id=${scenic.id}" class="text-decoration-none">&ndash;%&gt;--%>
        <%--<div class="card">--%>
        <%--<a href="${pageContext.request.contextPath}/jsp/user/scenic-detail.jsp?id=${scenic.id}" class="text-decoration-none">--%>
        <%--<img src="${pageContext.request.contextPath}/${scenic.coverImage}" class="card-img-top" alt="${scenic.name}">--%>
        <%--</a>--%>
        <%--<div class="card-body">--%>
        <%--<h5 class="card-title">${scenic.name}</h5>--%>
        <%--<p class="card-text text-muted">${scenic.address}</p>--%>
        <%--<div class="d-flex justify-content-between">--%>
        <%--<button class="btn btn-sm btn-favorite btn-action scenic-favorite-btn" data-id="${scenic.id}">--%>
        <%--<i class="bi bi-heart"></i> 收藏--%>
        <%--</button>--%>
        <%--<button class="btn btn-sm btn-like btn-action scenic-like-btn" data-id="${scenic.id}">--%>
        <%--<i class="bi bi-hand-thumbs-up"></i> 点赞(<span class="like-count" data-scenic-id="${scenic.id}"></span>)--%>
        <%--</button>--%>
        <%--<button class="btn btn-sm btn-primary btn-action scenic-comment-btn" data-id="${scenic.id}" onclick="showCommentBox(this)">--%>
        <%--<i class="bi bi-chat"></i> 评论--%>
        <%--</button>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
        <%--</div>--%>
        <%--</c:forEach>--%>
    </div>

    <a href="#" class="btn-back-to-top" id="btn-back-to-top">
        <svg viewBox="0 0 24 24" fill="white">
            <path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/>
        </svg>
    </a>
    <!-- 热门路线 -->
    <h3 class="section-title">前八热门路线</h3>
    <div class="row" id="routeCards">
        <%--<c:forEach var="route" items="${routeList}" begin="0" end="7">--%>
        <%--<div class="col-md-3">--%>
        <%--&lt;%&ndash;<a href="${pageContext.request.contextPath}/jsp/user/route-detail.jsp?id=${route.id}" class="text-decoration-none">&ndash;%&gt;--%>
        <%--<div class="card">--%>
        <%--<a href="${pageContext.request.contextPath}/jsp/user/route-detail.jsp?id=${route.id}" class="text-decoration-none">--%>
        <%--<img src="${pageContext.request.contextPath}/${route.coverImage}" class="card-img-top" alt="${route.name}">--%>
        <%--</a>--%>
        <%--<div class="card-body">--%>
        <%--<h5 class="card-title">${route.name}</h5>--%>
        <%--&lt;%&ndash;                            <p class="card-text text-muted">${route.description}</p>&ndash;%&gt;--%>
        <%--<div class="d-flex justify-content-between">--%>
        <%--<button class="btn btn-sm btn-favorite btn-action route-favorite-btn" data-id="${route.id}">--%>
        <%--<i class="bi bi-heart"></i> 收藏--%>
        <%--</button>--%>
        <%--<button class="btn btn-sm btn-like btn-action route-like-btn" data-id="${route.id}">--%>
        <%--<i class="bi bi-hand-thumbs-up"></i> 点赞(<span class="like-count" data-route-id="${route.id}"></span>)--%>
        <%--</button>--%>
        <%--<button class="btn btn-sm btn-primary btn-action route-comment-btn" data-id="${route.id}" onclick="showCommentBox(this)">--%>
        <%--<i class="bi bi-chat"></i> 评论--%>
        <%--</button>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
        <%--</div>--%>
        <%--</c:forEach>--%>
    </div>
    <!-- 评论模态框 -->
    <div class="modal fade" id="commentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="commentModalTitle">评论</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="commentContent" rows="3"></textarea>
                    <input type="hidden" id="commentTargetId">
                    <input type="hidden" id="commentType"> <!-- scenic或route -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="submitCommentBtn">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 评论列表模态框 -->
    <div class="modal fade" id="commentsListModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">评论列表</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="commentsListBody">
                    <!-- 评论内容将在这里动态加载 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>

<script type="text/javascript">
    window.contextPath = '<%= request.getContextPath() %>';
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../../js/bootstrap.bundle.min.js"></script>
<script src="https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.0.0-beta.2/libs/cn/index.js"></script>
<script>
    // 全局变量
    const commentModal = new bootstrap.Modal(document.getElementById('commentModal'));
    const commentsListModal = new bootstrap.Modal(document.getElementById('commentsListModal'));
    function viewScenicDetail(scenicId) {
        // 跳转到景点详情页，假设详情页为scenic-detail.jsp
        window.location.href = 'scenic-detail.jsp?id=' + scenicId;
    }
    // 查看路线详情
    function viewRouteDetail(routeId) {
        // 跳转到路线详情页
        window.location.href = 'route-detail.jsp?id=' + routeId;
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


    $(document).ready(function() {
        // ------------------------ 加载热门景点 ------------------------
        // 假设在 JSP 页面中设置了 contextPath 变量
        const contextPath = "${pageContext.request.contextPath}";


        $.get("/RedTourismSystem/guest/scenic-top8", function(response) {
            console.log("🔍 热门景点请求响应:", response);
            if (response.code === 200) {
                const scenics = response.data;
                console.log("✅ 成功获取景点数据，共", scenics.length, "条");
                if (scenics.length > 0) {
                    console.log("📦 景点数据结构示例:", scenics[0]);
                }

                const scenicCards = $("#scenicCards");
                scenics.forEach(scenic => {
                    console.log("🖼️ 正在渲染景点:", scenic.name);

                // 创建外层 div
                const colDiv = $("<div>", { class: "col-md-3" });

                // 创建卡片 div
                const cardDiv = $("<div>", { class: "card" });

                // 计算图片的 src 路径
                // const imgSrc = '/RedTourismSystem/scenic/image/'+scenic.id
                const imgSrc = contextPath + '/' + scenic.coverImage;

                // 添加测试输出
                console.log("🚀 图片路径:", imgSrc);
                // 创建图片元素
                const img = $("<img>", {
                    src: imgSrc,
                    class: "card-img-top",
                    alt: scenic.name,
                    style: "height: 180px; object-fit: cover; cursor: pointer;", // 添加固定样式
                    <%--onclick: `viewScenicDetail(${scenic.id})` // 绑定点击事件--%>
                }).on("click", function() {
                    viewScenicDetail(scenic.id); // 直接访问当前scenic.id（作用域正确）
                });

                // 创建卡片主体 div
                const cardBody = $("<div>", { class: "card-body" });

                // 创建标题
                const title = $("<h5>", { class: "card-title", text: scenic.name });

                // 创建地址段落
                const address = $("<p>", { class: "card-text text-muted", text: scenic.address });

                // 将元素添加到相应的父元素中
                cardBody.append(title, address);
                cardDiv.append(img, cardBody);
                colDiv.append(cardDiv);

                // 将最终的列元素添加到 #scenicCards 中
                scenicCards.append(colDiv);
            });
            }
        }).fail(function(error) {
            console.error("请求发生错误:", error);
        });

        // ------------------------ 加载热门路线 ------------------------


        $.get("/RedTourismSystem/guest/routes-top8", function(response) {
            console.log("🔍 热门路线请求响应:", response);
            if (response.code === 200) {
                const routes = response.data;
                console.log("✅ 成功获取路线数据，共", routes.length, "条");
                if (routes.length > 0) {
                    console.log("📦 路线数据结构示例:", routes[0]);
                }

                const routeCards = $("#routeCards");
                routes.forEach(route => {
                    console.log("🖼️ 正在渲染路线:", route.name);

                // 创建外层 div
                const colDiv = $("<div>", { class: "col-md-3" });

                // 创建卡片 div
                const cardDiv = $("<div>", { class: "card" });

                // 创建图片元素
                const img = $("<img>", {
                    // src: '/RedTourismSystem/route/image/'+route.id,
                    src: contextPath + '/' + route.coverImage,
                    class: "card-img-top",
                    alt: route.name,
                    style: "height: 180px; object-fit: cover; cursor: pointer;", // 添加固定样式
                    <%--onclick:`viewRouteDetail(${route.id})`// 绑定点击事件--%>
                }).on("click", function() {
                    viewRouteDetail(route.id); // 直接访问当前scenic.id（作用域正确）
                });

                // 创建卡片主体 div
                const cardBody = $("<div>", { class: "card-body" });

                // 创建标题
                const title = $("<h5>", { class: "card-title", text: route.name });

                // 创建描述段落
                // const description = $("<p>", { class: "card-text text-muted", text: route.description });

                // 将元素添加到相应的父元素中
                // cardBody.append(title, description);
                cardBody.append(title);
                cardDiv.append(img, cardBody);
                colDiv.append(cardDiv);

                // 将最终的列元素添加到 #routeCards 中
                routeCards.append(colDiv);
            });
            }
        }).fail(function(error) {
            console.error("请求发生错误:", error);
        });
        // 请求新闻列表4.24
        $.ajax({
            url: '${pageContext.request.contextPath}/news/list',
            method: 'GET',
            success: function(response) {
                console.log("Response data:", response);

                if (response.code === 200) {
                    const newsList = response.data;

                    const container = $('.col-md-5 .container .row.g-4');
                    container.empty();
                    let count = 0;

                    newsList.forEach((news, index) => {
                        if(count >= 7) return;


                    // 创建新闻项的容器
                    const colDiv = $('<div class="col-md-12 news-item"></div>');

                    // 创建新闻标题的链接
                    const titleLink = $('<a class="text-decoration-none"></a>').attr('href', '#').text(news.title);
                    titleLink.on('click', function(event) {
                        event.preventDefault(); // 阻止默认的链接跳转行为
                        viewNewsDetail(news.id); // 调用 viewNewsDetail 函数
                    });

                    // 创建新闻标题的段落
                    const title = $('<span class="news-title"></span>').append(titleLink);


                    // 截取日期部分
                    const publishTime = $('<span class="news-time"></span>').text(news.publishTime.split(' ')[0]);
                    console.log("Publish Time:", publishTime.text())
                    colDiv.append(title);
                    colDiv.append(publishTime);

                    container.append(colDiv);
                    count++;
                });
                } else {
                    alert('获取新闻列表失败: ' + response.message);
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });

        // 定义 viewNewsDetail 函数4.24
        function viewNewsDetail(newsId) {
            // 跳转到新闻详情页
            window.location.href = 'news-detail.jsp?id=' + newsId;
        }


        // 查看新闻详情
        function viewNewsDetail(newsId) {
            // 跳转到新闻详情页
            window.location.href = 'news-detail.jsp?id=' + newsId;
        }




        // 景点点赞
        $('.scenic-like-btn').on('click', function() {
            toggleScenicLike($(this).data('id'), this);
        });

    });
    // 提交评论


    $('#submitCommentBtn').on('click', function() {
        const scenicId = $('#commentScenicId').val();
        submitComment(scenicId);
    });

    // 获取景点状态,修改1
    $('.scenic-like-btn, .scenic-favorite-btn').each(function() {
        const scenicId = $(this).data('id');

        $.ajax({
            url: '${pageContext.request.contextPath}/scenic/status/' + scenicId,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    const status = response.data;
                    if (status.liked) {
                        $('.scenic-like-btn[data-id=' + scenicId + ']').addClass('active');
                    }
                    if (status.favorited) {
                        $('.scenic-favorite-btn[data-id=' + scenicId + ']').addClass('active');
                    }
                }
            },
            error: function(xhr) {
                alert('获取景点状态失败: ' + xhr.statusText);
            }
        });
    });
    $('.route-like-btn, .route-favorite-btn').each(function() {
        const routeId = $(this).data('id');
        $.ajax({
            url: '${pageContext.request.contextPath}/route/status/' + routeId,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    const status = response.data;
                    if (status.liked) {
                        $('.route-like-btn[data-id=' + routeId + ']').addClass('active');
                    }
                    if (status.favorited) {
                        $('.route-favorite-btn[data-id=' + routeId + ']').addClass('active');
                    }
                }
            },
            error: function(xhr) {
                alert('获取路线状态失败: ' + xhr.statusText);
            }
        });
    });




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
    window.addEventListener('scroll', function() {
        var backToTopButton = document.getElementById('btn-back-to-top');
        if (window.pageYOffset > 300) {
            backToTopButton.style.display = 'block';
        } else {
            backToTopButton.style.display = 'none';
        }
    });

    document.getElementById('btn-back-to-top').addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        const spinBtn = document.getElementById('spin-btn');
        const resultName = document.getElementById('result-name');
        const resultDesc = document.getElementById('result-desc');
        const resultLink = document.getElementById('result-link');
        let isSpinning = false;
        let scenicSpots = [];

        // 确保按钮初始状态正确
        spinBtn.disabled = false;
        spinBtn.style.cursor = 'pointer';

        // 获取景点数据
        async function fetchScenicSpots() {
            try {
                spinBtn.disabled = true;
                resultName.textContent = "正在加载景点数据...";

                const response = await fetch('${pageContext.request.contextPath}/scenic/random');
                if (!response.ok) {
                    throw new Error(`HTTP错误! 状态: ${response.status}`);
                }
                const data = await response.json();

                // 调试输出
                console.log("获取到的景点数据:", data);

                if (!data || !Array.isArray(data)) {
                    throw new Error('服务器返回的数据格式不正确');
                }

                return data;
            } catch (error) {
                console.error('获取景点数据失败:', error);
                resultName.textContent = "数据加载失败";
                resultDesc.textContent = error.message || "请刷新页面重试";
                throw error;
            } finally {
                spinBtn.disabled = false;
            }
        }

        // 随机选择景点
        function selectRandomSpot() {
            if (isSpinning || scenicSpots.length === 0) {
                console.warn('无法开始随机选择:', isSpinning ? '正在选择中' : '没有可用景点数据');
                return;
            }

            console.log("开始随机选择景点...");
            isSpinning = true;
            spinBtn.disabled = true;
            resultName.textContent = "随机抽取中...";
            resultDesc.textContent = "";
            resultLink.style.display = 'none';

            // 添加动画效果
            let counter = 0;
            const maxIterations = 10;
            const interval = setInterval(() => {
                if (counter >= maxIterations) {
                clearInterval(interval);
                showFinalResult();
                isSpinning = false;
                spinBtn.disabled = false;
                return;
            }

            const tempIndex = Math.floor(Math.random() * scenicSpots.length);
            const tempSpot = scenicSpots[tempIndex];
            resultName.textContent = tempSpot.name;
            resultDesc.textContent = "正在随机选择...";

            counter++;
        }, 200);
        }

        // 显示最终结果
        function showFinalResult() {
            const randomIndex = Math.floor(Math.random() * scenicSpots.length);
            const selectedSpot = scenicSpots[randomIndex];

            if (!selectedSpot) {
                console.error('选中的景点无效:', selectedSpot);
                resultName.textContent = "未选中有效景点";
                resultDesc.textContent = "请重试";
                return;
            }

            console.log("选中的景点:", selectedSpot);
            resultName.textContent = selectedSpot.name;
            resultDesc.textContent = selectedSpot.description || "暂无描述";
            const hrefTemplate = resultLink.getAttribute('data-href-template');
            const url = hrefTemplate.replace('{{id}}', selectedSpot.id);
            resultLink.href = url;
            console.log("Generated URL:", url); // 添加调试语句
            resultLink.style.display = 'inline-block';
            resultLink.addEventListener('click', function() {
                console.log("Link clicked"); // 添加调试语句
            });

        }

        // 初始化
        async function initialize() {
            try {
                scenicSpots = await fetchScenicSpots();

                if (scenicSpots.length === 0) {
                    throw new Error("没有可用的景点数据");
                }

                console.log("初始化完成，可用景点数量:", scenicSpots.length);
                spinBtn.addEventListener('click', selectRandomSpot);
                resultName.textContent = "点击上方按钮开始随机选择景点";
            } catch (error) {
                console.error('初始化失败:', error);
                resultName.textContent = "数据加载失败";
                resultDesc.textContent = error.message || "请刷新页面重试";
            }
        }

        // 启动初始化
        initialize();
    });

    document.addEventListener('DOMContentLoaded', function() {
        const hintImage = document.getElementById('hint-image');
        const hintContent = document.getElementById('hintContent');
        const hintModal = new bootstrap.Modal(document.getElementById('hintModal'));
        const hintModalBody = document.getElementById('hintModalBody');

        if (hintImage) {
            hintImage.addEventListener('click', function() {
                // 将隐藏内容复制到Modal中
                hintModalBody.innerHTML = hintContent.innerHTML;

                // 显示Modal
                hintModal.show();
            });
        }
    });

</script>

<script src="https://unpkg.com/echarts@4.6.0/dist/echarts.min.js"></script>
<!-- 再加载地图数据（使用官方CDN的china.js） -->
<script src="https://unpkg.com/echarts@4.6.0/map/js/china.js"></script>

<script>

    // 全局地图实例
    let mapChart;
    let currentZoom = 1;

    // 初始化地图
    function initChinaMap() {
        const dom = document.getElementById('chinaMap');
        mapChart = echarts.init(dom);

        // 设置基础配置（含缩放功能）
        const baseOption = {
            backgroundColor: '#F7F9FC',
            title: {
                text: '全国红色景点分布',
                left: 'center',
                textStyle: {
                    color: '#dc3545',
                    fontSize: 18
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: function (params) {
                    const data = params.data;
                    if (data) {
                        return (
                            '景点：' + data.name + '<br/>' +
                            '省份：' + data.province + '<br/>' +
                            '地址：' + data.address + '<br/>' +
                            '坐标：' + data.value[0] + ',' + data.value[1]
                        );
                    } else {
                        return '数据缺失';
                    }
                },
                enterable: true,
                confine: true
            },
            geo: {
                map: 'china',
                roam: true, // 关键修正：允许缩放和平移
                label: { show: true, color: '#666' },
                zoom: currentZoom,
                center: [104.114129, 37.550339],
                itemStyle: {
                    areaColor: '#e9f5ff',
                    borderColor: '#dc3545',
                    borderWidth: 1.2
                },
                emphasis: { itemStyle: { areaColor: '#ffe7e7' } }
            }
        };

        mapChart.setOption(baseOption);

        // 地图数据加载逻辑
        $.ajax({
            url: contextPath + "/guest/red-geocoding-info",
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.code === 200 && response.data.points) {
                    const points = response.data.points.map(point => ({
                        name: point.name,
                        province: point.province,
                        address: point.address,
                        value: [point.lng, point.lat]
                    }));

                    const dataOption = {
                        series: [{
                            type: 'scatter',
                            coordinateSystem: 'geo',
                            symbol: 'path://M12,20 L12,20 12,20 C17.5228466,20 22,15.5228466 22,10 C22,4.47715342 17.5228466,0 12,0 C6.47715338,0 2,4.47715342 2,10 C2,15.5228466 6.47715338,20 12,20 Z M12,22 C16.418278,22 20,18.418278 20,14 C20,9.581722 16.418278,6 12,6 C7.581722,6 4,9.581722 4,14 C4,18.418278 7.581722,22 12,22 Z',
                            symbolSize: 8,
                            itemStyle: {
                                color: '#dc3545',
                                shadowBlur: 5,
                                shadowColor: 'rgba(220, 53, 69, 0.3)'
                            },
                            emphasis: {
                                scale: 1.2,
                                itemStyle: { shadowBlur: 10, shadowColor: 'rgba(220, 53, 69, 0.5)' }
                            },
                            data: points
                        }]
                    };

                    mapChart.setOption(dataOption);
                }
            }
        });

        // 恢复视图功能
        document.getElementById('resetMapBtn').addEventListener('click', function () {
            currentZoom = 1;
            mapChart.setOption({
                geo: {
                    zoom: currentZoom,
                    center: [104.114129, 37.550339],
                    roam: true // 重置时保持缩放功能
                }
            });
        });
    }


    // 恢复地图初始视图
    function resetMapView() {
        // 保存当前数据
        const currentOption = mapChart.getOption();
        const seriesData = currentOption.series[0].data;

        // 完全重新初始化地图
        mapChart.clear();
        initChinaMap();

        // 恢复数据
        setTimeout(() => {
            mapChart.setOption({
            series: [{
                data: seriesData
            }]
        });
    }, 100);
    }

    // 全屏显示地图


    // 页面加载完成后初始化地图
    document.addEventListener('DOMContentLoaded', function () {
        initChinaMap();
    });

</script>


</body>
</html>