<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>路线详情 - 红色旅游系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }
        .route-header {
            background-color: #fff;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .route-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .route-title {
            color: #dc3545;
            margin-bottom: 1rem;
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
            color: #dc3545;
            margin: 2rem 0 1rem;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        .back-btn {
            margin-top: 1rem;
        }
        .scenic-card {
            transition: transform 0.3s;
        }
        .scenic-card:hover {
            transform: translateY(-5px);
        }
        .btn-like.active, .btn-favorite.active {
            color: #ffffff;
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-like:hover, .btn-favorite:hover {
            color: #ffffff;
            background-color: #dc3545;
            border-color: #dc3545;
        }
        #routeDescription {
            text-indent: 2em; /* 首行缩进两个字符 */
            white-space: pre-wrap; /* 保留空白符并允许换行 */
            word-wrap: break-word; /* 防止长单词溢出 */
            line-height: 2; /* 行高，可根据需要调整 */
        }
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
        .row{
            margin-top: 20px;
        }

    </style>
</head>
<body>
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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="text-end back-btn">
                <button class="btn btn-danger" onclick="window.history.back()">
                    <i class="bi bi-arrow-left"></i> 返回路线列表
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img id="routeCoverImage" class="route-image" src="" alt="路线图片">
            <div class="text-center mt-3">
                <button class="btn btn-outline-danger btn-like btn-action mx-2" id="likeBtn" onclick="toggleLike()">
                    <i class="bi bi-hand-thumbs-up"></i> 点赞
                    <span class="like-count" id="likeCount">0</span>
                </button>
                <button class="btn btn-outline-danger btn-favorite btn-action mx-2" id="favoriteBtn" onclick="toggleFavorite()">
                    <i class="bi bi-heart"></i> 收藏
                </button>
            </div>
        </div>
        <div class="col-md-6">
            <div class="info-card">
                <h1 class="route-title" id="routeName">路线名称</h1>
                <h3 class="section-title">路线详情</h3>
                <p id="routeDescription" class="mb-0"></p>
            </div>
        </div>
    </div>
</div>

<!-- 评论区域 -->

<div class="container mt-5">
    <div class="row">
        <div class="col-md-12 d-flex justify-content-between align-items-center">
            <h3 class="section-title">评论列表</h3>
            <button class="btn btn-primary btn-sm" onclick="showCommentBox()">
                <i class="bi bi-chat"></i> 添加评论
            </button>
        </div>
        <div class="col-md-12">
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 从URL获取路线ID
    const urlParams = new URLSearchParams(window.location.search);
    const routeId = urlParams.get('id');
    let routeData = null;

    $(document).ready(function() {
        if (routeId) {
            loadRouteDetail(routeId);
            loadComments(routeId); // 自动加载评论
        } else {
            alert('无效的路线ID');
            window.location.href = 'route-list.jsp';
        }
    });

    // 加载路线详情
    function loadRouteDetail(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/route/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    routeData = response.data;
                    renderRouteDetail(routeData);
                } else {
                    alert('获取路线详情失败: ' + response.msg);
                    window.location.href = 'route-list.jsp';
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'route-list.jsp';
            }
        });
    }

    // 渲染路线详情
    function renderRouteDetail(route) {
        $('#routeName').text(route.name);
        $('#routeCoverImage').attr('src', `${pageContext.request.contextPath}/` + route.coverImage);
        $('#routeDescription').text(route.description || '暂无简介');
        $('#likeCount').text(route.likeCount || 0);
        $('#likeCountText').text(route.likeCount || 0);
    }

    // 点赞功能
    function toggleLike() {
        if (!routeData) return;

        const likeBtn = $('#likeBtn');
        const isActive = likeBtn.hasClass('active');
        const likeCountEl = $('#likeCount');
        const likeCountTextEl = $('#likeCountText');
        let currentCount = parseInt(likeCountEl.text()) || 0;

        // 立即更新UI（乐观更新）
        if (isActive) {
            likeBtn.removeClass('active');
            likeCountEl.text(currentCount - 1);
            likeCountTextEl.text(currentCount - 1);
        } else {
            likeBtn.addClass('active');
            likeCountEl.text(currentCount + 1);
            likeCountTextEl.text(currentCount + 1);
        }

        // 发送请求到后端
        $.ajax({
            url: '${pageContext.request.contextPath}/route/like',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ routeId: routeData.id }),
            success: function(response) {
                if (response.code === 200) {
                    const data = response.data;
                    likeCountEl.text(data.likeCount);
                    likeCountTextEl.text(data.likeCount);
                    alert(response.msg || '点赞成功');
                } else {
                    // 回滚UI状态
                    if (isActive) {
                        likeBtn.addClass('active');
                        likeCountEl.text(currentCount);
                        likeCountTextEl.text(currentCount);
                    } else {
                        likeBtn.removeClass('active');
                        likeCountEl.text(currentCount);
                        likeCountTextEl.text(currentCount);
                    }
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                // 回滚UI状态
                if (isActive) {
                    likeBtn.addClass('active');
                    likeCountEl.text(currentCount);
                    likeCountTextEl.text(currentCount);
                } else {
                    likeBtn.removeClass('active');
                    likeCountEl.text(currentCount);
                    likeCountTextEl.text(currentCount);
                }
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }
    // 显示评论输入框
    function showCommentBox() {
        const modalHtml = `
    <div class="modal fade" id="commentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">评论路线</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="commentContent" rows="3" placeholder="请输入您的评论..."></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="submitComment()">提交</button>
                </div>
            </div>
        </div>
    </div>`;

        $('body').append(modalHtml);
        $('#commentModal').modal('show');

        $('#commentModal').on('hidden.bs.modal', function() {
            $(this).remove();
        });
    }
    // 提交评论的函数
    function submitComment() {
        const content = $('#commentContent').val().trim();

        if (!content) {
            alert('评论内容不能为空');
            return;
        }

        // 使用从URL获取的routeId，而不是从隐藏字段获取
        $.ajax({
            url: '${pageContext.request.contextPath}/comment/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                routeId: routeId,  // 使用全局routeId变量
                content: content
            }),
            success: function(response) {
                if (response.code === 200) {
                    alert('评论发表成功');
                    $('#commentModal').modal('hide');
                    loadComments(routeId);
                } else {
                    alert(response.msg || '评论发表失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }
    // 收藏功能
    function toggleFavorite() {
        if (!routeData) {
            console.error('routeData 未初始化');
            alert('无法获取路线信息，请刷新页面');
            return;
        }

        const favoriteBtn = $('#favoriteBtn');
        const isActive = favoriteBtn.hasClass('active');

        // 立即更新UI
        favoriteBtn.toggleClass('active');

        // 构造请求 URL
        const favoriteUrl = isActive ? `/route/unfavorite?routeId=${routeData.id}` : `/route/favorite?routeId=${routeData.id}`;

        // 发送请求到后端
        $.ajax({
            url: favoriteUrl,
            type: 'POST',
            success: function(response) {
                if (response.code === 200) {
                    alert(response.msg || (isActive ? '取消收藏成功' : '收藏成功'));
                } else {
                    // 回滚UI状态
                    favoriteBtn.toggleClass('active');
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                // 回滚UI状态
                favoriteBtn.toggleClass('active');
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    // 加载评论
    function loadComments(routeId) {
        $('#commentsBody').html(`
            <div class="text-center py-4">
                <div class="spinner-border text-primary"></div>
                <p class="mt-2">加载评论中...</p>
            </div>
        `);

        $.ajax({
            url: '${pageContext.request.contextPath}/comment/formattedList/' + routeId,
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

    // 加载用户中心数据
    function loadUserCenterData(event) {
        event.preventDefault(); // 阻止默认的链接跳转行为

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
                    alert('加载用户数据失败，请重试');
                }
            })
            .catch(error => {
                console.error('请求失败:', error);
                alert('网络错误，请检查连接');
            });
    }

    // 退出登录
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