<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>新闻详情 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%--<link rel="stylesheet" href="../../css/footer.css">--%>
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
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
        .nav-link:hover {
            color: #ffc107!important;
        }

        .news-title {
            /*color: #B3100f;*/
            /*margin-bottom: 1rem;*/
            /*font-weight: bold; !* 标题字体加粗 *!*/
            /*text-align: center; !* 标题居中 *!*/
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
        <!-- 修正Logo路径：使用上下文路径确保跨环境适配 -->
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
<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    // 从URL获取新闻ID
    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('id');
    let newsData = null;


    // // 自动将换行内容转换为段落//修改1
    // function convertLineBreaksToParagraphs(container) {
    //     const $container = $(container);
    //     // 将连续换行符替换为</p><p>，并包裹首尾段落标签
    //     const content = $container.html()
    //         .replace(/<br\s*\/?>/gi, '\n') // 先将<br>转换为换行符
    //         .replace(/\n{2,}/g, '</p><p>') // 多个换行符视为段落分隔
    //         .replace(/^\s*/, '<p>') // 开头添加<p>
    //         .replace(/\s*$/, '</p>'); // 结尾添加</p>
    //     $container.html(content);
    // }


    $(document).ready(function() {
        if (newsId) {
            loadNewsDetail(newsId);

        } else {
            alert('无效的内容ID');
            window.location.href = 'news-list.jsp';
        }
    });
    function loadNewsDetail(id) {
       $.ajax({
            url: '${pageContext.request.contextPath}/news/' + id,
            type: 'GET',
            dataType: 'json',
            success:function(response) {
                console.log("新闻响应码:", response.code);
                if (response.code === 200) {
                    // return response.data;
                    newsData = response.data;
                    renderNewsDetail(newsData);
                } else {
                    alert('请求失败: ' + xhr.statusText);
                    window.location.href = 'study-list.jsp';
                }
            },
            error:function (xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'news-list.jsp';
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
        $('#newsAuthor').text(news.author|| '暂无作者');
        $('#publishTime').text(news.publishTime||'暂无时间');
        $('#newsArticle').html(news.article); // 使用html()而不是text()以支持富文本
        $viewCount.text(news.viewCount);
    }

    <%--// 加载新闻图片--%>
    <%--function loadNewsImage(id) {--%>
        <%--console.log('Loading image for news ID:', id);--%>
        <%--// 假设这里你有正确的元素来显示图片，这里先使用一个示例的ID--%>
        <%--$('#newsCoverImage').attr('src', '${pageContext.request.contextPath}/news/image/' + id + '?t=' + new Date().getTime());--%>
        <%--$('#newsCoverImage').on('error', function () {--%>
            <%--$(this).attr('src', '${pageContext.request.contextPath}/assets/images/default-avatar.png');--%>
        <%--});--%>
    <%--}--%>


</script>
</body>
</html>