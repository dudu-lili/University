<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>红色旅游系统 - 游记论坛</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.1/dist/echarts.min.js"></script>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        /*body {*/
        /*    padding-top: 56px;*/
        /*}*/
        /*.navbar {*/
        /*    background-color: #dc3545;*/
        /*    box-shadow: 0 2px 4px rgba(0,0,0,0.1);*/
        /*}*/
        /*.navbar-brand, .nav-link {*/
        /*    color: white !important;*/
        /*    font-weight: bold;*/
        /*}*/
        /*.nav-link:hover {*/
        /*    color: #ffc107 !important;*/
        /*}*/
        .cont {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .section-title {
            color: #dc3545;
            width:60%;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        .r-section-title{
            color: white;
            width:100px;
            height:40px;
            line-height:40px;
            background:#dc3545;
            font-weight: bold;
            text-align:center;
            margin-right:0;
            border-radius: 5px;
            text-decoration: none; /* 去掉下划线 */
            display: inline-block; /* 使宽度和高度生效 */
        }

        .r-section-title:hover {
            background: #b72b1b;
            text-decoration: none; /* 鼠标悬停时去掉下划线 */
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

        /*footer {*/
        /*    background-color: #343a40;*/
        /*    color: white;*/
        /*    padding: 20px 0;*/
        /*    margin-top: 100px;*/
        /*}*/
        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .page-info {
            text-align: center;
            margin-top: 45%;
            color: #6c757d;
        }

        .travelNotes-card {
            min-width: 400px; /* 最小宽度 */
            min-height: 200px; /* 最小高度 */
            margin: 0 auto;
            display: flex; /* 使用Flexbox布局 */
            align-items: center; /* 垂直居中对齐 */
            justify-content: space-between; /* 两端对齐 */
            padding: 10px;
        }
        .travelNotes-card:hover{
            background: #f6f6f6;
        }

        .img-card {
            width: 290px;
            height: 180px;
            overflow: hidden; /* 防止图片溢出 */
        }

        .img-card img {
            width: 100%; /* 图片宽度占满容器 */
            height: 100%; /* 图片高度占满容器 */
        }

        .tit-card {
            width: 64%;
            height: 25px;
            color: #000000;
            font-weight: bolder;
            margin-top: -110px;
        }

        .con-card{
            width: 66%;
            height: 15px;
            margin-bottom:1px;
            padding:0 10px;
            font-size: 12px;
            font-weight:400;
            display: flex; /* 使用Flexbox布局 */
        }
        .cont1{
            margin:0 10px;
            white-space: nowrap; /* 防止换行 */
            color:grey;
        }
        .lead {
            height:80px;
            font-weight: 400; /* 字体粗细 */
            font-size: medium;
            line-height: 1.5; /* 行高 */
            color: #515151; /* 文字颜色 */
            margin-top: 0.5rem; /* 上边距 */
            margin-bottom: 1rem; /* 下边距 */
            text-indent: 2em; /* 段落开头缩进两个字符 */
        }
        .wsize {
            width: 900px;
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
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }
        .card-title {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px; /* 标题下方的间距 */
            padding-bottom: 5px; /* 添加下边距 */
            white-space: nowrap; /* 防止换行 */
            overflow: hidden; /* 超出部分隐藏 */
            text-overflow: ellipsis; /* 超出部分显示省略号 */
        }
        #sortDropdown {
            background-color: #dc3545;
            color: white;
            border-color: #dc3545;
            margin-left:1000px;
            margin-top:-37px;
        }
        #sortDropdown:hover {
            background-color: #b72b1b;
            color: white;
        }
        .dropdown-menu {
            background-color: #dc3545;
            color: white;
        }
        .dropdown-item {
            color: white;
        }
        .dropdown-item:hover {
            background-color: #b72b1b;
            color: white;
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

                <!-- 路线信息菜单 -->
                <%--                <li class="nav-item dropdown">--%>
                <%--                    <a class="nav-link dropdown-toggle" href="#" id="routeDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">--%>
                <%--                        路线信息--%>
                <%--                    </a>--%>
                <%--                    <ul class="dropdown-menu" aria-labelledby="routeDropdown">--%>
                <%--                        <li><a class="dropdown-item" href="route-list.jsp">旅游路线</a></li>--%>
                <%--                        <li><a class="dropdown-item" href="route-list-recommend.jsp">路线推荐</a></li>--%>
                <%--                    </ul>--%>
                <%--                </li>--%>
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
                    <a class="nav-link active" href="travelnotes-list.jsp">游记论坛</a>
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
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar1.png'"
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


<div class="container mt-4 flex-grow-1">
    <div class="cont">
        <h3 class="section-title">所有内容</h3>
        <a class="r-section-title bi bi-pencil-square" href="writing.jsp"> 写游记</a>
    </div>


    <!-- 搜索框区域 -->
    <div class="card mb-3">
        <div class="card-body">
            <form class="row g-3 justify-content-center" style="max-width: 1000px; margin: 0 auto;">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="searchGlobal" placeholder="全局搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" id="searchBtn">搜索</button>
                </div>
            </form>
            <!-- 排序选项框 -->
            <div class="col-md-2">
                <div class="dropdown">
                    <button class="btn btn-danger dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        排序选项
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                        <li><a class="dropdown-item sort-option" href="#" data-sort="viewCount">按浏览数排序</a></li>
                        <li><a class="dropdown-item sort-option" href="#" data-sort="createTime">按发布时间排序</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <div class="row wsize" id="travelNotesListContainer">
        <c:forEach var="travelNotes" items="${travelNotesList}" varStatus="status">
            <div class="travelNotes-card" data-index="${travelNotes.id}">
                <div class="img-card">
                    <img src="${pageContext.request.contextPath}/${travelNotes.banImage}" onclick="viewTravelNotesDetail(${travelNotes.id})">
                </div>
                <div class="tit-card">
                    <h5 class="card-title" onclick="viewTravelNotesDetail(${travelNotes.id})">${travelNotes.title}</h5>
                    <div class="lead" onclick="viewTravelNotesDetail(${travelNotes.id})">
                        <c:set var="content" value="${travelNotes.content}" />
                        <div class="content-text" style="display: none;">${content}</div>
                        <div class="content-display"></div>
                    </div>
                    <div class="con-card">
                        <div class="cont1 bi bi-geo-alt-fill"> ${travelNotes.place}、</div>
                        <div class="cont1">by ${travelNotes.author}</div>
                        <div class="cont1 bi bi-eye-fill"> ${travelNotes.viewCount}</div>
                        <%--<div class="cont1" style="display: none"> ${travelNotes.create}</div>--%>
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
    // 全局变量
    const pageSize = 5; // 每页显示5条记录
    let currentPage = 1;
    let totalPages = 1;
    let allTravelNotesCards = [];
    let filteredTravelNotesCards = [];
    let currentSortField = 'createTime'; // 当前排序字段
    let currentSortOrder = 'desc'; // 当前排序顺序

    // 初始化页面
    // 初始化页面
    $(document).ready(function() {
        // 初始化排序按钮
        $('.sort-option').each(function() {
            $(this).data('original-text', $(this).text());
        });

        // 绑定排序选项的点击事件
        $('.sort-option').click(function(e) {
            e.preventDefault();
            const sortField = $(this).data('sort');

            // 如果点击的是当前排序字段，切换排序顺序；否则使用默认降序
            if (currentSortField === sortField) {
                currentSortOrder = currentSortOrder === 'desc' ? 'asc' : 'desc';
            } else {
                currentSortOrder = 'desc';
            }

            currentSortField = sortField;

            // 更新按钮显示
            $('.sort-option').each(function() {
                $(this).text($(this).data('original-text'));
            });
            $(this).text($(this).data('original-text') + (currentSortOrder === 'desc' ? ' ↓' : ' ↑'));

            // 重新加载数据
            fetchTravelNotesList(currentSortField, currentSortOrder, 0); // 从第一页开始
        });

        // 初始加载
        fetchTravelNotesList(currentSortField, currentSortOrder, 0);

        // 绑定分页按钮事件
        $('#prevPage').click(function(e) {
            e.preventDefault();
            prevPage();
        });

        $('#nextPage').click(function(e) {
            e.preventDefault();
            nextPage();
        });

        $('#searchBtn').click(function(e) {
            e.preventDefault();
            filterTravelNotes();
        });
    });




    // 获取游记列表
    function fetchTravelNotesList(sortField = 'createTime', sortOrder = 'desc', page = 0) {
        $.ajax({
            url: '${pageContext.request.contextPath}/travelNotes/list',
            type: 'GET',
            data: {
                page: page,
                size: pageSize
            },
            success: function(response) {
                if (response.code === 200 && response.data) {
                    // 清空当前列表
                    $('#travelNotesListContainer').empty();

                    // 确保数据是数组
                    const travelNotesList = Array.isArray(response.data) ? response.data : [];

                    // 对数据进行排序
                    travelNotesList.sort((a, b) => {
                        if (sortField === 'viewCount') {
                        return sortOrder === 'desc' ? b.viewCount - a.viewCount : a.viewCount - b.viewCount;
                    } else if (sortField === 'createTime') {
                        return sortOrder === 'desc' ? new Date(b.createtime) - new Date(a.createtime) : new Date(a.createtime) - new Date(b.createtime);
                    }
                    return 0; // 默认不排序
                });

                    // 重新创建卡片
                    travelNotesList.forEach(travelNotes => {
                        const card = createTravelNotesCard(travelNotes);
                    $('#travelNotesListContainer').append(card);
                });

                    // 更新全局变量
                    allTravelNotesCards = $('.travelNotes-card');
                    filteredTravelNotesCards = Array.from(allTravelNotesCards);

                    // 初始化分页
                    // 由于响应中没有分页信息，我们使用前端计算
                    currentPage = page + 1;
                    totalPages = Math.ceil(travelNotesList.length / pageSize) || 1;
                    updatePagination(totalPages, currentPage - 1); // 页码从0开始
                    showPage(currentPage);
                } else {
                    console.error('Invalid response structure:', response);
                    alert('获取数据失败: ' + (response.msg || '未知错误'));
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    // 创建游记卡片
    function createTravelNotesCard(travelNotes) {
        if (!travelNotes || !travelNotes.id) {
            console.error('Invalid travel notes data:', travelNotes);
            return document.createTextNode(''); // 返回空节点
        }

        const card = document.createElement('div');
        card.className = 'travelNotes-card';
        card.setAttribute('data-index', travelNotes.id);
        card.setAttribute('data-author', (travelNotes.author || '').toLowerCase());
        card.setAttribute('data-place', (travelNotes.place || '').toLowerCase());
        card.setAttribute('data-title', (travelNotes.title || '').toLowerCase());

        const imgCard = document.createElement('div');
        imgCard.className = 'img-card';
        const img = document.createElement('img');
        img.src = `${pageContext.request.contextPath}/`+travelNotes.banImage || ''+``;
        img.onclick = function() {
            viewTravelNotesDetail(travelNotes.id);
        };
        imgCard.appendChild(img);

        const titCard = document.createElement('div');
        titCard.className = 'tit-card';
        const title = document.createElement('h5');
        title.className = 'card-title';
        title.textContent = travelNotes.title || '';
        title.onclick = function() {
            viewTravelNotesDetail(travelNotes.id);
        };
        titCard.appendChild(title);

        // 处理游记内容
        let contentText = travelNotes.content || '';
        contentText = contentText.replace(/&nbsp;/g, ' ');
        contentText = contentText.replace(/<[^>]*>/g, '');
        const contentDisplay = contentText.length > 100 ? contentText.substring(0, 100) + '...' : contentText;

        const content = document.createElement('p');
        content.className = 'lead';
        content.textContent = contentDisplay;
        content.onclick = function() {
            viewTravelNotesDetail(travelNotes.id);
        };
        titCard.appendChild(content);

        const conCard = document.createElement('div');
        conCard.className = 'con-card';
        const placeDiv = document.createElement('div');
        placeDiv.className = 'cont1 bi bi-geo-alt-fill';
        placeDiv.textContent = ``+travelNotes.place || ''+`、`;
        const authorDiv = document.createElement('div');
        authorDiv.className = 'cont1';
        authorDiv.textContent = `by `+travelNotes.author || ''+``;
        const viewCountDiv = document.createElement('div');
        viewCountDiv.className = 'cont1 bi bi-eye-fill';
        viewCountDiv.textContent = travelNotes.viewCount || '0';

        const createTimeDiv = document.createElement('div');
        createTimeDiv.className = 'cont1','style="display:none"';
        createTimeDiv.textContent = travelNotes.createtime;

        conCard.appendChild(placeDiv);
        conCard.appendChild(authorDiv);
        conCard.appendChild(viewCountDiv);
        conCard.appendChild(createTimeDiv);

        titCard.appendChild(conCard);

        card.appendChild(imgCard);
        card.appendChild(titCard);

        return card;
    }

    // 显示上一页
    function prevPage() {
        if (currentPage > 1) {
            fetchTravelNotesList(currentSortField, currentSortOrder, currentPage - 2);
        }
    }

    // 显示下一页
    function nextPage() {
        if (currentPage < totalPages) {
            fetchTravelNotesList(currentSortField, currentSortOrder, currentPage);
        }
    }

    // 显示指定页的数据
    function showPage(page) {
        // 计算开始和结束索引
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, filteredTravelNotesCards.length);

        // 隐藏所有卡片
        $('.travelNotes-card').hide();

        // 显示当前页的卡片
        for (let i = startIndex; i < endIndex; i++) {
            $(filteredTravelNotesCards[i]).show();
        }


        // 更新分页信息
        $('#currentPage').text(page);
        updatePaginationButtons();
    }

    // 更新分页信息
    function updatePagination(totalPages, currentPage) {
        $('#totalPages').text(totalPages);
        $('#currentPage').text(currentPage + 1); // 显示页码从1开始
        updatePaginationButtons();
    }

    // 更新分页按钮状态
    function updatePaginationButtons() {
        $('#prevPage').toggleClass('disabled', currentPage === 1);
        $('#nextPage').toggleClass('disabled', currentPage === totalPages);
    }

    // 搜索功能
    function filterTravelNotes() {
        const keyword = $('#searchGlobal').val().trim().toLowerCase();

        filteredTravelNotesCards = Array.from(allTravelNotesCards).filter(card => {
            const author = String($(card).data('author') || '').toLowerCase();
        const place = String($(card).data('place') || '').toLowerCase();
        const title = String($(card).data('title') || '').toLowerCase();
        const content = String($(card).find('.lead').text() || '').toLowerCase();

        // 检查关键词是否在任意字段中
        return author.includes(keyword) || author.includes(keyword) || place.includes(keyword) || title.includes(keyword) || content.includes(keyword);
    });


        // 重置到第一页
        currentPage = 1;
        updatePagination(Math.ceil(filteredTravelNotesCards.length / pageSize), 0);
        showPage(currentPage);
    }


    // 查看游记详情
    function viewTravelNotesDetail(travelNotesId) {
        if (!travelNotesId) {
            console.error('Invalid travelNotesId:', travelNotesId);
            return;
        }

        // 发送请求到后端，增加浏览次数
        $.ajax({
            url: '${pageContext.request.contextPath}/travelNotes/view',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ travelNotesId: travelNotesId }),
            success: function(response) {
                if (response.code === 200) {
                    const updatedTravelNotesId = response.data.travelNotesId;
                    const updatedViewCount = response.data.viewCount;

                    if (updatedTravelNotesId) {
                        updateViewCountOnList(updatedTravelNotesId, updatedViewCount);
                    }

                    // 跳转到详情页
                    window.location.href = 'travelnotes-detail.jsp?id=' + travelNotesId;
                } else {
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    function updateViewCountOnList(travelNotesId, newViewCount) {
        if (!travelNotesId) {
            console.error('Invalid travelNotesId:', travelNotesId);
            return;
        }

        // 使用原生 JavaScript 查找卡片
        const card = document.querySelector(`.travelNotes-card[data-index="${travelNotesId}"]`);
        if (card) {
            // 找到卡片，更新浏览次数
            const viewCountElement = card.querySelector('.cont1.bi-eye-fill');
            if (viewCountElement) {
                // 更新浏览数显示
                const currentText = viewCountElement.textContent;
                const currentCount = parseInt(currentText.match(/\d+/)?.[0] || '0');
                viewCountElement.textContent = currentText.replace(/\d+/, newViewCount);
            } else {
                console.error('View count element not found for travelNotesId:', travelNotesId);
            }
        } else {
            console.error('Travel notes card not found for ID:', travelNotesId);
        }
    }
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

    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin'
        })
            .then(response => {
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