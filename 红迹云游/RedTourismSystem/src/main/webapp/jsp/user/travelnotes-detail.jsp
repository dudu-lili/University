<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>游记详情 - 红色旅游系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.1/dist/echarts.min.js"></script>
<%--    <link rel="stylesheet" href="../../css/footer.css">--%>
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        /*body {*/
        /*    padding-top: 56px;*/
        /*    background-color: #f8f9fa;*/
        /*}*/
        /*.navbar {*/
        /*    background-color: #dc3545;*/
        /*    box-shadow: 0 2px 4px rgba(0,0,0,0.1);*/
        /*}*/
        .section-title {
            color: #dc3545;
            margin: 2rem 0 1rem;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        .d-flex {
            display: flex; /* 使用Flexbox布局 */
            flex-wrap: wrap; /* 允许内容换行 */
            align-items: center; /* 垂直居中对齐 */
            justify-content: center; /* 水平居中对齐 */
        }
        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            color: #6c757d;
            font-weight: bold;
            /*margin: 0 0.5rem; !* 增加分隔符的间距 *!*/
        }
        .breadcrumb-item a {
            color: inherit; /* 继承父元素的颜色 */
            text-decoration: none; /* 去掉下划线 */
        }
        .breadcrumb-item a:hover {
            text-decoration: none; /* 鼠标悬停时也不显示下划线 */
        }
        #travelNotesContent {
            white-space: pre-wrap; /* 保留空白符并换行 */
            line-height: 2; /* 行高，可根据需要调整 */
            margin: 0 auto; /* 居中显示 */
            width: 70%; /* 宽度，可根据需要调整 */
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
        .tou {
            position: relative; /* 设置父容器为相对定位 */
            width: 100%;
            /*width: 1425px;*/
            height: 200px;
        }
        .tou-card1 {
            height: 110px;
            background: url('../../assets/images/banners/travel-bg.jpg') no-repeat center center;
            background-size: 100% 100%;
            margin-top: 28px;
            position: absolute; /* 设置为绝对定位 */
            width: 100%; /* 确保宽度与父容器一致 */
            z-index: 1; /* 确保在 tou-img 下方 */
        }
        .tou-card2 {
            height: 70px;
            border: 1px solid #dedede;
            box-shadow: 0 1px 2px #dedede;
            position: absolute; /* 设置为绝对定位 */
            width: 100%; /* 确保宽度与父容器一致 */
            top: 138px; /* 从顶部偏移 118px，确保与 tou-card1 不重叠 */
            z-index: 1; /* 确保在 tou-img 下方 */
        }
        .tou-img {
            height: 120px;
            width: 120px;
            border-radius: 50%;
            margin-left: 280px; /* 靠左显示 */
            margin-top: 50px; /* 垂直居中 */
            position: absolute; /* 设置为绝对定位 */
            z-index: 2; /* 确保在 tou-card1 和 tou-card2 上方 */
        }
        .tou-tit{
            height:40px;
            color: white;
            font-size:26px;
            font-weight:bolder;
            margin-top: 50px;
            margin-left: 450px;
        }
        .tou-info{
            width:400px;
            height:40px;
            font-size:14px;
            font-weight:normal;
            margin-top: 15px;
            margin-left: 450px;
            white-space: nowrap; /* 防止内容换行 */
        }
        .info{
            height:100%;
            margin:0 10px;
            color: #9f9f9f;
            display: inline; /* 确保内容在同一行显示 */
        }
        .info i {
            margin-right: -2px; /* 添加右侧间距 */
        }
        .fav-info {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100px;
            height: 70px;
            border: 1px solid #dedede;
            margin-left: 900px;
            margin-top: -56px;
        }

        .fav-info i {
            font-size: 24px; /* 调整星星图标的大小 */
            color: #ffc107; /* 调整星星图标的颜色 */
            cursor: pointer; /* 鼠标悬停时显示为手型 */
        }
        .fav-info i.active {
            color: #ff0000; /* 收藏状态下的颜色 */
        }
        .fav-info span {
            font-size: 14px; /* 调整数字的大小 */
            color: #6c757d; /* 调整数字的颜色 */
            display: block; /* 确保内容可见 */
        }
        .imgs-info{
            border-right: 1px solid #dedede;
            margin-left: 1000px;
            margin-top: -70px;
        }
        .imgs-info span{
            font-size: 14px; /* 调整数字的大小 */
            color: #6c757d; /* 调整数字的颜色 */
            display: block; /* 确保内容可见 */
        }
        .vid-info{
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 70px;
            border-right: 1px solid #dedede;
            margin-left: 1100px;
            margin-top: -70px;
        }
        .vid-info span{
            font-size: 14px; /* 调整数字的大小 */
            color: #6c757d; /* 调整数字的颜色 */
            display: block; /* 确保内容可见 */
        }
        .image-gallery {
            margin: 20px 0;
            text-align: center;
        }

        .image-item {
            margin-bottom: 20px;
        }

        .video-container {
            margin: 20px 0;
            text-align: center;
        }
        .imgs-info, .vid-info {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 90px;
            height: 70px;
            border-right: 1px solid #dedede;
            cursor: pointer; /* 添加手型光标表示可点击 */
            transition: all 0.3s ease;
        }
        .imgs-info, .list-info {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 90px;
            height: 70px;
            border-right: 1px solid #dedede;
            cursor: pointer; /* 添加手型光标表示可点击 */
            transition: all 0.3s ease;
        }
        .imgs-info:hover, .vid-info:hover {
            background-color: #f8f9fa;
        }

        .imgs-info i, .vid-info i {
            font-size: 24px;
            color: #dc3545;
            margin-bottom: 5px;
        }

        .imgs-info span, .vid-info span {
            font-size: 14px;
            color: #6c757d;
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

        html, body {
            height: 100%;
        }

        body {
            /*display: flex;*/
            /*flex-direction: column;*/
            padding-top: 56px;
        }

        .container {
            flex: 1;
        }


        /* 调整原有页脚样式 */
        footer {
            background-color: #8b1515 !important; /* 改为红色主题 */
            /*margin-top: 20px;*/
            padding: 20px 0;
            position: relative;
            margin-top: auto;
        }

        /*footer {*/
        /*    background-color: #343a40;*/
        /*    color: white;*/
        /*    padding: 20px 0;*/
        /*    margin-top: auto; !* 这将使页脚始终保持在底部 *!*/
        /*}*/


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
<div class="tou">
    <div class="tou-card1">
        <div class="tou-tit" id="travelNotesTitle"></div>
    </div>
    <div class="tou-card2">
        <div class="tou-info">
            <div class="info" id="travelNotesAuthor"></div>
            <div class="info" id="travelNotesCreatetime"></div>
            <div class="info">
                <i class="bi bi-eye-fill" id="viewCountIcon"></i>
                <span id="viewCount" class="ms-1">0</span> <!-- 添加 margin-left 间距 -->
            </div>

        </div>
        <div class="fav-info">
            <i class="bi bi-star-fill"  id="favoriteIcon" onclick="toggleFavorite()"></i>
            <span id="favoriteCount">0收藏</span>

        </div>
        <div class="imgs-info bi bi-arrow-down-circle" id="imgsInfo" onclick="scrollToImages()">
            <span id="travelImages">图片</span>
        </div>
        <div class="vid-info bi bi-arrow-down-circle" id="vidInfo" onclick="scrollToVideo()">
            <span id="travelVideo">视频</span>
        </div>


    </div>
    <img src="${pageContext.request.contextPath}/user/avatar/${user.id}?t=<%=System.currentTimeMillis()%>"
         onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar1.png'"
         class="tou-img"
         alt="用户头像">
</div>


<div class="container">

    <div class=" mt-3" id="travelNotesContent"></div>
    <div class="image-info" id="travelNotesimages"></div>
    <div class=" mt-3" id="travelNotesvideo">
    </div>


    </div>

<!-- 评论区域 -->
<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="section-title">评论列表</h3>
                <button class="btn btn-sm btn-primary btn-action" onclick="showCommentBox()">
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
<footer class="text-center" style="bottom: 0;width: 100%;background-color: #8b1515; color: white; padding: 20px 0 10px;">
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
    const urlParams = new URLSearchParams(window.location.search);
    const travelNotesId = urlParams.get('id');
    let travelNotesData = null;


    function goBackToList() {
        if (window.opener && !window.opener.closed) {
            // 先调用列表页的更新浏览数函数（假设为updateViewCount）
            if (typeof window.opener.updateViewCount === 'function') {
                window.opener.updateViewCount();
            }

            // 刷新列表页
            window.opener.location.reload(true); // 强制从服务器重新加载

            // 关闭当前窗口
            window.close();
        } else {
            // 如果opener不存在或已关闭，直接跳转到列表页
            window.location.href = "travelnotes-list.jsp?refresh=true";
        }

        // 阻止默认链接行为
        return false;
    }


    function scrollToImages() {
        const imagesSection = document.getElementById('travelNotesimages');
        if (imagesSection && imagesSection.children.length > 0) {
            imagesSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
        } else {
            alert('该游记没有图片内容');
        }
    }

    function scrollToVideo() {
        const videoSection = document.getElementById('travelNotesvideo');
        if (videoSection && videoSection.children.length > 0) {
            videoSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
        } else {
            alert('该游记没有视频内容');
        }
    }




    $(document).ready(function() {
        if (travelNotesId) {
            loadTravelNotesDetail(travelNotesId);
            loadComments(travelNotesId); // 自动加载评论
            setupFavoriteButton(); // 设置收藏按钮
        } else {
            alert('无效的内容ID');
            window.location.href = 'travelnotes-list.jsp';
        }

        // 绑定图片和视频图标点击事件
        $('#imgsInfo').click(function() {
            const imagesSection = document.getElementById('travelNotesimages');
            if (imagesSection) {
                imagesSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
            } else {
                alert('没有图片内容');
            }
        });

        $('#vidInfo').click(function() {
            const videoSection = document.getElementById('travelNotesvideo');
            if (videoSection) {
                videoSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
            } else {
                alert('没有视频内容');
            }
        });
    });




    function toggleFavorite() {
        if (!travelNotesData) return;

        const favoriteBtn = $('#favoriteIcon');
        const isActive = favoriteBtn.hasClass('active');

        // 发送请求到后端
        $.ajax({
            url: `${pageContext.request.contextPath}/travelNotes/${isActive ? 'unfavorite' : 'favorite'}`,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ travelNotesId: travelNotesData.id }),
            success: function(response) {
                if (response.code === 200) {
                    // 更新收藏数量
                    const favoriteCountElement = $('#favoriteCount');
                    const currentCount = parseInt(favoriteCountElement.text().replace('收藏', ''), 10);
                    const newCount = isActive ? currentCount - 1 : currentCount + 1;
                    favoriteCountElement.text(newCount + '收藏');

                    // 更新按钮状态
                    favoriteBtn.toggleClass('active');

                    // 显示提示信息
                    alert(response.msg || (isActive ? '取消收藏成功' : '收藏成功'));
                } else {
                    // 显示失败提示
                    alert(response.msg || '操作失败');
                }
            },
            error: function(xhr) {
                // 请求失败，显示错误提示
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

    function loadTravelNotesDetail(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/travelNotes/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    travelNotesData = response.data;
                    renderTravelNotesDetail(travelNotesData);
                } else {
                    alert('获取景点详情失败: ' + response.msg);
                    window.location.href = 'travelnotes-list.jsp';
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'travelnotes-list.jsp';
            }
        });
    }

    function renderTravelNotesDetail(travelNotes) {
        console.log("Travel Notes Data:", travelNotes);

        // 确保上下文路径可用
        const contextPath = '${pageContext.request.contextPath}';
        console.log("上下文路径:", contextPath);

        $('#travelNotesTitle').text(travelNotes.title);
        $('#travelNotesContent').html(travelNotes.content);
        $('#travelNotesAuthor').text(travelNotes.author || '暂无作者');
        $('#travelNotesPlace').text(travelNotes.place || '暂无地点');
        $('#travelNotesCreatetime').text(travelNotes.createtime);
        $('#viewCount').text(travelNotes.viewCount || 0);
        $('#favoriteCount').text(travelNotes.favoriteCount + '收藏' || '0收藏');


        // 处理图片
        if (travelNotes.images) {
            // 确保 images 是字符串
            const imagesString = String(travelNotes.images);
            // 分割并清理路径
            const imagePaths = imagesString.split(',')
                .map(img => extractFileName(img.trim()))
        .filter(img => img); // 过滤掉空字符串

            console.log("处理后的图片文件名数组:", imagePaths);

            let imageHtml = '';

            imagePaths.forEach(fileName => {
                const fullPath = contextPath + '/assets/images/travelNotes/' + fileName;
            console.log("尝试加载的图片路径:", fullPath);

            imageHtml += `
            <div class="image-item mb-3" onclick="scrollToElement(this)">
                <img src="`+fullPath+`" class="img-fluid rounded shadow"
                     alt="游记图片"
                     onerror="this.style.display='none'; console.log('图片加载失败:', this.src);"
                     style="max-width: 70%; margin: 0 auto; display: block;">
            </div>`;
        });

            if (imageHtml) {
                $('#travelNotesimages').html(`
            <div class="image-gallery mt-4">
                `+imageHtml+`
            </div>
            `).show();
            } else {
                $('#travelNotesimages').hide();
            }
        } else {
            console.log("没有可用的图片数据");
            $('#travelNotesimages').hide();
        }

        // 处理视频
        if (travelNotes.video) {
            const videoFileName = extractFileName(travelNotes.video);
            const videoPath = contextPath + '/assets/images/travelNotes/' + videoFileName;
            console.log("尝试加载的视频路径:", videoPath);

            const videoHtml = `
        <div class="video-container mt-4" onclick="scrollToElement(this)">
            <video width="600px" controls style="display: block; margin: 0 auto;">
                <source src="`+videoPath+`" type="video/mp4">
                您的浏览器不支持视频播放。
            </video>
        </div>`;
            $('#travelNotesvideo').html(videoHtml).show();
        } else {
            $('#travelNotesvideo').hide();
        }

        // 辅助函数：从路径中提取文件名
        function extractFileName(path) {
            return String(path).replace(/^.*[\\/]/, '');
        }
    }

    function scrollToElement(element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function loadComments(travelNotesId) {
        // 显示加载中提示
        $('#commentsBody').html(`
        <div class="text-center py-4">
            <div class="spinner-border text-primary"></div>
            <p class="mt-2">加载评论中...</p>
        </div>
    `);

        // 发起 AJAX 请求获取评论列表
        $.ajax({
            url: '${pageContext.request.contextPath}/comment/travelNotes/formattedList/' + travelNotesId, // 后端接口地址
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    // 如果返回的 code 是 200，表示成功获取评论列表
                    // 将返回的 HTML 内容（response.msg）渲染到 #commentsBody 中
                    $('#commentsBody').html(response.msg);

                } else {
                    // 如果返回的 code 不是 200，表示获取评论失败
                    // 显示错误信息
                    $('#commentsBody').html(`
                    <div class="alert alert-danger">
                        `+response.msg || '加载评论失败'+`
                    </div>
                `);
                }
            },
            error: function(xhr) {
                // 如果 AJAX 请求本身失败（如网络问题、服务器错误等）
                // 显示错误提示
                $('#commentsBody').html(`
                <div class="alert alert-danger">
                    请求失败: `+xhr.statusText+`
                </div>
            `);
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
                        <h5 class="modal-title">评论游记</h5>
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
    function submitComment() {
        const content = $('#commentContent').val().trim();

        if (!content) {
            alert('评论内容不能为空');
            return;
        }

        // 使用从URL获取的travelNotesId，而不是从隐藏字段获取
        $.ajax({
            url: '${pageContext.request.contextPath}/comment/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                travelNotesId: travelNotesId,
                content: content
            }),
            success: function(response) {
                if (response.code === 200) {
                    alert('评论发表成功');
                    $('#commentModal').modal('hide');
                    loadComments(travelNotesId); // 刷新评论列表
                } else {
                    alert(response.msg || '评论发表失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
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



</script>
</body>
</html>