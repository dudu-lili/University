<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游系统 - 景点信息</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            padding-top: 56px;
        }
        .navbar {
            background-color: #dc3545;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: bold;
        }
        .nav-link:hover {
            color: #ffc107 !important;
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
            color: #dc3545;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #dc3545;
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
            color: #dc3545;
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
        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }
        .avatar-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }
        .carousel-inner {
            padding-top: 20px;
            position: relative;
            width: 100%;
            overflow: hidden;
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
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <!-- 将文字替换为Logo图片 -->
        <a class="navbar-brand" href="index.jsp">
            <img src="../../assets/images/banners/logo.jpg" alt="红色旅游" height="40">
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
                        <li><a class="dropdown-item" href="scenic-list1.jsp">a级景点</a></li>
                        <li><a class="dropdown-item" href="nearby-scenic-list.jsp">附近景点</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="route-list.jsp">旅游路线</a>
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
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#" onclick="loadUserCenterData(event)">个人中心</a>--%>
                <%--                </li>--%>
                <!-- 在导航栏添加用户头像 -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <img src="${pageContext.request.contextPath}/user/avatar/${user.id}?t=<%=System.currentTimeMillis()%>"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar.png'"
                             class="avatar-circle"
                             alt="用户头像">
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="user-center.jsp">个人中心</a></li>
                        <li><a class="dropdown-item" href="#" onclick="logout()">退出登录</a></li>
                    </ul>
                </li>
                <!-- 添加退出按钮 -->
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#" onclick="logout()">--%>
                <%--                        <i class="bi bi-box-arrow-right me-2"></i> 退出登录--%>
                <%--                    </a>--%>
                <%--                </li>--%>
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
        <c:forEach var="scenic" items="${scenicList}" varStatus="status">
            <div class="col-md-3 mb-4 scenic-card"
                 data-index="${status.index}"
                 data-province="${scenic.province}"
                 data-city="${scenic.city}"
                 data-name="${scenic.name}">
                <div class="card h-100">
                    <img src="${pageContext.request.contextPath}/${scenic.coverImage}"
                         class="card-img-top"
                         alt="${scenic.name}"
                         style="height: 180px; object-fit: cover; cursor: pointer;"
                         onclick="viewScenicDetail(${scenic.id})">
                    <div class="card-body">
                        <h5 class="card-title">${scenic.name}</h5>
                        <p class="card-text text-muted">${scenic.address}</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-sm btn-favorite btn-action" onclick="toggleFavorite(${scenic.id}, this)">
                                <i class="bi bi-heart"></i> 收藏
                            </button>
                            <button class="btn btn-sm btn-like btn-action" onclick="toggleLike(${scenic.id}, this)">
                                <i class="bi bi-hand-thumbs-up"></i>点赞
                                <span class="like-count">${scenic.likeCount}</span>
                            </button>
                            <button class="btn btn-sm btn-primary btn-action" data-id="${scenic.id}" onclick="showCommentBox(this)">
                                <i class="bi bi-chat"></i> 评论
                            </button>
                            <button class="btn btn-sm btn-primary btn-action" data-id="${scenic.id}" onclick="showComments(this)">
                                <i class="bi bi-chat-left-text"></i> 查看评论
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
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
<footer class="text-center">
    <div class="container">
        <p class="mb-0">© 2025 红色旅游系统 版权所有</p>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    function viewScenicDetail(scenicId) {
        // 跳转到景点详情页，假设详情页为scenic-detail.jsp
        window.location.href = 'scenic-detail.jsp?id=' + scenicId;
    }
    const pageSize = 8; // 每页显示8条记录
    let currentPage = 1;
    let totalPages = 1;
    let allScenicCards = [];
    let filteredScenicCards = [];

    // 初始化分页
    $(document).ready(function() {
        // 获取所有景点卡片
        allScenicCards = $('.scenic-card');

        // 初始显示第一页
        filteredScenicCards = Array.from(allScenicCards);
        updatePagination();
        showPage(currentPage);

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
    // 点赞功能
    function toggleLike(scenicId, element) {
        const likeCountElement = $(element).find('.like-count');
        const currentCount = parseInt(likeCountElement.text());
        const isActive = $(element).hasClass('active');

        // 立即更新UI（乐观更新）
        $(element).toggleClass('active');
        likeCountElement.text(isActive ? currentCount - 1 : currentCount + 1);

        // 发送请求到后端
        $.ajax({
            url: '${pageContext.request.contextPath}/scenic/like',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ scenicId: scenicId }),
            success: function(response) {
                if (response.code === 200) {
                    // 成功时更新点赞数
                    const data = response.data;
                    likeCountElement.text(data.likeCount);
                } else {
                    // 失败时处理
                    if (response.code === 401) {
                        // 未登录处理
                        window.location.href = '/login'; // 跳转到登录页
                    } else {
                        // 其他错误回滚UI状态
                        $(element).toggleClass('active');
                        likeCountElement.text(currentCount);
                        alert(response.msg || '操作失败');
                    }
                }
            },
            error: function(xhr) {
                // 回滚UI状态
                $(element).toggleClass('active');
                likeCountElement.text(currentCount);
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }
//收藏
    function toggleFavorite(scenicId, element) {
        $.ajax({
            url: '${pageContext.request.contextPath}/scenic/favorite',
            type: 'POST',
            contentType: 'application/json', // 明确指定内容类型
            data: JSON.stringify({

                scenicId: scenicId
            }),
            success: function(response) {
                if(response.code === 200) {
                    $(element).toggleClass('active');
                    alert("收藏成功");
                } else {
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    // 显示评论输入框
    function showCommentBox(buttonElement) {
        const scenicId = $(buttonElement).data('id');

        var modalHtml = '<div class="modal fade" id="commentModal" tabindex="-1">' +
            '<div class="modal-dialog">' +
            '<div class="modal-content">' +
            '<div class="modal-header">' +
            '<h5 class="modal-title">评论景点 #' + scenicId + '</h5>' +
            '<button type="button" class="btn-close" data-bs-dismiss="modal"></button>' +
            '</div>' +
            '<div class="modal-body">' +
            '<textarea class="form-control" id="commentContent" rows="3"></textarea>' +
            '<input type="hidden" id="commentScenicId" value="' + scenicId + '">' +
            '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>' +
            '<button type="button" class="btn btn-primary" onclick="submitComment(' + scenicId + ')">提交</button>' +
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
    function submitComment(scenicId) {
        const content = $('#commentContent').val().trim();

        if (!content) {
            alert('评论内容不能为空');
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/comment/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                scenicId: scenicId,
                content: content
            }),
            success: function(response) {
                if (response.code === 200) {
                    alert('评论发表成功');
                    $('#commentModal').modal('hide');
                    // 刷新评论列表
                    loadComments(scenicId);
                } else {
                    alert(response.msg || '评论发表失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

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
            url: '${pageContext.request.contextPath}/comment/scenic/formattedList/' + scenicId,
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

    <!-- 搜索框 -->
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