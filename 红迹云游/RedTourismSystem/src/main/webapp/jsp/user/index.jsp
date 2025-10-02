<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 首页</title>
    <script type="text/javascript">
        var botId = '<%= application.getInitParameter("botId") %>';
        var token = '<%= application.getInitParameter("token") %>';
        var contextPath = '<%= request.getContextPath() %>'; // 传递 contextPath
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
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
            color: #dc3545;
            background-color: transparent; /* 透明背景 */
            border: none; /* 移除边框 */
        }
        .btn-like.active {
            background-color: #dc3545;
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
            padding-top: 20px;
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
                    <a class="nav-link active" href="index.jsp">首页</a>
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
                    <a class="nav-link" href="about.jsp">关于我们</a>
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
            <img src="../../assets/images/banners/bg2.png" class="d-block w-100" alt="红色旅游">
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

                        <!-- 新闻列表将动态插入到这里-->
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
    <div class="row">
        <c:forEach var="scenic" items="${scenicList}" begin="0" end="7">
            <div class="col-md-3">
                    <%--<a href="${pageContext.request.contextPath}/jsp/user/scenic-detail.jsp?id=${scenic.id}" class="text-decoration-none">--%>
                <div class="card">
                    <a href="${pageContext.request.contextPath}/jsp/user/scenic-detail.jsp?id=${scenic.id}" class="text-decoration-none">
                        <img src="${pageContext.request.contextPath}/${scenic.coverImage}" class="card-img-top" alt="${scenic.name}">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">${scenic.name}</h5>
                        <p class="card-text text-muted">${scenic.address}</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-sm btn-favorite btn-action scenic-favorite-btn" data-id="${scenic.id}">
                                <i class="bi bi-heart"></i> 收藏
                            </button>
                            <button class="btn btn-sm btn-like btn-action scenic-like-btn" data-id="${scenic.id}">
                                <i class="bi bi-hand-thumbs-up"></i> 点赞(<span class="like-count" data-scenic-id="${scenic.id}"></span>)
                            </button>
                            <button class="btn btn-sm btn-primary btn-action scenic-comment-btn" data-id="${scenic.id}" onclick="showCommentBox(this)">
                                <i class="bi bi-chat"></i> 评论
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <a href="#" class="btn-back-to-top" id="btn-back-to-top">
        <svg viewBox="0 0 24 24" fill="white">
            <path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/>
        </svg>
    </a>
    <!-- 热门路线 -->
    <h3 class="section-title">前八热门路线</h3>
    <div class="row">
        <c:forEach var="route" items="${routeList}" begin="0" end="7">
            <div class="col-md-3">
                    <%--<a href="${pageContext.request.contextPath}/jsp/user/route-detail.jsp?id=${route.id}" class="text-decoration-none">--%>
                <div class="card">
                    <a href="${pageContext.request.contextPath}/jsp/user/route-detail.jsp?id=${route.id}" class="text-decoration-none">
                        <img src="${pageContext.request.contextPath}/${route.coverImage}" class="card-img-top" alt="${route.name}">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">${route.name}</h5>
                            <%--                            <p class="card-text text-muted">${route.description}</p>--%>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-sm btn-favorite btn-action route-favorite-btn" data-id="${route.id}">
                                <i class="bi bi-heart"></i> 收藏
                            </button>
                            <button class="btn btn-sm btn-like btn-action route-like-btn" data-id="${route.id}">
                                <i class="bi bi-hand-thumbs-up"></i> 点赞(<span class="like-count" data-route-id="${route.id}"></span>)
                            </button>
                            <button class="btn btn-sm btn-primary btn-action route-comment-btn" data-id="${route.id}" onclick="showCommentBox(this)">
                                <i class="bi bi-chat"></i> 评论
                            </button>
                        </div>
                    </div>
                </div>
                    <%--</a>--%>
            </div>
        </c:forEach>
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../js/bootstrap.bundle.min.js"></script>
    <div id="id1" style="position: fixed; top: 250px; right: 180px; height: 800px;"></div>
    <!-- 动态注入敏感信息 -->
<script>
    function fetchUserInfo() {
        fetch('${pageContext.request.contextPath}/user/info', {
            method: 'GET',
            credentials: 'same-origin' // 确保携带 cookie/session
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    const user = data.data;
                    console.log("nnn"+user)
                    initCozeChatBot(user.nickname, user.avatar);
                } else {
                    console.error('Failed to fetch user info:', data.msg);
                    initCozeChatBot('游客', '${pageContext.request.contextPath}/assets/images/default-avatar.png');
                }
            })
            .catch(error => {
                console.error('Error fetching user info:', error);
                initCozeChatBot('游客', '${pageContext.request.contextPath}/assets/images/default-avatar.png');
            });
    }
    function initCozeChatBot(nickname, avatarUrl) {
        console.log("mmm"+nickname,avatarUrl)
        new CozeWebSDK.WebChatClient({
            config: {
                bot_id: botId,
            },
            componentProps: {
                title: '红迹云游小助手',
            },
            auth: {
                type: 'token',
                token: token,
                onRefreshToken: function () {
                    return token;
                }
            },
            userInfo: {
                id: '123456', // 可选：如果需要更动态的ID，可从接口返回
                nickname: nickname,
                url: 'http://localhost:8080/RedTourismSystem/'+avatarUrl
            },
            ui: {
                base: {
                    icon: 'http://localhost:8080/RedTourismSystem/assets/images/r_ai.png',
                    layout: 'pc',
                    lang: 'zh-CN',
                    zIndex: 1000,
                },
                asstBtn: {
                    isNeed: true,
                },
                footer: {
                    isShow: true,
                    expressionText: '红迹云游',
                },
                chatBot: {
                    title: '红迹云游小助手',
                    el: document.getElementById('id1')
                }
            }
        });
    }
    document.addEventListener('DOMContentLoaded', function () {
        fetchUserInfo(); // 获取用户信息并初始化 ChatBot
    });

</script>
<%--    <!-- 引入 coze-init.js 文件 -->--%>
<%--    <script src="../../js/coze.js"></script>--%>

<%--    <!-- 动态注入敏感信息 -->--%>
<%--    <script type="text/javascript">--%>
<%--        var gaodeWeatherApiKey = '<%= application.getInitParameter("googleWeatherApiKey") %>';--%>
<%--    </script>--%>

<%--    <!-- 调用高德地图逆地理编码API和天气查询API -->--%>
<%--    <script type="text/javascript">--%>
<%--        document.addEventListener('DOMContentLoaded', function() {--%>

<%--            // 获取用户地理位置--%>
<%--            function getUserLocation() {--%>
<%--                return new Promise((resolve, reject) => {--%>
<%--                    if (navigator.geolocation) {--%>
<%--                        navigator.geolocation.getCurrentPosition(--%>
<%--                            (position) => {--%>
<%--                                const { latitude, longitude } = position.coords;--%>
<%--                                resolve({ latitude, longitude });--%>
<%--                            },--%>
<%--                            (error) => {--%>
<%--                                reject(error);--%>
<%--                            }--%>
<%--                        );--%>
<%--                    } else {--%>
<%--                        reject(new Error("Geolocation is not supported by this browser."));--%>
<%--                    }--%>
<%--                });--%>
<%--            }--%>

<%--            // 调用逆地理编码API获取adcode--%>
<%--            async function getAdcodeByLocation(latitude, longitude) {--%>
<%--                const location = longitude+','+latitude;--%>
<%--                console.log("Location:", location);--%>
<%--                console.log("Location:", longitude, latitude);--%>
<%--                const url = `https://restapi.amap.com/v3/geocode/regeo?location=`+location+`&key=`+gaodeWeatherApiKey+`&extensions=all`;--%>
<%--                console.log("URL:", url)--%>
<%--                console.log("r",gaodeWeatherApiKey)--%>
<%--                try {--%>
<%--                    const response = await fetch(url);--%>
<%--                    const data = await response.json();--%>
<%--                    console.log("Reverse Geocoding API Response:", data); // 打印逆地理编码API响应数据--%>
<%--                    if (data.status === "1" && data.info === "OK") {--%>
<%--                        return data.regeocode.addressComponent.adcode;--%>
<%--                    } else {--%>
<%--                        throw new Error("Failed to get adcode: " + data.info);--%>
<%--                    }--%>
<%--                } catch (error) {--%>
<%--                    console.error("Failed to fetch adcode:", error);--%>
<%--                    return null;--%>
<%--                }--%>
<%--            }--%>

<%--            // 调用天气查询API--%>
<%--            async function getWeatherByAdcode(adcode) {--%>
<%--                const url = `https://restapi.amap.com/v3/weather/weatherInfo?city=`+adcode+`&key=`+gaodeWeatherApiKey+`&extensions=all&output=json`;--%>

<%--                try {--%>
<%--                    const response = await fetch(url);--%>
<%--                    const data = await response.json();--%>
<%--                    console.log("Weather API Response:", data); // 打印天气查询API响应数据--%>
<%--                    return data;--%>
<%--                } catch (error) {--%>
<%--                    console.error("Failed to fetch weather data:", error);--%>
<%--                    return null;--%>
<%--                }--%>
<%--            }--%>
<%--            function getWeatherIcon(weatherCondition) {--%>
<%--                const weatherIcons = {--%>
<%--                    "晴": "../../assets/images/weather/sunny.png",--%>
<%--                    "多云": "../../assets/images/weather/cloudy.png",--%>
<%--                    "小雨": "../../assets/images/weather/light-rain.png",--%>
<%--                    "中雨": "../../assets/images/weather/moderate-rain.png",--%>
<%--                    "大雨": "../../assets/images/weather/heavy-rain.png",--%>
<%--                    "暴雨": "../../assets/images/weather/storm.png",--%>
<%--                    "阵雨": "../../assets/images/weather/shower.png",--%>
<%--                    "雷阵雨": "../../assets/images/weather/thunderstorm.png",--%>
<%--                    "阴": "../../assets/images/weather/overcast.png"--%>
<%--                };--%>
<%--                return weatherIcons[weatherCondition] || "default.png";--%>
<%--            }--%>

<%--            // 显示天气信息--%>
<%--            async function displayWeather() {--%>
<%--                try {--%>
<%--                    const { latitude, longitude } = await getUserLocation();--%>
<%--                    const adcode = await getAdcodeByLocation(latitude, longitude);--%>
<%--                    if (!adcode) {--%>
<%--                        alert("无法获取区划编码，请检查网络或授权位置信息。");--%>
<%--                        return;--%>
<%--                    }--%>

<%--                    const weatherData = await getWeatherByAdcode(adcode);--%>
<%--                    console.log("Weather Data1:", weatherData);--%>
<%--                    console.log("Weather Data:", weatherData.forecasts[0].casts[0].week);--%>
<%--                    console.log("Weather Data2:", weatherData.forecasts[0].casts[0].date);--%>
<%--                    if (weatherData && weatherData.forecasts) {--%>
<%--                        // const weatherDate = document.getElementById("weather-date");--%>
<%--                        // const weatherLocation = document.getElementById("weather-location");--%>
<%--                        // const weatherWeek = document.getElementById("weather-week");--%>
<%--                        // const weatherIcon = document.getElementById("weather-icon");--%>
<%--                        // const weatherDescription = document.getElementById("weather-description");--%>
<%--                        // const weatherTemperature = document.getElementById("weather-temperature");--%>
<%--                        // const weatherReporttime= document.getElementById("weather-reporttime");--%>
<%--                        const weatherDateTable = document.getElementById("weather-date-table");--%>
<%--                        const weatherIconTable = document.getElementById("weather-icon-table");--%>
<%--                        const weatherWeatherTempTable = document.getElementById("weather-weather-temp-table");--%>
<%--                        const weatherReporttime = document.getElementById("weather-reporttime");--%>
<%--                        const weatherLocation = document.getElementById("weather-location");--%>
<%--                        weatherReporttime.textContent = `更新时间：`+weatherData.forecasts[0].reporttime;--%>
<%--                        weatherLocation.textContent = weatherData.forecasts[0].province;--%>



<%--                        const casts = weatherData.forecasts[0].casts;--%>
<%--                        const daysToShow = 3; // 展示未来三天的数据--%>

<%--                        for (let i = 0; i < daysToShow && i < casts.length; i++) {--%>
<%--                            const cast = casts[i];--%>
<%--                            const dayWeatherCondition = cast.dayweather;--%>
<%--                            const nightWeatherCondition = cast.nightweather;--%>

<%--                            const dayIconUrl = getWeatherIcon(dayWeatherCondition);--%>
<%--                            const nightIconUrl = getWeatherIcon(nightWeatherCondition);--%>

<%--                            // 填充日期表格--%>
<%--                            const dateCell = document.createElement("td");--%>
<%--                            dateCell.textContent = cast.date + `   星期` + cast.week;--%>
<%--                            const dateRow = weatherDateTable.rows[0];--%>
<%--                            dateRow.appendChild(dateCell);--%>

<%--                            // 填充图标表格--%>
<%--                            const iconCell = document.createElement("td");--%>

<%--                            // 创建白天天气图标--%>
<%--                            const dayImg = document.createElement("img");--%>
<%--                            dayImg.src = dayIconUrl;--%>
<%--                            dayImg.alt = `白天天气：` + dayWeatherCondition;--%>
<%--                            dayImg.title = `白天天气：` + dayWeatherCondition; // 添加标题，方便鼠标悬停时显示--%>
<%--                            iconCell.appendChild(dayImg);--%>

<%--                            // 创建夜间天气图标--%>
<%--                            const nightImg = document.createElement("img");--%>
<%--                            nightImg.src = nightIconUrl;--%>
<%--                            nightImg.alt = `夜间天气：` + nightWeatherCondition;--%>
<%--                            nightImg.title = `夜间天气：` + nightWeatherCondition; // 添加标题，方便鼠标悬停时显示--%>
<%--                            // nightImg.style.marginLeft = "10px"; // 添加一些间距，避免图标重叠--%>
<%--                            iconCell.appendChild(nightImg);--%>

<%--                            const iconRow = weatherIconTable.rows[0];--%>
<%--                            iconRow.appendChild(iconCell);--%>

<%--                            // 填充天气状况和温度表格--%>
<%--                            const weatherTempCell = document.createElement("td");--%>
<%--                            weatherTempCell.textContent = cast.dayweather+`   `+cast.nighttemp+`°C~`+cast.daytemp+`°C`;--%>
<%--                            const weatherTempRow = weatherWeatherTempTable.rows[0];--%>
<%--                            weatherTempRow.appendChild(weatherTempCell);--%>
<%--                        }--%>

<%--                        // weatherReporttime.textContent = `更新时间：`+weatherData.forecasts[0].reporttime;--%>
<%--                        // weatherLocation.textContent = `地区：`+ weatherData.forecasts[0].province +`省`+ weatherData.forecasts[0].city;weatherLocation.textContent = `地区：`+ weatherData.forecasts[0].province +`省`+ weatherData.forecasts[0].city;--%>
<%--                        //--%>
<%--                        // const weatherCondition = weatherData.forecasts[0].casts[0].dayweather;--%>
<%--                        // const iconUrl = getWeatherIcon(weatherCondition); // 使用 getWeatherIcon 函数获取图标路径--%>
<%--                        //--%>
<%--                        // const dateCell = document.createElement("td");--%>
<%--                        // dateCell.textContent=weatherData.forecasts[0].casts[0].date+`   星期`+weatherData.forecasts[0].casts[0].week;--%>
<%--                        // const dateRow = weatherDateTable.rows[0];--%>
<%--                        // dateRow.appendChild(dateCell);--%>
<%--                        //--%>
<%--                        // const iconCell = document.createElement("td");--%>
<%--                        // const img = document.createElement("img");--%>
<%--                        // img.src = iconUrl;--%>
<%--                        // img.alt = `天气：` + weatherCondition;--%>
<%--                        // iconCell.appendChild(img);--%>
<%--                        // const iconRow = weatherIconTable.rows[0];--%>
<%--                        // iconRow.appendChild(iconCell);--%>
<%--                        //--%>
<%--                        // const weatherTempCell = document.createElement("td");--%>
<%--                        // weatherTempCell.textContent = weatherData.forecasts[0].casts[0].dayweather+`   `+weatherData.forecasts[0].casts[0].nighttemp+`°C~`+weatherData.forecasts[0].casts[0].daytemp+`°C`;--%>
<%--                        // const weatherTempRow = weatherWeatherTempTable.rows[0];--%>
<%--                        // weatherTempRow.appendChild(weatherTempCell);--%>
<%--                    } else {--%>
<%--                        alert("无法获取天气信息，请检查网络或授权位置信息。");--%>
<%--                    }--%>
<%--                } catch (error) {--%>
<%--                    console.error("Error displaying weather:", error);--%>
<%--                    alert("无法获取天气信息，请检查网络或授权位置信息。");--%>
<%--                }--%>
<%--            }--%>

<%--            // 调用函数--%>
<%--            displayWeather();--%>
<%--        });--%>
<%--    </script>--%>
    <script>
        // 全局变量
        const commentModal = new bootstrap.Modal(document.getElementById('commentModal'));
        const commentsListModal = new bootstrap.Modal(document.getElementById('commentsListModal'));
        function loadUserCenterData(event) {
            event.preventDefault(); // 阻止默认的链接跳转行为

            // // 显示加载状态（可选）
            // showLoading();

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

        // 景点点赞功能
        function toggleScenicLike(scenicId, element) {
            checkUserStatus().then(canProceed => {
                if (!canProceed) return;

            const $btn = $(element);
            const $likeCount = $btn.find('.like-count');
            const currentCount = parseInt($likeCount.text()) || 0;
            const isActive = $btn.hasClass('active');

            // 如果已经是点赞状态，不应该再次点赞
            if ($btn.data('processing')) return;

            $btn.data('processing', true);

            // 根据当前状态决定调用哪个API，修改4.23
            const url = isActive
                ? '${pageContext.request.contextPath}/scenic/unlike'
                : '${pageContext.request.contextPath}/scenic/like';

            // 立即更新UI（乐观更新）
            $btn.toggleClass('active');
            $likeCount.text(isActive ? currentCount - 1 : currentCount + 1);
            $btn.prop('disabled', true).addClass('loading');

            $.ajax({
                <%--url: '${pageContext.request.contextPath}/scenic/like',--%>
                url:url,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ scenicId: scenicId }),
                success: function(response) {
                    $btn.removeClass('loading').prop('disabled', false);
                    // 添加这一行，将processing标志位重置为false4.28
                    $btn.data('processing', false);
                    if (response.code === 200) {
                        // 成功时更新点赞数
                        $btn.toggleClass('active', !isActive);
                        $likeCount.text(response.data.likeCount);
                    } else if (response.code === 403) {
                        // 已点赞过的情况
                        // $btn.removeClass('active');
                        $btn.toggleClass('active'); // 回滚状态
                        $likeCount.text(response.data.likeCount);
                        alert(response.msg);
                    } else if (response.code === 401) {
                        // 未登录处理
                        window.location.href = '/login?redirect=' + encodeURIComponent(window.location.pathname);
                    } else if (response.code === 400 && response.msg === '用户已被禁用') {
                        // 用户被禁用处理
                        $btn.removeClass('active');
                        $likeCount.text(currentCount);
                        alert('您的账号已被禁用，无法点赞');
                    } else {
                        // 其他错误回滚UI状态
                        $btn.toggleClass('active');
                        $likeCount.text(currentCount);
                        alert(response.msg || '操作失败');
                    }
                },
                error: function(xhr) {
                    $btn.removeClass('loading').prop('disabled', false);
                    // 回滚UI状态
                    $btn.toggleClass('active');
                    $likeCount.text(currentCount);
                    alert('请求失败: ' + (xhr.responseJSON?.msg || xhr.statusText));
                }
            });
        });
        }

        // 景点收藏功能
        function toggleScenicFavorite(scenicId, element) {
            checkUserStatus().then(canProceed => {
                if (!canProceed) return;

                const $btn = $(element);
                $btn.addClass('loading');
                const isActive = $btn.hasClass('active');

                const url = isActive
                    ? '${pageContext.request.contextPath}/scenic/unfavorite'
                    : '${pageContext.request.contextPath}/scenic/favorite';



                $.ajax({
                    url: url,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ scenicId: scenicId }),
                    success: function(response) {
                        $btn.removeClass('loading');
                        if(response.code === 200) {
                            $btn.toggleClass('active');
                            if(response.msg) {
                                alert(response.msg);
                            }
                        }else if (!data.isActive) {
                            alert('您的账号已被禁用，无法评论');
                        }else {
                            alert(response.msg || '操作失败');
                        }
                    },
                    error: function(xhr) {
                        $btn.removeClass('loading');
                        alert('请求失败: ' + xhr.statusText);
                    }
                });
            });
        }


        // 路线点赞功能
        function toggleRouteLike(routeId, element) {
            checkUserStatus().then(canProceed => {
                if (!canProceed) return;

            const $btn = $(element);
            const $likeCount = $btn.find('.like-count');
            const currentCount = parseInt($likeCount.text()) || 0;
            const isActive = $btn.hasClass('active');

            // 如果已经是点赞状态，不应该再次点赞
            if ($btn.data('processing')) return;

            $btn.data('processing', true);

            // 根据当前状态决定调用哪个API
            const url = isActive
                ? '${pageContext.request.contextPath}/route/unlike'
                : '${pageContext.request.contextPath}/route/like';

            // 立即更新UI（乐观更新）
            $btn.toggleClass('active');
            $likeCount.text(isActive ? currentCount - 1 : currentCount + 1);
            $btn.prop('disabled', true).addClass('loading');

            $.ajax({
                <%--url: '${pageContext.request.contextPath}/route/like',--%>
                url:url,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ routeId: routeId }),
                success: function(response) {
                    $btn.removeClass('loading').prop('disabled', false);
                    $btn.data('processing', false); // 重置处理状态
                    if (!data.isActive) {
                        alert('您的账号已被禁用，无法评论');
                    }else if (response.code === 200) {
                        // 成功时更新点赞数
                        // 确保UI状态与后端一致
                        $btn.toggleClass('active', !isActive);
                        $likeCount.text(response.data.likeCount);
                    }
                    else if (response.code === 403) {
                        // 已点赞过的情况
                        // $btn.removeClass('active');
                        $btn.toggleClass('active'); // 回滚状态
                        $likeCount.text(response.data.likeCount);
                        alert(response.msg);
                    } else {
                        // 其他错误回滚UI状态
                        $btn.toggleClass('active');
                        $likeCount.text(currentCount);
                        alert(response.msg || '操作失败');
                    }
                },
                error: function(xhr) {
                    $btn.removeClass('loading').prop('disabled', false);
                    // 回滚UI状态
                    $btn.toggleClass('active');
                    $likeCount.text(currentCount);
                    alert('请求失败: ' + (xhr.responseJSON?.msg || xhr.statusText));
                }
            });
        });
        }


        // 路线收藏功能
        function toggleRouteFavorite(routeId, element) {
            checkUserStatus().then(canProceed => {
                if (!canProceed) return;

                const $btn = $(element);
                const isActive = $btn.hasClass('active');
                $btn.addClass('loading');

                const url = isActive
                    ? '${pageContext.request.contextPath}/route/unfavorite'
                    : '${pageContext.request.contextPath}/route/favorite';

                $.ajax({
                    url: url,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ routeId: routeId }),
                    success: function(response) {
                        $btn.removeClass('loading');
                        if(response.code === 200) {
                            $btn.toggleClass('active');
                            if(response.msg) {
                                alert(response.msg);
                            }
                        } else {
                            alert(response.message || '操作失败');
                        }
                    },
                    error: function(xhr) {
                        $btn.removeClass('loading');
                        alert('请求失败: ' + xhr.statusText);
                    }
                });
            });
        }

        $(document).ready(function() {
            //填充景点点赞数
            $('.like-count[data-scenic-id]').each(function() {
                const scenicId = $(this).data('scenic-id');
                const $span = $(this);

                $.ajax({
                    url: '${pageContext.request.contextPath}/scenic/status/' + scenicId,
                    type: 'GET',
                    success: function(response) {
                        $span.text(response.data.likeCount); // 填充最新值
                        console.log("Scenic ID:", scenicId);
                        console.log("Like Count:", response.data.likeCount);
                    }
                });
            });


            // 填充路线点赞数
            $('.like-count[data-route-id]').each(function() {
                const routeId = $(this).data('route-id');
                const $span = $(this);

                $.ajax({
                    url: '${pageContext.request.contextPath}/route/status/' + routeId,
                    type: 'GET',
                    success: function(response) {
                        $span.text(response.data.likeCount); // 填充最新值
                    }
                });
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

            // 景点收藏
            $('.scenic-favorite-btn').on('click', function() {
                toggleScenicFavorite($(this).data('id'), this);
            });

            // 景点评论
            $('.scenic-comment-btn').on('click', function() {
                const scenicId = $(this).data('id');
                $('#commentModalTitle').text('评论景点');
                $('#commentTargetId').val(scenicId);
                $('#commentType').val('scenic');
                commentModal.show();
            });
            // 路线点赞
            $('.route-like-btn').on('click', function() {
                toggleRouteLike($(this).data('id'), this);
            });

            // 路线收藏
            $('.route-favorite-btn').on('click', function() {
                toggleRouteFavorite($(this).data('id'), this);
            });

            // 路线评论
            $('.route-comment-btn').on('click', function() {
                const routeId = $(this).data('id');
                $('#commentModalTitle').text('评论路线');
                $('#commentTargetId').val(routeId);
                $('#commentType').val('route');
                commentModal.show();
            });
        });
        // 提交评论
        // 提交评论
        function submitComment() {
            const content = $('#commentContent').val().trim();
            const targetId = $('#commentTargetId').val();
            const type = $('#commentType').val();

            if (!content) {
                alert('评论内容不能为空');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/comment/add',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    [type + 'Id']: targetId, // 动态设置 scenicId 或 routeId
                    content: content
                }),
                success: function(response) {
                    if (response.code === 200) {
                        alert('评论发表成功');
                        commentModal.hide();
                        // 刷新评论列表
                        loadComments(targetId, type);
                    } else {
                        alert(response.msg || '评论发表失败');
                    }
                },
                error: function(xhr) {
                    alert('请求失败: ' + xhr.statusText);
                }
            });
        }

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

        // 设置默认配置
        const option = {
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
                    console.log("ss"+data)
                    if (data) {
                        return `景点：`+data.name+`<br/>省份：`+data.province+`<br/>地址：`+data.address+`<br/>坐标：`+data.value[0]+`, `+data.value[1];
                    } else {
                        return '数据缺失';
                    }
                },
                enterable: true, // 允许鼠标进入 tooltip
                alwaysShowContent: false, // 不总是显示内容
                confine: true // 限制 tooltip 在图表区域内
            },
            geo: {
                map: 'china',
                roam: true,
                label: {
                    show: true,
                    color: '#666'
                },
                zoom: currentZoom,
                center: [104.114129, 37.550339],
                itemStyle: {
                    areaColor: '#e9f5ff',
                    borderColor: '#dc3545',
                    borderWidth: 1.2
                },
                emphasis: {
                    itemStyle: {
                        areaColor: '#ffe7e7'
                    }
                }
            }
        };

        mapChart.setOption(option);

        // 从 session 中获取数据并更新地图
        const points = [
            <c:forEach items="${points}" var="point" varStatus="status">
            {
                name: '${point.name}',
                province: '${point.province}',
                address: '${point.address}',
                value: [${point.lng}, ${point.lat}]
            }<c:if test="${not status.last}">,</c:if>
            </c:forEach>
        ];

        console.log('Points data:', points);
        const optionWithData = {
            series: [{
                type:'scatter',
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
                    itemStyle: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(220, 53, 69, 0.5)'
                    }
                },
                data: points
            }]
        };

        mapChart.setOption(optionWithData);

        // 窗口大小变化时自适应
        window.addEventListener('resize', function () {
            mapChart.resize();
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
    // 页面加载完成后初始化地图
    document.addEventListener('DOMContentLoaded', function () {
        initChinaMap();
    });
</script>
<div id="idmmm" style="position: fixed; top: 200px; right: 180px; height: 900px;"></div>
<script src="https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.2.0-beta.6/libs/cn/index.js"></script>
<script>

    new CozeWebSDK.WebChatClient({
        config: {
            bot_id: '7496828922253525032',
        },
        componentProps: {
            title: '红迹云游小助手',
        },
        userInfo: userInfo, // 使用从服务器获取的用户信息
        auth: {
            type: 'token',
            token: 'pat_tYDwpMB5TxSYzKvaGGfpxzBR5CCA05XfxjZFnkqcX9niFjHF0bZgGDKQfHcwxyOo',
            onRefreshToken: function () {
                return 'pat_tYDwpMB5TxSYzKvaGGfpxzBR5CCA05XfxjZFnkqcX9niFjHF0bZgGDKQfHcwxyOo'
            }
        },
        ui: {
            base: {
                icon: 'http://localhost:8080/RedTourismSystem/assets/images/r_ai.png',
                layout: 'pc',
                lang: 'zh-CN',
                zIndex: 1000,
            },
            asstBtn: {
                isNeed: true,
            },
            footer: {
                isShow: true,
                expressionText: '红迹云游',
            },
            chatBot: {
                title: '红迹云游小助手',
                el: document.getElementById('idmmm') // 确保页面中有id为id1的元素
            }
        }
    });
</script>
</body>
</html>