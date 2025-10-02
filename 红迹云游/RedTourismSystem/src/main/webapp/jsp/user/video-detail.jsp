<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${video.title} - 红色视频</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }

        .video-container {
            background-color: #000;
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 20px;
        }
        .video-player {
            width: 100%;
            height: 0;
            padding-bottom: 56.25%;
            position: relative;
        }
        .video-player iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .video-info {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .video-title {
            color: #dc3545;
            margin-bottom: 15px;
        }
        .video-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .view-count {
            color: #6c757d;
        }
        .btn-like {
            color: #dc3545;
            background-color: transparent;
            border: none;
        }
        .btn-like.active {
            color: #dc3545;
        }
        .video-description {
            color: #495057;
            line-height: 1.6;
        }
        .related-videos {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .related-title {
            color: #dc3545;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .related-video {
            display: flex;
            margin-bottom: 15px;
            cursor: pointer;
            transition: transform 0.3s;
        }
        .related-video:hover {
            transform: translateX(5px);
        }
        .related-thumbnail {
            width: 120px;
            height: 68px;
            border-radius: 4px;
            overflow: hidden;
            flex-shrink: 0;
        }
        .video-card {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            margin-top: 20px;
        }
        .related-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .related-info {
            margin-left: 15px;
            flex-grow: 1;
        }
        .related-video-title {
            font-weight: bold;
            margin-bottom: 5px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .related-video-meta {
            color: #6c757d;
            font-size: 12px;
        }
        .comment-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .comment-title {
            color: #dc3545;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .comment-item {
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .comment-user {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }
        .user-name {
            font-weight: bold;
            color: #343a40;
        }
        .comment-time {
            color: #6c757d;
            font-size: 12px;
            margin-left: 10px;
        }
        .comment-content {
            color: #495057;
            line-height: 1.6;
        }
        .comment-form {
            margin-top: 20px;
        }
        .video-info.no-margin-bottom {
            margin-bottom: 0 !important;
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
<!-- 替换原来的静态结构 -->
<div class="container mt-4">
    <div class="row" id="videoDetailContainer">
        <!-- 主视频内容由 JS 动态插入 -->
    </div>

    <div class="row mt-4" id="relatedVideosContainer">
        <div class="col-12">
            <div class="related-videos" style="margin-bottom: 40px">
                <h4 class="related-title">相关视频</h4>
                <div class="row g-3" id="relatedVideoCards">
                    <!-- 视频卡片由 JS 动态插入 -->
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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
    // 获取 URL 参数中的 videoId
    const urlParams = new URLSearchParams(window.location.search);
    const videoId = urlParams.get('id');

    // 获取容器元素
    const container = $('#videoDetailContainer');
    let relatedVideosContainer = $('#relatedVideosContainer');

    // console.log(videoId)
    // 加载视频详情
    function loadVideoDetail(id) {
        fetch("${pageContext.request.contextPath}/video/"+id, {
            method: "GET",
            credentials: "include" // 👈 添加这一行，确保 session 被保留
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    renderVideoDetail(data.data);
                    updateViewCount(data.data.viewCount);
                } else {
                    container.html('<p class="text-center text-danger">加载视频失败</p>');
                }
            })
            .catch(error => {
                console.error('请求失败:', error);
                container.html('<p class="text-center text-danger">网络异常，请重试</p>');
            });
    }

    // 加载相关视频
    function loadRelatedVideos(id) {
        fetch(`${pageContext.request.contextPath}/video/`+id+`/related`)
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    renderRelatedVideos(data.data);
                }
            })
            .catch(error => {
                console.error('加载相关视频失败:', error);
            });
    }

    // 构建主视频信息
    function renderVideoDetail(video) {
        container.empty();

        // 创建外层容器 col-lg-8
        const cardCol = $('<div>').addClass('col-lg-12');

        // 视频播放器区域
        const videoContainer = $('<div>').addClass('video-container');
        const playerDiv = $('<div>').addClass('video-player');
        const iframe = $('<iframe>')
            .attr('src', 'http://localhost:8080/RedTourismSystem/' + video.videoUrl)
            .attr('frameborder', 0)
            .attr('allowfullscreen', true);

        playerDiv.append(iframe);
        videoContainer.append(playerDiv);
        // 返回按钮 - 放置在视频播放器右上角
        const backButton = $('<button>')
            .addClass('btn btn-warning position-absolute top-0 end-0 m-3')
            .attr('style', 'z-index: 10;')
            .append($('<i>').addClass('bi bi-arrow-left me-1'))
            .append('返回视频列表')
            .on('click', function () {
               window.location.href = 'video-list.jsp?refresh=1'
            });

        playerDiv.append(iframe, backButton);


        // 视频信息区域
        const infoDiv = $('<div>').addClass('video-info no-margin-bottom');


        // 标题
        const title = $('<h2>').addClass('video-title').text(video.title);

        // 浏览数和点赞按钮
        const metaDiv = $('<div>').addClass('video-meta');
        const viewCount = $('<span>').attr('id', 'view-count') // 添加 id
            .addClass('view-count')
            .append($('<i>').addClass('bi bi-eye'))
            .append(video.viewCount + ` 次观看`);


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

        // 描述
        const description = $('<div>').addClass('video-description').text(video.description);

        // 组装信息区域
        infoDiv.append(title, metaDiv, description);


        // 合并整个卡片
        cardCol.append(videoContainer, infoDiv);
        container.append(cardCol);


        bindLikeButtons(); // 绑定点赞事件
    }
    function updateViewCount(newCount) {
        const $viewCount = $('#view-count');
        if ($viewCount.length) {
            $viewCount.empty()
                .append($('<i>').addClass('bi bi-eye'))
                .append(newCount + ' 次观看');
        }
    }


    function renderRelatedVideos(videos) {
        const container = $('#relatedVideoCards'); // 确保是 .row.g-3
        container.empty(); // 清空旧数据

        if (!videos || videos.length === 0) {
            container.append('<p class="text-center w-100">暂无相关视频</p>');
            return;
        }

        videos.forEach(video => {
            const cardCol = $('<div>').addClass('col-md-4 mb-3'); // 每行显示 3 个

            const videoCard = $('<div>')
                .addClass('video-card')
                .attr('data-category', video.category)
                .on('click', () => viewVideo(video.id));

            const thumbnailDiv = $('<div>').addClass('video-thumbnail');
            const img = $('<img>')
                .attr('src', 'http://localhost:8080/RedTourismSystem/' + video.coverImage)
                .addClass('img-fluid')
                .css({
                    width: '100%',
                    height: '180px',
                    objectFit: 'cover'
                });

            thumbnailDiv.append(img);

            const infoDiv = $('<div>').addClass('video-info');

            const title = $('<h5>').addClass('video-title').text(video.title);

            const metaDiv = $('<div>').addClass('video-meta');

            const viewCount = $('<span>')
                .append($('<i>').addClass('bi bi-eye'))
                .append(video.viewCount ?? 0);

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
            container.append(cardCol); // 插入到 row 容器中
        });

        bindLikeButtons();
    }




    // 创建点赞图标
    function createLikeIcon(isLiked) {
        return $('<i>').addClass('bi')
            .addClass(isLiked ? 'bi-heart-fill' : 'bi-heart');
    }

    function bindLikeButtons() {
        $('#videoDetailContainer').off('click', '.btn-like').on('click', '.btn-like', function (e) {
            e.stopPropagation();
            const $btn = $(this);
            const videoId = $btn.data('video-id');
            const isLiked = $btn.hasClass('active');
            const $icon = $btn.find('i');
            const $count = $btn.find('.like-count');

            // 先更新 UI
            if (isLiked) {
                $count.text(parseInt($count.text()) - 1);
            } else {
                $count.text(parseInt($count.text()) + 1);
            }
            $icon.toggleClass('bi-heart-fill bi-heart');
            $btn.toggleClass('active');

            // 发送请求
            $.ajax({
                url: '${pageContext.request.contextPath}/video/like',
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


    // 页面初始化时加载视频详情和相关视频
    $(document).ready(function() {
        if (videoId) {
            // increaseViewCount(videoId); // 添加这一行
            loadVideoDetail(videoId);
            loadRelatedVideos(videoId);
            loadComments(videoId);
            // 不再直接调用increaseViewCount，改为由后端控制
        } else {
            alert('无效的视频ID');
            window.location.href = 'video-list.jsp';
        }

        // 绑定点赞按钮事件
        $('#likeBtn').click(function() {
            toggleLikeVideo(videoId);
        });
    });

    function viewVideo(id) {
        window.location.href = 'video-detail.jsp?id=' + id;
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
</script>

</body>
</html>