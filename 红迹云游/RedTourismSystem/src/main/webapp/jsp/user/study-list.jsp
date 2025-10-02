<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>红色旅游系统 - 红色研学</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
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
    <h3 class="section-title">所有内容</h3>
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
        </div>
    </div>


    <div class="row wsize" id="studyListContainer">
        <c:forEach var="study" items="${studyList}" varStatus="status">


            <div class="study-card" data-index="${status.index}">
                <div class="img-card">
                    <img src="${pageContext.request.contextPath}/${study.coverImage}"  onclick="viewStudyDetail(${study.id})">
                </div>
                <div class="tit-card">
                    <h5 class="card-title" onclick="viewStudyDetail(${study.id})">${study.title}</h5>
                    <p class="lead" onclick="viewStudyDetail(${study.id})">
                        <c:set var="content"  value="${study.content}" />
                        <c:choose>
                            <c:when test="${fn:contains(content, '。')}">
                                ${fn:substringBefore(content, '。')}。
                            </c:when>
                            <c:otherwise>
                                ${content}
                            </c:otherwise>
                        </c:choose>
                    </p>
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

    function viewStudyDetail(studyId) {
        // 发送请求到后端，增加浏览次数
        $.ajax({
            url: '${pageContext.request.contextPath}/study/view', // 修改为浏览的 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ studyId: studyId }),
            success: function(response) {
                if (response.code === 200) {
                    // 浏览次数增加成功，跳转到详情页
                    window.location.href = 'study-detail.jsp?id=' + studyId;
                } else {

                    // 浏览次数增加失败，提示用户
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                // 请求失败，提示用户
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    const pageSize = 5; // 每页显示5条记录
    let currentPage = 1;
    let totalPages = 1;
    let allStudyCards = [];
    let filteredStudyCards = [];



    // 初始化分页
    $(document).ready(function() {
        // 获取所有景点卡片
        allStudyCards = $('.study-card');

        // 初始显示第一页
        filteredStudyCards = Array.from(allStudyCards);
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
            filterStudy();
        });
        fetchStudyList()
    });
    function fetchStudyList() {
        $.ajax({
            url: '${pageContext.request.contextPath}/study/list', // 修改为获取列表的 URL
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    const studyListContainer = document.getElementById('studyListContainer');

                    // 按照 createTime 排序
                    const sortedStudies = response.data.sort((a, b) => {
                        console.log(a.time)
                        const timeA = new Date(a.time);
                        const timeB = new Date(b.time);
                        return timeB - timeA; // 降序排列（最新时间排在前面）
                    });
                    console.log(sortedStudies);

                    allStudyCards = sortedStudies.map(study => {
                        const card = createStudyCard(study);
                        studyListContainer.appendChild(card); // 将生成的卡片添加到页面中
                        return card;
                    });
                    filteredStudyCards = allStudyCards;
                    updatePagination();
                    showPage(currentPage);
                } else {
                    alert('获取数据失败: ' + response.msg);
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    // 创建景点卡片
    function createStudyCard(study) {
        const card = document.createElement('div');
        card.className = 'study-card';
        console.log("ss"+study);
        card.setAttribute('data-index', study.id);
        card.setAttribute('data-author', study.author);
        card.setAttribute('data-source', study.source);
        card.setAttribute('data-title', study.title);

        const imgCard = document.createElement('div');
        imgCard.className = 'img-card';

        const img = document.createElement('img');
        img.src = '${pageContext.request.contextPath}/' + study.coverImage;
        img.onclick = function() {
            viewStudyDetail(study.id);
        };
        imgCard.appendChild(img);

        const titCard = document.createElement('div');
        titCard.className = 'tit-card';

        const title = document.createElement('h5');
        title.className = 'card-title';
        title.textContent = study.title;
        title.onclick = function() {
            viewStudyDetail(study.id);
        };
        titCard.appendChild(title);

        const content = document.createElement('p');
        content.className = 'lead';
        content.textContent = study.content.split('。')[0] + '。';
        content.onclick = function() {
            viewStudyDetail(study.id);
        };
        titCard.appendChild(content);

        card.appendChild(imgCard);
        card.appendChild(titCard);

        return card;
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
        $('.study-card').hide();

        // 计算开始和结束索引
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, filteredStudyCards.length);

        // 显示当前页的卡片
        for (let i = startIndex; i < endIndex; i++) {
            $(filteredStudyCards[i]).show();
        }

        // 更新分页信息
        $('#currentPage').text(page);

        // 更新分页按钮状态
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
                console.log('Response status:', response.status); // 输出响应状态码
                console.log('Response headers:', response.headers); // 输出响应头信息

                if (response.ok) {
                    // 输出响应的JSON数据
                    return response.json().then(data => {
                        console.log('Response data:', data); // 输出响应的JSON数据
                        // 请求成功后跳转到个人中心页面
                        window.location.href = 'user-center.jsp';
                    });
                } else {
                    // 处理错误情况
                    hideLoading();
                    alert('加载用户数据失败，请重试');
                }
            })
            .catch(error => {
                hideLoading();
                console.error('请求失败:', error); // 输出错误信息
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
    function filterStudy() {
        const keyword = $('#searchGlobal').val().trim().toLowerCase();

        filteredStudyCards = Array.from(allStudyCards).filter(card => {
            // 安全获取数据并转换为字符串，确保可以调用toLowerCase()
            const author = String($(card).data('author') || '').toLowerCase();
            const source = String($(card).data('source') || '').toLowerCase();
            const title = String($(card).data('title') || '').toLowerCase();
            const content = String($(card).find('.lead').text() || '').toLowerCase();
            // 添加日志
            console.log('Author:', author);
            console.log('Source:', source);
            console.log('Title:', title);
            console.log('Content:', content);


            // 检查关键词是否在任意字段中
            return author.includes(keyword) || source.includes(keyword) || title.includes(keyword) || content.includes(keyword);
        });

        // 重置到第一页
        currentPage = 1;
        updatePagination();
        showPage(currentPage);
    }

    // 显示筛选后的页面
    function showFilteredPage(page) {
        // 计算开始和结束索引（只考虑未过滤的项目）
        const visibleCards = $('.study-card:not(.filtered)');
        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, visibleCards.length) - 1;

        // 隐藏所有卡片
        $('.study-card').addClass('hidden');

        // 显示当前页的卡片（未过滤的）
        for (let i = startIndex; i <= endIndex; i++) {
            const index = $(visibleCards[i]).data('index');
            $(`.study-card[data-index="${index}"]`).removeClass('hidden');
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