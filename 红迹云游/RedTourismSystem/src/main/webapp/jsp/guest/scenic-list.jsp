<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 景点信息</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
            color: white !important;
            font-weight: bold;
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
        .scenic-card {
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
                    <a class="nav-link " href="index.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="scenic-list.jsp">景点信息</a>
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

<div class="container mt-4">
    <h3 class="section-title">所有景点</h3>

    <!-- 搜索框区域 -->
    <div class="card mb-3">
        <div class="card-body">
            <form class="row g-3 justify-content-center" style="max-width: 1000px; margin: 0 auto;">
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchProvince" placeholder="按省份搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchCity" placeholder="按城市搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchName" placeholder="按景点名称搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" id="searchBtn">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 景点列表容器 -->
    <div class="row" id="scenicListContainer">
        <!-- 景点卡片将通过 AJAX 动态加载 -->
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
    function viewScenicDetail(scenicId) {
        // 跳转到景点详情页，假设详情页为scenic-detail.jsp
        window.location.href = 'scenic-detail.jsp?id=' + scenicId;
    }
    const contextPath = "${pageContext.request.contextPath}";
    const pageSize = 8; // 每页显示8条记录
    let currentPage = 1;
    let totalPages = 1;
    let allScenicCards = [];
    let filteredScenicCards = [];

    // 初始化分页
    $(document).ready(function() {
        // 加载景点列表
        loadScenicList();

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
            filterScenic();
        });
    });

    // 加载景点列表
    function loadScenicList() {
        $.ajax({
            url:contextPath+ '/guest/scenic-list',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.code === 200) {
                    const scenicList = response.data;
                    const container = $('#scenicListContainer');
                    container.empty();

                    scenicList.forEach((scenic, index) => {
                        // 拼接时使用 contextPath（而非 pageContext）
                        let card = '<div class="col-md-3 mb-4 scenic-card"' +
                            ' data-index="' + index + '"' +
                            ' data-province="' + (scenic.province || '') + '"' +
                            ' data-city="' + (scenic.city || '') + '"' +
                            ' data-name="' + (scenic.name || '') + '">' +
                            '    <div class="card h-100">' +
                            '        <img src="' + contextPath+'/' + (scenic.coverImage || 'default.png') + '"' + // 修正此处
                            '             class="card-img-top"' +
                            '             alt="' + (scenic.name || '无名称') + '"' +
                            '             style="height: 180px; object-fit: cover; cursor: pointer"' +
                            '             onclick="viewScenicDetail(' + (scenic.id || 0) + ')">' +
                            '        <div class="card-body">' +
                            '            <h5 class="card-title">' + (scenic.name || '无名称') + '</h5>' +
                            '            <p class="card-text text-muted">' + (scenic.address || '无地址') + '</p>' +
                            '            <div class="d-flex justify-content-between">' +
                            '                <button class="btn btn-sm btn-favorite btn-action" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-heart"></i> 收藏' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-like btn-action" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-hand-thumbs-up"></i>点赞' +
                            '                    <span class="like-count">' + (scenic.likeCount || 0) + '</span>' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-primary btn-action" data-id="' + (scenic.id || 0) + '" onclick="alert(\'请先登录!\')">' +
                            '                    <i class="bi bi-chat"></i> 评论' +
                            '                </button>' +
                            '                <button class="btn btn-sm btn-primary btn-action" data-id="' + (scenic.id || 0) + '" onclick="showComments(this)">' +
                            '                    <i class="bi bi-chat-left-text"></i> 查看评论' +
                            '                </button>' +
                            '            </div>' +
                            '        </div>' +
                            '    </div>' +
                            '</div>';

                        container.append(card);
                    });

                    allScenicCards = $('.scenic-card');
                    filteredScenicCards = Array.from(allScenicCards);
                    updatePagination();
                    showPage(currentPage);
                } else {
                    alert(response.msg || '加载景点列表失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
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
        $('.scenic-card').hide();

        // 计算开始和结束索引
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, filteredScenicCards.length);

        // 显示当前页的卡片
        for (let i = startIndex; i < endIndex; i++) {
            $(filteredScenicCards[i]).show();
        }

        // 更新分页信息
        $('#currentPage').text(page);

        // 更新分页按钮状态
        updatePaginationButtons();
    }

    // 更新分页信息
    function updatePagination() {
        totalPages = Math.ceil(filteredScenicCards.length / pageSize) || 1;
        $('#totalPages').text(totalPages);
        updatePaginationButtons();
    }

    // 更新分页按钮状态
    function updatePaginationButtons() {
        $('#prevPage').toggleClass('disabled', currentPage === 1);
        $('#nextPage').toggleClass('disabled', currentPage === totalPages);
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
    // 点赞功能
    // function toggleLike(scenicId, element) {}
    //收藏
    // function toggleFavorite(scenicId, element) {}

    // 显示评论输入框
    // function showCommentBox(buttonElement) {}

    // 提交评论
    // function submitComment(scenicId) {}

    // 显示评论
    function showComments(button) {
        const scenicId = $(button).data('id');
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
            url: contextPath+'/guest/scenic/formattedList/' + scenicId,
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

    // 搜索功能（前端筛选）
    function filterScenic() {
        const provinceKeyword = $('#searchProvince').val().trim().toLowerCase();
        const cityKeyword = $('#searchCity').val().trim().toLowerCase();
        const nameKeyword = $('#searchName').val().trim().toLowerCase();

        filteredScenicCards = Array.from(allScenicCards).filter(card => {
            // 安全获取数据并转换为字符串，确保可以调用toLowerCase()
            const province = String($(card).data('province') || '').toLowerCase();
            const city = String($(card).data('city') || '').toLowerCase();
            const name = String($(card).data('name') || '').toLowerCase();

            const matchProvince = province.includes(provinceKeyword);
            const matchCity = city.includes(cityKeyword);
            const matchName = name.includes(nameKeyword);

            return (provinceKeyword === "" || matchProvince) &&
                (cityKeyword === "" || matchCity) &&
                (nameKeyword === "" || matchName);
        });

        // 重置到第一页
        currentPage = 1;
        updatePagination();
        showPage(currentPage);
    }

    // 显示筛选后的页面
    function showFilteredPage(page) {
        // 计算开始和结束索引（只考虑未过滤的项目）
        const visibleCards = $('.scenic-card:not(.filtered)');
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, visibleCards.length) - 1;

        // 隐藏所有卡片
        $('.scenic-card').addClass('hidden');

        // 显示当前页的卡片（未过滤的）
        for (let i = startIndex; i <= endIndex; i++) {
            const index = $(visibleCards[i]).data('index');
            $(`.scenic-card[data-index="${index}"]`).removeClass('hidden');
        }

        // 更新分页信息
        $('#currentPage').text(page);

        // 更新分页按钮状态
        $('#prevPage').toggleClass('disabled', page === 1);
        $('#nextPage').toggleClass('disabled', page === totalPages);
    }

</script>
</body>
</html>
