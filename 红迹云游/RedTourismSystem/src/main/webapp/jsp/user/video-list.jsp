<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 2025/4/11
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红脉传承·影像课堂</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }
        .section-title {
            color: #dc3545;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        .video-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .video-thumbnail {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .play-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 48px;
            opacity: 0.8;
        }
        .video-duration {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
        }
        .video-info {
            padding: 15px;
        }
        .video-title {
            font-weight: bold;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .video-meta {
            display: flex;
            justify-content: space-between;
            color: #6c757d;
            font-size: 14px;
        }
        .search-container {
            max-width: 800px;
            margin: 20px auto;
        }
        .btn-like {
            color: #dc3545;
            background-color: transparent;
            border: none;
        }
        .btn-like.active {
            color: #dc3545;
        }
        .category-filter {
            margin-bottom: 20px;
        }
        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .page-info {
            text-align: center;
            color: #6c757d;
        }
        .nav-pills-button {
            background-color: #dc3545; /* 设置按钮底色 */
            color: white;
        }
        .nav-pills-button:hover {
            background-color: #ffc107; /* 鼠标悬停时的底色 */
            color: black;
        }

        .avatar-preview{
            width: 250px;
            height: 250px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
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
<div class="container mt-4">
    <h3 class="section-title">红脉传承·影像课堂</h3>

    <!-- 搜索框 -->
    <div class="search-container">
        <div class="input-group mb-4">
            <input type="text" class="form-control" placeholder="搜索视频..." id="searchInput">
            <button class="btn btn-danger" type="button" id="searchBtn">
                <i class="bi bi-search"></i> 搜索
            </button>
        </div>
    </div>

    <!-- 分类筛选 -->
    <div class="category-filter">
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-outline-danger active" data-category="all">全部</button>
            <c:forEach var="category" items="${categories}">
                <button type="button" class="btn btn-outline-danger" data-category="${category}">${category}</button>
            </c:forEach>
        </div>
    </div>

    <!-- 视频列表 -->
    <div class="row" id="videoListContainer">
    </div>
    <!-- 分页信息 -->
    <div class="page-info" id="pageInfo">
        第 <span id="currentPage">1</span> 页，共 <span id="totalPages">1</span> 页
    </div>

    <!-- 分页控件 -->
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item" id="prevPage">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo; 上一页</span>
                    </a>
                </li>
                <li class="page-item" id="nextPage">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">下一页 &raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    let currentPage = 1; // 当前页码
    const videosPerPage = 9; // 每页显示的视频数量
    let allVideos = []; // 存储所有视频数据

    $(document).ready(function () {
        // 检查是否带有 refresh 参数，用于从详情页返回时刷新数据
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('refresh')) {
            // 移除 refresh 参数避免无限刷新
            const newUrl = window.location.pathname;
            window.history.replaceState(null, '', newUrl);

            // 重新加载视频列表
            loadVideos();
        }

        // 初始化加载所有视频
        loadVideos();
        loadCategories();

        // 搜索功能
        $('#searchBtn').click(function () {
            const keyword = $('#searchInput').val().trim().toLowerCase();
            currentPage = 1;
            loadVideos(keyword);
        });

        // 分类筛选
        $('.category-filter .btn').click(function () {
            const category = $(this).data('category');
            $('.category-filter .btn').removeClass('active');
            $(this).addClass('active');
            currentPage = 1;
            if (category === 'all') {
                loadVideos();
            } else {
                loadVideos(null, category);
            }
        });
        // 上一页
        $('#prevPage').click(function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                loadVideos($('#searchInput').val().trim(), $('.category-filter .btn.active').data('category'));
            }
        });

        // 下一页
        $('#nextPage').click(function (e) {
            e.preventDefault();
            const total = Math.ceil(allVideos.length / videosPerPage);
            if (currentPage < total) {
                currentPage++;
                loadVideos($('#searchInput').val().trim(), $('.category-filter .btn.active').data('category'));
            }
        });
    });
    function loadCategories() {
        $.ajax({
            url: '/RedTourismSystem/video/list',
            method: 'GET',
            success: function (response) {
                if (response.code === 200) {
                    const categories = [...new Set(response.data.map(video => video.category))];
                    renderCategories(categories);
                }
            },
            error: function (xhr) {
                console.error('加载分类失败:', xhr.statusText);
            }
        });
    }

    function renderCategories(categories) {
        const container = $('.category-filter .btn-group');
        container.empty();

        // 全部按钮
        const allBtn = $('<button>')
            .attr('type', 'button')
            .addClass('btn btn-outline-danger active')
            .data('category', 'all')
            .text('全部');
        container.append(allBtn);

        // 分类按钮
        categories.forEach(category => {
            const btn = $('<button>')
                .attr('type', 'button')
                .addClass('btn btn-outline-danger')
                .data('category', category)
                .text(category);

            container.append(btn);
        });

        // 绑定点击事件
        $('.category-filter .btn').off('click').on('click', function () {
            const category = $(this).data('category');
            $('.category-filter .btn').removeClass('active');
            $(this).addClass('active');

            if (category === 'all') {
                loadVideos();
            } else {
                loadVideos(null, category);
            }
        });
    }

    let currentKeyword = '';
    let currentCategory = 'all';

    function loadVideos(keyword = '', category = '') {
        currentKeyword = keyword;
        currentCategory = category;

        let url = '/RedTourismSystem/video/list';
        if (category && category !== 'all') {
            url = '/RedTourismSystem/video/listByCategory?category=' + encodeURIComponent(category);
        }

        $.ajax({
            url: url,
            method: 'GET',
            success: function (response) {
                if (response.code === 200) {
                    allVideos = response.data;
                    renderVideoList(allVideos, currentKeyword);
                } else {
                    $('#videoListContainer').html('<p class="text-center text-danger">加载视频失败</p>');
                }
            },
            error: function (xhr, status, error) {
                console.error('请求失败:', error);
                $('#videoListContainer').html('<p class="text-center text-danger">网络异常，请重试</p>');
            }
        });
    }


    function renderVideoList(videos, keyword = '') {
        const container = $('#videoListContainer');
        container.empty();

        if (!videos || videos.length === 0) {
            container.append('<p class="text-center w-100">暂无视频</p>');
            return;
        }

        // 过滤关键词
        // 安全地进行关键词过滤
        const filtered = videos.filter(video => {
            const title = video.title ? video.title.toString() : '';
            const searchKeyword = keyword ? keyword.toString().toLowerCase() : '';
            return title.toLowerCase().includes(searchKeyword);
        });

        // 计算分页
        const totalPages = Math.ceil(filtered.length / videosPerPage);
        $('#currentPage').text(currentPage);
        $('#totalPages').text(totalPages);

        const start = (currentPage - 1) * videosPerPage;
        const end = start + videosPerPage;
        const videosToShow = filtered.slice(start, end);
        console.log("ss"+videosToShow);
        // 如果当前页没有视频
        if (videosToShow.length === 0 && filtered.length > 0) {
            $('#videoListContainer').html('<p class="text-center text-danger">当前页无视频，请切换页码</p>');
            return;
        }
        videosToShow.forEach(video => {
            const cardCol = $('<div>').addClass('col-md-4 col-sm-6 mb-4');
            const videoCard = $('<div>').addClass('video-card');

            // 缩略图部分
            const thumbnailDiv = $('<div>').addClass('video-thumbnail');
            const img = $('<img>')
                .attr('src', 'http://localhost:8080/RedTourismSystem/' + video.coverImage)
                .on('click', () => viewVideo(video.id));
            const playIcon = $('<div>').addClass('play-icon').append($('<i>').addClass('bi bi-play-circle-fill'));
            const durationLabel = $('<div>').addClass('video-duration').text(video.duration);
            thumbnailDiv.append(img, playIcon, durationLabel);

            // 视频信息部分
            const infoDiv = $('<div>').addClass('video-info');
            const title = $('<h5>').addClass('video-title').text(video.title);

            const metaDiv = $('<div>').addClass('video-meta');
            const viewCount = $('<span>').append($('<i>').addClass('bi bi-eye')).append(video.viewCount ?? 0);
            const likeBtn = $('<button>')
                .addClass('btn-like')
                .toggleClass('active', video.liked)
                .attr('data-video-id', video.id)
                .append(
                    createLikeIcon(video.liked),
                    ' ',
                    $('<span>').addClass('like-count').text(video.likeCount ?? 0)
                );
            metaDiv.append(viewCount, likeBtn);

            infoDiv.append(title, metaDiv);
            videoCard.append(thumbnailDiv, infoDiv);
            cardCol.append(videoCard);
            container.append(cardCol);
        });

        bindLikeButtons();
    }


    function createLikeIcon(isLiked) {
        return $('<i>').addClass('bi')
            .addClass(isLiked ? 'bi-heart-fill' : 'bi-heart');
    }




    // 替换原来的 bindLikeButtons 函数
    function bindLikeButtons() {
        // 使用 on-delegate 方式绑定，避免重复绑定
        $('#videoListContainer').off('click', '.btn-like').on('click', '.btn-like', function (e) {
            e.stopPropagation();
            const $btn = $(this);
            const videoId = $btn.data('video-id');
            const isLiked = $btn.hasClass('active');
            const $icon = $btn.find('i');
            const $count = $btn.find('.like-count');

            // 先更新 UI 状态
            if (isLiked) {
                $count.text(parseInt($count.text()) - 1);
            } else {
                $count.text(parseInt($count.text()) + 1);
            }
            $icon.toggleClass('bi-heart-fill bi-heart');
            $btn.toggleClass('active');

            // 发送请求
            // 修改 bindLikeButtons 函数中的 $.ajax 请求部分
            $.ajax({
                url: '/RedTourismSystem/video/like', // 统一调用这个接口
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ videoId: videoId }),
                success: function (response) {
                    if (response.code === 200) {
                        const newLikeCount = response.data.likeCount;
                        const newLikedStatus = response.data.liked;

                        // 强制设置图标和按钮状态
                        if (newLikedStatus) {
                            $icon.removeClass('bi-heart').addClass('bi-heart-fill');
                            $btn.addClass('active');
                        } else {
                            $icon.removeClass('bi-heart-fill').addClass('bi-heart');
                            $btn.removeClass('active');
                        }

                        $count.text(newLikeCount);
                    } else {
                        alert(response.msg || '操作失败');
                        // 回滚 UI
                        if (isLiked) {
                            $count.text(parseInt($count.text()) - 1);
                        } else {
                            $count.text(parseInt($count.text()) + 1);
                        }
                        $icon.toggleClass('bi-heart bi-heart-fill');
                        $btn.toggleClass('active');
                    }
                },
                error: function (xhr) {
                    alert('请求失败: ' + xhr.statusText);
                    // 回滚 UI
                    if (isLiked) {
                        $count.text(parseInt($count.text()) - 1);
                    } else {
                        $count.text(parseInt($count.text()) + 1);
                    }
                    $icon.toggleClass('bi-heart bi-heart-fill');
                    $btn.toggleClass('active');
                }
            });
        });
    }
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


    function viewVideo(videoId) {
        window.location.href = 'video-detail.jsp?id=' + videoId;
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
</script>


</body>
</html>
