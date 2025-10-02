<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<html>
<head>
    <title>景点详情 - 红色旅游系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
            color: white !important;
            font-weight: bold;
        }
        .nav-link:hover {
            color: #ffc107 !important;
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
        .scenic-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .btn-action {
            padding: 5px 10px;
            font-size: 12px;
        }
        .btn-like {
            color: #B3100f;
        }
        .btn-like.active {
            background-color: #B3100f;
            color: white;
        }
        .btn-favorite {
            color: #ffc107;
        }
        .btn-favorite.active {
            background-color: #ffc107;
            color: white;
        }

        .info-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }
        .info-value {
            margin-bottom: 1rem;
        }
        .section-title {
            color: #B3100f;
            margin: 2rem 0 1rem;
            font-weight: bold;
            border-left: 5px solid #B3100f;
            padding-left: 15px;
        }
        .back-btn {
            margin-top: 1rem;
        }

        /* 评论容器样式--------------------------------------- */
        .comment-item {
            background-color: #f8f9fa !important; /* 浅灰背景 */
            border: 1px solid #e9ecef !important;  /* 边框颜色 */
            border-radius: 8px !important;         /* 圆角 */
            margin-bottom: 12px !important;        /* 间距 */
            padding: 12px 15px !important;         /* 内边距 */
        }

        /* 用户名样式 */
        .username {
            color: #0d6efd !important; /* 蓝色 */
            font-weight: 600 !important;
            margin-right: 8px;
        }

        /* 时间戳样式 */
        .timestamp {
            color: #6c757d !important; /* 灰色 */
            font-size: 0.875em !important;
            white-space: nowrap;
        }

        /* 评论内容样式 */
        .comment-content {
            color: #212529 !important; /* 深灰色 */
            line-height: 1.6;
            margin-top: 8px !important;
        }

        /* 响应式布局优化 */
        @media (max-width: 768px) {
            .comment-header {
                flex-direction: column;
                align-items: flex-start !important;
            }
            .timestamp {
                margin-top: 4px;
                align-self: flex-end !important;
            }
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

        /* 调整原有页脚样式 */
        footer {
            background-color: #8b1515 !important; /* 改为红色主题 */
            margin-top: 100px;
            position: relative;
            margin-top: auto;
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

    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
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
                    <a class="nav-link" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../user/login.jsp">注册/登录</a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="text-end back-btn">
                <button class="btn btn-secondary" onclick="window.history.back()">
                    <i class="bi bi-arrow-left"></i> 返回景点列表
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img id="scenicCoverImage" class="scenic-image" src="" alt="景点图片">
            <div class="text-center mt-3">
                <%--<button class="btn btn-outline-danger btn-like btn-action mx-2" id="likeBtn" onclick="toggleLike()">--%>
                <button class="btn btn-outline-danger btn-like btn-action mx-2" id="likeBtn" onclick="alert('请先登录!')">
                    <i class="bi bi-hand-thumbs-up"></i> 点赞
                    <span class="like-count" id="likeCount">0</span>
                </button>
                <%--<button class="btn btn-outline-danger btn-favorite btn-action mx-2" id="favoriteBtn" onclick="toggleFavorite()">--%>
                <button class="btn btn-outline-danger btn-favorite btn-action mx-2" id="favoriteBtn" onclick="alert('请先登录!')">
                    <i class="bi bi-heart"></i> 收藏
                </button>
            </div>
        </div>
        <div class="col-md-6">
            <div class="info-card">
                <h1 class="scenic-title" id="scenicName">景点名称</h1>
                <div class="d-flex align-items-center mb-3">
                    <span class="badge bg-danger me-2" id="scenicLevel">等级</span>
                    <span class="text-muted" id="scenicLocation"></span>
                </div>
                <div class="info-label">省份</div>
                <div class="info-value" id="scenicProvince"></div>
                <div class="info-label">城市</div>
                <div class="info-value" id="scenicCity"></div>
                <div class="info-label">地址</div>
                <div class="info-value" id="scenicAddress"></div>
                <div class="info-label">开放时间</div>
                <div class="info-value" id="scenicOpenningHours"></div>
                <div class="info-label">门票信息</div>
                <div class="info-value" id="scenicTicketInfo"></div>
                <div class="info-label">简介</div>
                <div class="info-value" id="scenicDescription"></div>
            </div>
        </div>
    </div>
</div>

<!-- 评论区域 -->
<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="section-title">评论列表</h3>
                <%--<button class="btn btn-sm btn-primary btn-action" onclick="showCommentBox()">--%>
                <button class="btn btn-sm btn-primary btn-action" onclick="alert('请先登录!')">
                    <i class="bi bi-chat"></i> 评论
                </button>
            </div>
            <div id="commentsBody">
                <!-- 评论内容将在这里动态加载 -->
            </div>
        </div>
    </div>
</div>

<!-- 页脚 -->
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
    const urlParams = new URLSearchParams(window.location.search);
    const scenicId = urlParams.get('id');
    let scenicData = null;
    const contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function() {
        if (scenicId) {
            loadScenicDetail(scenicId);
            loadComments(scenicId); // 自动加载评论
        } else {
            alert('无效的景点ID');
            window.location.href = 'scenic-list.jsp';
        }
    });

    function loadScenicDetail(id) {
        $.ajax({
            // url: '/scenic/' + id,
            url: contextPath + '/guest/scenic/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    scenicData = response.data;
                    renderScenicDetail(scenicData);
                } else {
                    alert('获取景点详情失败: ' + response.msg);
                    window.location.href = 'scenic-list.jsp';
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'scenic-list.jsp';
            }
        });
    }
    //渲染景点

    function renderScenicDetail(scenic) {
        $('#scenicName').text(scenic.name);
        $('#scenicLevel').text(scenic.level || '暂无评级');
        $('#scenicLocation').text(`${scenic.province} · ${scenic.city}`);
        <%--$('#scenicCoverImage').attr('src', `${pageContext.request.contextPath}/scenic/image/` + scenic.id);--%>
        $('#scenicCoverImage').attr('src', `${pageContext.request.contextPath}/`+scenic.coverImage);
        $('#scenicDescription').text(scenic.description || '暂无简介');
        $('#scenicAddress').text(scenic.address || '暂无地址');
        $('#scenicOpenningHours').text(scenic.openningHours || '暂无信息');
        $('#scenicTicketInfo').text(scenic.ticketInfo || '暂无信息');
        $('#likeCount').text(scenic.likeCount || 0);
        $('#likeCountText').text(scenic.likeCount || 0);

        // 渲染省份和城市
        $('#scenicProvince').text(scenic.province || '暂无省份信息');
        $('#scenicCity').text(scenic.city || '暂无城市信息');
        $('#scenicKeywords').text(scenic.keywords || '暂无关键词');
    }

    function loadComments(z) {
        $('#commentsBody').html(`
            <div class="text-center py-4">
                <div class="spinner-border text-primary"></div>
                <p class="mt-2">加载评论中...</p>
            </div>
        `);

        $.ajax({
            url:contextPath+ '/guest/scenic/formattedList/' + scenicId,
            // url:contextPath+'/guest/scenic/formattedList/' + scenicId,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    $('#commentsBody').html(response.msg);
                } else {
                    $('#commentsBody').html(`
                        <div class="alert alert-danger">
                            ${response.msg || '加载评论失败'}
                        </div>
                    `);
                }
            },
            error: function(xhr) {
                $('#commentsBody').html(`
                    <div class="alert alert-danger">
                        请求失败: ${xhr.statusText}
                    </div>
                `);
            }
        });
    }

</script>
</body>
</html>