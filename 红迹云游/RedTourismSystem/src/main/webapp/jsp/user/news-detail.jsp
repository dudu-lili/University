<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<html>
<head>
    <title>新闻详情 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
            /*background-color: #f8f9fa;*/
        }

        .news-title {
            color: #080808;
            /*border-bottom: 1px solid #080808;*/
            text-align: center;
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

        .back-btn {
            margin-top: 1rem;
        }
        .news-separator {
            border-bottom: 1px solid #000; /* 添加黑色横线 */
            margin-bottom: 1rem;
            width: 100%; /* 调整横线宽度 */
            margin-left: auto;
            margin-right: auto; /* 横线居中 */
        }
        .news-meta {
            display: flex;
            justify-content: center; /* 内容居中 */
            align-items: center;
            margin-bottom: 2rem;
        }
        .news-meta p {
            margin: 0 10px; /* 元素之间的间距 */
        }
        .news-article {
            background-color: #fff;
            width: 100%;
            margin: 0 auto;
            border-radius: 8px;
            padding: 2.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            font-size: 1.1rem; /* 加大字体 */
            line-height: 1.8; /* 增加行高 */
            white-space: pre-wrap; /* 保留空格和换行 */
            word-wrap: break-word; /* 自动换行 */
            /*新加----*/
            text-align: justify;
            overflow: hidden;
        }
        /* 核心段落样式 */
        .news-article p {
            text-indent: 2em;
            margin: 0 0 1.2em 0;
            line-height: 1.8;
            display: block;
        }
        .locat{
            width: 80%;
            margin: 0 auto;
        }
        .nav-link {
            color: white !important;
            font-weight: bold;
            padding: 0 15px; /* 左右内边距 */
            height: 50px; /* 关键：与导航栏等高 */
            display: flex;
            align-items: center; /* 垂直居中 */
            transition: color 0.3s;
        }
        .text-end.back-btn{
            margin-top: 25px;
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
                    <a class="nav-link active" href="news-list.jsp">新闻公告</a>
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
                <button class="btn btn-warning" onclick="window.history.back()">
                    <i class="bi bi-arrow-left"></i> 返回新闻列表
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 locat">
            <h1 class="news-title" id="newsTitle">新闻标题</h1>
            <div class="news-separator"></div>
            <div class="news-meta">
                <p><span class="info-label">发布时间:</span> <span id="publishTime"></span></p>
                <p><span class="info-label">来源:</span><span id="newsSource"></span></p>
                <p><span class="info-label">作者:</span> <span id="newsAuthor"></span></p>
                <p><span class="info-label">浏览量:</span> <span id="viewCount">1</span></p>
            </div>
            <div class="news-article" id="newsArticle"></div>
        </div>
    </div>
</div>

<!-- 页脚 -->
<footer class="text-center" style="position: fixed; bottom: 0;width: 100%;background-color: #8b1515; color: white; padding: 20px 0 10px;">
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
<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
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
    // 从URL获取新闻ID
    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('id');
    let newsData = null;


    // 自动将换行内容转换为段落//修改1
    function convertLineBreaksToParagraphs(container) {
        const $container = $(container);
        // 将连续换行符替换为</p><p>，并包裹首尾段落标签
        const content = $container.html()
            .replace(/<br\s*\/?>/gi, '\n') // 先将<br>转换为换行符
            .replace(/\n{2,}/g, '</p><p>') // 多个换行符视为段落分隔
            .replace(/^\s*/, '<p>') // 开头添加<p>
            .replace(/\s*$/, '</p>'); // 结尾添加</p>
        $container.html(content);
    }

    $(document).ready(function() {
        if (!newsId) {
            alert('无效的新闻ID');
            return window.location.href = 'news-list.jsp';
        }

        // 并行加载详情和增加浏览次数
        Promise.all([
            loadNewsDetail(newsId),
            increaseViewCount(newsId)
        ]).then(([newsData]) => {
            renderNewsDetail(newsData);
        loadNewsImage(newsId);// 关键：渲染后转换段落
        convertLineBreaksToParagraphs('#newsArticle');//修改2
    }).catch(error => {
            console.error('初始化失败:', error);
        alert(error.message || '加载新闻失败');
        window.location.href = 'news-list.jsp';
    });
    });

    function increaseViewCount(id) {
        return new Promise((resolve, reject) => {
            // 检查是否已记录浏览
            const viewedNews = JSON.parse(sessionStorage.getItem('viewedNews') || '{}');
        const lastViewedTime = viewedNews[id];
        const now = Date.now();
        const halfHour = 30 * 60 * 1000; // 30分钟

        // 如果在30分钟内浏览过，则不增加次数
        if (lastViewedTime && (now - lastViewedTime < halfHour)) {
            console.log('30分钟内已浏览过，不增加次数');
            resolve();
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/news/increaseViewCount/' + id,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({newsId: id}),
            success: function(response) {
                if (response.code === 200) {
                    // 更新sessionStorage记录
                    viewedNews[id] = now;
                    sessionStorage.setItem('viewedNews', JSON.stringify(viewedNews));

                    // 更新页面显示
                    const currentCount = parseInt($('#viewCount').text()) || 0;
                    $('#viewCount').text(currentCount + 1);

                    resolve();
                } else {
                    reject(new Error(response.msg || '增加浏览次数失败'));
                }
            },
            error: function(xhr) {
                reject(new Error(xhr.statusText || '请求失败'));
            }
        });
    });
    }


    function loadNewsDetail(id) {
        return $.ajax({
            url: '${pageContext.request.contextPath}/news/' + id,
            type: 'GET',
            dataType: 'json'
        }).then(function(response) {
            if (response.code === 200) {
                return response.data;
            } else {
                throw new Error(response.msg || '获取新闻详情失败');
            }
        });
    }

    // 渲染新闻详情
    function renderNewsDetail(news) {
        console.log("正在渲染新闻数据:", news);
        const $viewCount = $('#viewCount');
        console.log("DOM元素:", $viewCount.length); // 应为1，如果是0则表示未找到元素

        $('#newsTitle').text(news.title);
        $('#newsSource').text(news.source  || '未知来源');
        $('#newsAuthor').text(news.author);
        $('#publishTime').text(news.publishTime);
        $('#newsArticle').html(news.article); // 使用html()而不是text()以支持富文本
        $viewCount.text(news.viewCount);
    }

    // 加载新闻图片
    function loadNewsImage(id) {
        console.log('Loading image for news ID:', id);
        // 假设这里你有正确的元素来显示图片，这里先使用一个示例的ID
        $('#newsCoverImage').attr('src', '${pageContext.request.contextPath}/news/image/' + id + '?t=' + new Date().getTime());
        $('#newsCoverImage').on('error', function () {
            $(this).attr('src', '${pageContext.request.contextPath}/assets/images/default-avatar.png');
        });
    }

    // 退出登录
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