<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>红色旅游系统 - 研学</title>
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
        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .page-info {
            text-align: center;
            margin-top: 1000px;
            color: #6c757d;
        }

        .study-card {
            min-width: 400px; /* 最小宽度 */
            min-height: 200px; /* 最小高度 */
            margin: 10px auto;
            border: 1px solid #cccccc;
            box-shadow: 0 8px 23px 1px rgba(0, 0, 0, 0.26);
            display: flex; /* 使用Flexbox布局 */
            align-items: center; /* 垂直居中对齐 */
            justify-content: space-between; /* 两端对齐 */
            padding: 10px;
        }

        .img-card {
            width: 290px;
            height: 180px;
            overflow: hidden; /* 防止图片溢出 */
            cursor: pointer; /* 设置鼠标样式为手指 */

        }

        .img-card img {
            width: 100%; /* 图片宽度占满容器 */
            height: 100%; /* 图片高度占满容器 */
        }

        .tit-card {
            width: 66%;
            height: 30px;
            color: #000000;
            font-weight: bolder;
            border-bottom: 3px solid #d81142;
            margin-top: -90px;
            cursor: pointer; /* 设置鼠标样式为手指 */
        }
        .lead {
            font-weight: 400; /* 字体粗细 */
            font-size: medium;
            line-height: 1.5; /* 行高 */
            color: #000000; /* 文字颜色 */
            margin-top: 0.5rem; /* 上边距 */
            margin-bottom: 1rem; /* 下边距 */
            text-indent: 2em; /* 段落开头缩进两个字符 */

        }
        .wsize {
            width: 1000px;
            height: 200px;
            margin: 0 auto;
        }
        .avatar-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .card-title {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px; /* 标题下方的间距 */
            border-bottom: 3px solid #d81142; /* 添加红色下框线 */
            padding-bottom: 5px; /* 添加下边距 */
            white-space: nowrap; /* 防止换行 */
            overflow: hidden; /* 超出部分隐藏 */
            text-overflow: ellipsis; /* 超出部分显示省略号 */
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
            /*margin-top: 100px;*/
            /*position: relative;*/
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
    </style>
</head>
<body>
<!-- 导航栏-->
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
                    <a class="nav-link " href="index.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="scenic-list.jsp">景点信息</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="route-list.jsp">旅游路线</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="red-Geocoding.jsp">地图展示</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="study-list.jsp">红色研学</a>
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
    <h3 class="section-title">所有内容</h3>

    <!-- 搜索框区域 -->
    <div class="card mb-3">
        <div class="card-body">
            <form class="row g-3 justify-content-center" style="max-width: 1000px; margin: 0 auto;">
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchSource" placeholder="按来源搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchAuthor" placeholder="按作者搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchTitle" placeholder="按标题搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" id="searchBtn">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <div class="row wsize" id="studyListContainer"></div>

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
    // 查看新闻详情
    function viewStudyDetail(studyId) {
        // 跳转到新闻详情页
        window.location.href = 'study-detail.jsp?id=' + studyId;
    }
    <%--function viewStudyDetail(studyId) {--%>
        <%--// 发送请求到后端，增加浏览次数--%>
        <%--$.ajax({--%>
            <%--url: '${pageContext.request.contextPath}/study/view', // 修改为浏览的 URL--%>
            <%--type: 'POST',--%>
            <%--contentType: 'application/json',--%>
            <%--data: JSON.stringify({ studyId: studyId }),--%>
            <%--success: function(response) {--%>
                <%--if (response.code === 200) {--%>
                    <%--// 浏览次数增加成功，跳转到详情页--%>
                    <%--window.location.href = 'study-detail.jsp?id=' + studyId;--%>
                <%--} else {--%>

                    <%--// 浏览次数增加失败，提示用户--%>
                    <%--alert(response.msg || '操作失败');--%>
                <%--}--%>
            <%--},--%>
            <%--error: function(xhr) {--%>
                <%--// 请求失败，提示用户--%>
                <%--alert('请求失败: ' + xhr.statusText);--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

    const pageSize = 5; // 每页显示5条记录
    let currentPage = 1;
    let totalPages = 1;
    let allStudyCards = [];
    let filteredStudyCards = [];
    const contextPath = "${pageContext.request.contextPath}"; // 新增上下文路径

    // 初始化分页
    $(document).ready(function() {
        // 初始化加载研学列表
        loadStudyList();

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
            filterStudy();
        });
    });

    // 加载研学列表
    function loadStudyList() {
        $.ajax({
            url: contextPath + '/guest/study-list',
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    const studies = response.data;
                    const studyListContainer = $('#studyListContainer');
                    studyListContainer.empty(); // 清空容器

                    studies.forEach((study, index) => {
                        const content = study.content;
                    const dotIndex = content.indexOf('。');
                    const briefContent = dotIndex !== -1 ? content.substring(0, dotIndex + 1) : content;

                    // 完全按照 loadRouteList 的风格改写
                    var cardHtml = '<div class="study-card"' +
                        ' data-index="' + index + '"' +
                        ' data-author="' + study.author + '"' +
                        ' data-source="' + study.source + '"' +
                        ' data-title="' + study.title + '">' +
                        '    <div class="img-card">' +
                        '        <img src="' + contextPath + '/' + study.coverImage + '"' +
                        '             onclick="viewStudyDetail(' + study.id + ')"' +
                        '             style="width: 100%; height: 100%; object-fit: cover; cursor: pointer">' +
                        '    </div>' +
                        '    <div class="tit-card">' +
                        '        <h5 class="card-title" onclick="viewStudyDetail(' + study.id + ')">' +
                        '            ' + study.title +
                        '        </h5>' +
                        '        <p class="lead" onclick="viewStudyDetail(' + study.id + ')">' +
                        '            ' + briefContent +
                        '        </p>' +
                        '    </div>' +
                        '</div>';

                    studyListContainer.append(cardHtml);
                });

                    allStudyCards = $('.study-card');
                    filteredStudyCards = Array.from(allStudyCards);
                    updatePagination();
                    showPage(currentPage);
                } else {
                    alert('加载失败：' + response.msg);
                }
            },
            error: function(xhr) {
                alert('请求失败：' + xhr.statusText);
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

    // 显示指定页数据（与路线JSP完全一致的分页逻辑）
    function showPage(page) {
        $('.study-card').hide();
        const startIndex = (page - 1) * pageSize;
        const endIndex = startIndex + pageSize;
        filteredStudyCards.slice(startIndex, endIndex).forEach(card => $(card).show());

        $('#currentPage').text(page);
        updatePaginationButtons();
    }

    // 更新分页信息
    function updatePagination() {
        totalPages = Math.ceil(filteredStudyCards.length / pageSize) || 1;
        $('#totalPages').text(totalPages);
        updatePaginationButtons();
    }

    // 更新分页按钮状态
    function updatePaginationButtons() {
        $('#prevPage').toggleClass('disabled', currentPage === 1);
        $('#nextPage').toggleClass('disabled', currentPage === totalPages);
    }

    // 搜索功能（与路线JSP一致的前端筛选逻辑）
    function filterStudy() {
        const authorKeyword = $('#searchAuthor').val().trim().toLowerCase();
        const sourceKeyword = $('#searchSource').val().trim().toLowerCase();
        const titleKeyword = $('#searchTitle').val().trim().toLowerCase();

        filteredStudyCards = Array.from(allStudyCards).filter(card => {
            const author = ($(card).data('author') || '').toLowerCase();
        const source = ($(card).data('source') || '').toLowerCase();
        const title = ($(card).data('title') || '').toLowerCase();

        return (author.includes(authorKeyword) || authorKeyword === '') &&
            (source.includes(sourceKeyword) || sourceKeyword === '') &&
            (title.includes(titleKeyword) || titleKeyword === '');
    });

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

</script>
</body>
</html>