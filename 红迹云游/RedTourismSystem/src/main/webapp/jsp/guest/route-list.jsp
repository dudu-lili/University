<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 旅游路线</title>
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
        .search-box {
            margin: 20px 0;
        }
        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .page-info {
            text-align: center;
            margin-top: 10px;
            color: #6c757d;
        }
        .route-card {
            display: none; /* 初始隐藏所有卡片 */
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
            /*margin-top: 20px;*/
            margin-top: auto;
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
                <li class="nav-item">
                    <a class="nav-link" href="scenic-list.jsp">景点信息</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="route-list.jsp">旅游路线</a>
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

<div class="container mt-4">
    <h3 class="section-title">所有推荐 </h3>

    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="searchDescription" placeholder="按路线简介搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" id="searchBtn">搜索</button>
                </div>
            </form>
        </div>
    </div>


    <div class="row" id="routeListContainer">
        <!-- 路线卡片将通过 AJAX 动态生成 -->
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
<!-- 评论模态框 -->
<div class="modal fade" id="commentsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">评论列表</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="commentsBody">
                <!-- 评论内容将在这里动态加载 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
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
    // 查看路线详情
    function viewRouteDetail(routeId) {
        // 跳转到路线详情页
        window.location.href = 'route-detail.jsp?id=' + routeId;
    }
    // 分页配置
    const pageSize = 8; // 每页显示8条记录
    let currentPage = 1;
    let totalPages = 1;
    let allRouteCards = [];
    let filteredRouteCards = [];
    const contextPath = "${pageContext.request.contextPath}";

    // 初始化分页
    $(document).ready(function() {
        // 加载景点列表
        loadRouteList();

        // 绑定分页按钮事件
        $('#prevPage').click(function(e) {
            e.preventDefault();
            prevPage();
        });

        $('#nextPage').click(function(e) {
            e.preventDefault();
            nextPage();
        });

        // 绑定搜索按钮事件
        $('#searchBtn').click(function(e) {
            e.preventDefault();
            filterRoutes();
        });
    });

    function loadRouteList() {
        $.ajax({
            url: contextPath+'/guest/route-list',
            type: 'GET',
            success: function (response) {
                if (response.code === 200) {
                    const routes = response.data;
                    const routeListContainer = $('#routeListContainer');

                    routes.forEach((route, index) => {
                        // 传统字符串拼接（单引号 + 加号）
                        var card = '<div class="col-md-3 mb-4 route-card"' +
                            ' data-index="' + index + '"' +
                            ' data-desc="' + route.description + '">' +
                            '    <div class="card h-100">' +
                            '        <img src="' +contextPath + '/' + route.coverImage + '"' +
                            '             class="card-img-top"' +
                            '             alt="' + route.name + '"' +
                            '             style="height: 180px; object-fit: cover; cursor: pointer"' +
                            '             onclick="viewRouteDetail(' + route.id + ')">' +
                            '        <div class="card-body">' +
                            '            <h5 class="card-title">' + route.name + '</h5>' +
                            // '            <p class="card-text text-muted">' + route.description + '</p>' +
                            '            <div class="d-flex justify-content-between">' +
                            '                <button class="btn btn-sm btn-favorite btn-action" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-heart"></i> 收藏' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-like btn-action" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-hand-thumbs-up"></i>点赞' +
                            '                    <span class="like-count">' + route.likeCount + '</span>' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-primary btn-action" data-id="' + route.id + '" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-chat"></i> 评论' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-primary btn-action" data-id="' + route.id + '" onclick="showComments(this)">' +
                            '                    <i class="bi bi-chat-left-text"></i> 查看评论' +
                            '                </button>' +
                            '            </div>' +
                            '        </div>' +
                            '    </div>' +
                            '</div>';

                        routeListContainer.append(card);
                    });

                    allRouteCards = $('.route-card');
                    filteredRouteCards = Array.from(allRouteCards);
                    updatePagination();
                    showPage(currentPage);

                    // 分页和搜索绑定事件保持不变
                }
            }
        });
    }


    // 显示上一页
    function prevPage() {
        if (currentPage > 1) {
            currentPage--;
            showPage(currentPage);
        }
    }

    // 显示下一页
    function nextPage() {
        if (currentPage < totalPages) {
            currentPage++;
            showPage(currentPage);
        }
    }

    // 显示指定页的数据
    function showPage(page) {
        // 隐藏所有卡片
        $('.route-card').hide();

        // 计算开始和结束索引
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, filteredRouteCards.length);

        // 显示当前页的卡片
        for (let i = startIndex; i < endIndex; i++) {
            $(filteredRouteCards[i]).show();
        }

        // 更新分页信息
        $('#currentPage').text(page);

        // 更新分页按钮状态
        updatePaginationButtons();
    }

    // 更新分页信息
    function updatePagination() {
        totalPages = Math.ceil(filteredRouteCards.length / pageSize) || 1;
        $('#totalPages').text(totalPages);
        updatePaginationButtons();
    }

    // 更新分页按钮状态
    function updatePaginationButtons() {
        $('#prevPage').toggleClass('disabled', currentPage === 1);
        $('#nextPage').toggleClass('disabled', currentPage === totalPages);
    }


    // 搜索功能（前端筛选）
    function filterRoutes() {
        const keyword = $('#searchDescription').val().trim().toLowerCase();

        filteredRouteCards = Array.from(allRouteCards).filter(card => {
            // 安全获取描述并转换为字符串
            const desc = String($(card).data('desc') || '').toLowerCase();
            return desc.includes(keyword);
        });

        // 重置到第一页
        currentPage = 1;
        updatePagination();
        showPage(currentPage);
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
    // 点赞功

    // 收藏功能

    // 显示评论输入框
    function showCommentBox(buttonElement) {
        const routeId = $(buttonElement).data('id');

        // 使用传统字符串拼接方式
        var modalHtml = '<div class="modal fade" id="commentModal" tabindex="-1">' +
            '<div class="modal-dialog">' +
            '<div class="modal-content">' +
            '<div class="modal-header">' +
            '<h5 class="modal-title">评论路线 #' + routeId + '</h5>' +
            '<button type="button" class="btn-close" data-bs-dismiss="modal"></button>' +
            '</div>' +
            '<div class="modal-body">' +
            '<textarea class="form-control" id="commentContent" rows="3"></textarea>' +
            '<input type="hidden" id="commentRouteId" value="' + routeId + '">' +
            '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>' +
            '<button type="button" class="btn btn-primary" onclick="submitComment(' + routeId + ')">提交</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';

        $('body').append(modalHtml);
        $('#commentModal').modal('show');

        $('#commentModal').on('hidden.bs.modal', function() {
            $(this).remove();
        });
    }

    // 提交评论

    // 提交评论的函数

    // 显示评论
    function showComments(button) {
        const routeId = $(button).data('id');
        const modal = new bootstrap.Modal(document.getElementById('commentsModal'));

        // 显示加载状态
        $('#commentsBody').html(`
        <div class="text-center py-4">
            <div class="spinner-border text-primary"></div>
            <p class="mt-2">加载评论中...</p>
        </div>
    `);

        // 显示模态框
        modal.show();

        // 获取评论数据
        $.ajax({
            url: contextPath+'/guest/formattedList/' + routeId,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    // 直接使用后端返回的HTML
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