<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>红色旅游系统 - 编辑游记</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        /*body {*/
        /*    padding-top: 56px;*/
        /*    padding-bottom: 60px; !* 为页脚留出空间 *!*/
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
        .section-title {
            color: #dc3545;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        /*footer {*/
        /*    background-color: #343a40;*/
        /*    color: white;*/
        /*    padding: 20px 0;*/
        /*    position: fixed; !* 固定在底部 *!*/
        /*    bottom: 0;*/
        /*    width: 100%;*/
        /*}*/
        .avatar-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .image-preview {
            margin-top: 10px;
            max-width: 100px;
        }
        .video-preview {
            margin-top: 10px;
            width: 200px;
        }
        .editor-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }
        .content-editor {
            flex: 1;
            min-width: 0;
        }
        .sidebar {
            width: 200px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            position: sticky;
            margin-top:30px;
            align-self: flex-start;
            height: fit-content;
        }
        .sidebar button {
            display: block;
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        .emoji-panel {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-height: 300px; /* 增加高度 */
            width: 350px; /* 增加宽度 */
            overflow-y: auto;
            position: absolute;
            z-index: 1000;
            display: none; /* 默认隐藏 */
        }

        .emoji-tabs {
            display: flex;
            justify-content: space-around;
            margin-bottom: 10px;
        }

        .emoji-tab {
            cursor: pointer;
            padding: 5px 10px;
            border: 1px solid transparent;
            border-radius: 5px;
            background-color: #f0f0f0;
        }

        .emoji-tab.active {
            background-color: #e0e0e0;
            border: 1px solid #ccc;
        }

        .emoji-list {
            display: none;
        }

        .emoji-list.active {
            display: flex;
            flex-wrap: wrap;
        }

        .emoji {
            cursor: pointer;
            padding: 5px;
            font-size: 24px;
        }

        .emoji:hover {
            background-color: #f0f0f0;
            border-radius: 5px;
        }

        /* 新增的按钮样式 */
        .custom-file-upload {
            display: inline-block;
            padding: 10px 15px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            width: 100%;
            text-align: center;
        }

        .custom-file-upload:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .custom-file-upload i {
            margin-right: 8px;
        }

        .form-control-file {
            display: none;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-primary-custom {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }

        .btn-primary-custom:hover {
            background-color: #0069d9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-secondary-custom {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }

        .btn-secondary-custom:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
        }

        .form-control-custom {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
        }

        .content-editable {
            width: 100%;
            min-height: 200px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            white-space: pre-wrap;
        }
        .form-actions button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100px;
            height:40px;
        }
        .form-actions {
            display: flex;
            justify-content: space-between; /* 按钮之间有间隔 */
            align-items: center; /* 垂直居中对齐 */
        }
        .form-actions .btn-primary:hover {
            background-color: #b71c1c;
        }
        .form-actions .btn-secondary {
            background-color: #f8f9fa;
            color: black;
        }
        .form-actions .btn-secondary:hover {
            background-color: #e0e0e0;
        }
        #titleInputContainer {
            width: 100%; /* 设置宽度为100%，使其填满父容器 */
            max-width: 400px; /* 可选：限制最大宽度 */
            margin-top: 10px;
        }
        .title-input-container {
            position: absolute;
            width: 350px; /* 设置宽度 */
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            display: none; /* 默认隐藏 */
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
    <h3 class="section-title">编辑游记</h3>
    <form id="editTravelNotesForm" enctype="multipart/form-data">
        <input type="hidden" name="id" id="travelNotesId">

        <div class="form-group">
            <label class="form-label">标题</label>
            <input type="text" class="form-control-custom" name="title" id="travelNotesTitle">
        </div>

        <div class="editor-container">
            <div class="content-editor">
                <div class="form-group">
                    <label class="form-label">内容</label>
                    <div class="content-editable"
                         id="travelNotesContent"
                         contenteditable="true"
                         style="min-height: 200px; white-space: pre-wrap;">
                    </div>
                </div>
            </div>

            <div class="sidebar">
                <button type="button" class="custom-file-upload" id="insertEmojiBtn">
                    <i class="bi bi-emoji-smile"></i> 插入表情
                </button>
                <button type="button" class="custom-file-upload" id="insertTitleBtn">
                    <i class="bi bi-bar-chart-steps"></i> 插入标题
                </button>
                <div id="titleInputContainer" class="title-input-container" style="display: none;">
                    <input type="text" id="titleInput" placeholder="请输入标题内容" class="form-control-custom">
                    <div class="form-actions" style="margin-top: 10px;">
                        <button type="button" class="btn-primary-custom" id="confirmTitleBtn">确认</button>
                        <button type="button" class="btn-secondary-custom" id="cancelTitleBtn">取消</button>
                    </div>
                </div>
            </div>

            <!-- 隐藏的表情面板 -->
            <div id="emojiPanel" class="emoji-panel" style="display: none; position: absolute; z-index: 1000;">
                <div class="emoji-tabs">
                    <button class="emoji-tab" data-category="common">常用表情</button>
                    <button class="emoji-tab" data-category="moods">心情表情</button>
                    <button class="emoji-tab" data-category="travel">旅行相关</button>
                    <button class="emoji-tab" data-category="move">服饰运动</button>
                    <button class="emoji-tab" data-category="other">其他</button>
                </div>
                <div class="emoji-list-container">
                    <div class="emoji-list common active">
                        <!-- 常用表情 -->
                        <span class="emoji" data-emoji="😊">😊</span>
                        <span class="emoji" data-emoji="👍">👍</span>
                        <span class="emoji" data-emoji="😂">😂</span>
                        <span class="emoji" data-emoji="😍">😍</span>
                        <span class="emoji" data-emoji="😎">😎</span>
                        <span class="emoji" data-emoji="😭">😭</span>
                        <span class="emoji" data-emoji="😡">😡</span>
                        <span class="emoji" data-emoji="🌹">🌹</span>
                        <span class="emoji" data-emoji="🌷">🌷</span>
                        <span class="emoji" data-emoji="🌺">🌺</span>
                        <span class="emoji" data-emoji="🌼">🌼</span>
                        <span class="emoji" data-emoji="🌸">🌸</span>
                        <span class="emoji" data-emoji="💐">💐</span>
                        <span class="emoji" data-emoji="🍎">🍎</span>
                        <span class="emoji" data-emoji="🍌">🍌</span>
                        <span class="emoji" data-emoji="🍇">🍇</span>
                        <span class="emoji" data-emoji="🍓">🍓</span>
                        <span class="emoji" data-emoji="🍔">🍔</span>
                        <span class="emoji" data-emoji="🍕">🍕</span>
                        <span class="emoji" data-emoji="🍜">🍜</span>
                        <span class="emoji" data-emoji="🎂">🎂</span>
                        <span class="emoji" data-emoji="🍪">🍪</span>
                        <span class="emoji" data-emoji="🍵">🍵</span>
                    </div>
                    <div class="emoji-list moods">
                        <!-- 心情表情 -->
                        <span class="emoji" data-emoji="😊">😊</span> <!-- 微笑 -->
                        <span class="emoji" data-emoji="😭">😭</span> <!-- 哭泣 -->
                        <span class="emoji" data-emoji="😍">😍</span> <!-- 心动 -->
                        <span class="emoji" data-emoji="😂">😂</span> <!-- 大笑 -->
                        <span class="emoji" data-emoji="😎">😎</span> <!-- 戴墨镜 -->
                        <span class="emoji" data-emoji="😡">😡</span> <!-- 愤怒 -->
                        <span class="emoji" data-emoji="👍">👍</span> <!-- 点赞 -->
                        <span class="emoji" data-emoji="👎">👎</span> <!-- 点踩 -->
                        <span class="emoji" data-emoji="👌">👌</span> <!-- OK手势 -->
                        <span class="emoji" data-emoji="👏">👏</span> <!-- 鼓掌 -->
                        <span class="emoji" data-emoji="😢">😢</span> <!-- 流泪 -->
                        <span class="emoji" data-emoji="😭">😭</span> <!-- 大哭 -->
                        <span class="emoji" data-emoji="😂">😂</span> <!-- 笑哭 -->
                        <span class="emoji" data-emoji="🤣">🤣</span> <!-- 滚地笑 -->
                        <span class="emoji" data-emoji="😭">😭</span> <!-- 大哭 -->
                        <span class="emoji" data-emoji="😔">😔</span> <!-- 无奈 -->
                        <span class="emoji" data-emoji="😏">😏</span> <!-- 坏笑 -->
                        <span class="emoji" data-emoji="😒">😒</span> <!-- 不屑 -->
                        <span class="emoji" data-emoji="😳">😳</span> <!-- 尴尬 -->
                        <span class="emoji" data-emoji="😜">😜</span> <!-- 吐舌 -->
                        <span class="emoji" data-emoji="😝">😝</span> <!-- 鬼脸 -->
                        <span class="emoji" data-emoji="😲">😲</span> <!-- 惊讶 -->
                        <span class="emoji" data-emoji="😖">😖</span> <!-- 痛苦 -->
                        <span class="emoji" data-emoji="😣">😣</span> <!-- 难受 -->
                        <span class="emoji" data-emoji="😫">😫</span> <!-- 疲惫 -->
                        <span class="emoji" data-emoji="😤">😤</span> <!-- 生气 -->
                        <span class="emoji" data-emoji="😥">😥</span> <!-- 委屈 -->
                        <span class="emoji" data-emoji="😓">😓</span> <!-- 流汗 -->
                        <span class="emoji" data-emoji="😩">😩</span> <!-- 发愁 -->
                        <span class="emoji" data-emoji="🤪">🤪</span> <!-- 鬼脸 -->
                        <span class="emoji" data-emoji="🤗">🤗</span> <!-- 抱抱 -->
                        <span class="emoji" data-emoji="🤭">🤭</span> <!-- 偷笑 -->
                        <span class="emoji" data-emoji="🧐">🧐</span> <!-- 思考 -->
                        <span class="emoji" data-emoji="🤔">🤔</span> <!-- 沉思 -->
                        <span class="emoji" data-emoji="😕">😕</span> <!-- 疑惑 -->
                        <span class="emoji" data-emoji="🙄">🙄</span> <!-- 翻白眼 -->
                        <span class="emoji" data-emoji="😴">😴</span> <!-- 睡觉 -->
                        <span class="emoji" data-emoji="💤">💤</span> <!-- 困 -->
                        <span class="emoji" data-emoji="👍">👍</span>
                        <span class="emoji" data-emoji="👎">👎</span>
                        <span class="emoji" data-emoji="👋">👋</span>
                        <span class="emoji" data-emoji="👌">👌</span>
                        <span class="emoji" data-emoji="👏">👏</span>
                        <span class="emoji" data-emoji="✌️">✌️</span>
                        <span class="emoji" data-emoji="🙏">🙏</span>
                        <!-- 男孩女孩等相关表情 -->
                        <span class="emoji" data-emoji="👦">👦</span> <!-- 男孩 -->
                        <span class="emoji" data-emoji="👧">👧</span> <!-- 女孩 -->
                        <span class="emoji" data-emoji="👨">👨</span> <!-- 男人 -->
                        <span class="emoji" data-emoji="👩">👩</span> <!-- 女人 -->
                        <span class="emoji" data-emoji="👴">👴</span> <!-- 老爷爷 -->
                        <span class="emoji" data-emoji="👵">👵</span> <!-- 老奶奶 -->
                        <span class="emoji" data-emoji="👨‍🦳">👨‍🦳</span> <!-- 头发花白的男人 -->
                        <span class="emoji" data-emoji="👩‍🦳">👩‍🦳</span> <!-- 头发花白的女人 -->
                        <span class="emoji" data-emoji="👨‍🦲">👨‍🦲</span> <!-- 脱发的男人 -->
                        <span class="emoji" data-emoji="👨‍🦰">👨‍🦰</span> <!-- 红头发的男人 -->
                        <span class="emoji" data-emoji="👩‍🦰">👩‍🦰</span> <!-- 红头发的女人 -->
                        <span class="emoji" data-emoji="👨‍🦱">👨‍🦱</span> <!-- 金头发的男人 -->
                        <span class="emoji" data-emoji="👩‍🦱">👩‍🦱</span> <!-- 金头发的女人 -->
                        <span class="emoji" data-emoji="👨‍⚖️">👨‍⚖️</span> <!-- 法官（男人） -->
                        <span class="emoji" data-emoji="👩‍⚖️">👩‍⚖️</span> <!-- 法官（女人） -->
                        <span class="emoji" data-emoji="👨‍🍳">👨‍🍳</span> <!-- 厨师（男人） -->
                        <span class="emoji" data-emoji="👩‍🍳">👩‍🍳</span> <!-- 厨师（女人） -->
                        <span class="emoji" data-emoji="👨‍🏫">👨‍🏫</span> <!-- 教师（男人） -->
                        <span class="emoji" data-emoji="👩‍🏫">👩‍🏫</span> <!-- 教师（女人） -->
                        <span class="emoji" data-emoji="👨‍🚀">👨‍🚀</span> <!-- 宇航员（男人） -->
                        <span class="emoji" data-emoji="👩‍🚀">👩‍🚀</span> <!-- 宇航员（女人） -->
                    </div>
                    <div class="emoji-list travel">
                        <!-- 旅行相关表情 -->
                        <span class="emoji" data-emoji="🌍">🌍</span>
                        <span class="emoji" data-emoji="🏨">🏨</span>
                        <span class="emoji" data-emoji="📸">📸</span>

                        <span class="emoji" data-emoji="🚂">🚂</span>
                        <span class="emoji" data-emoji="🚤">🚤</span>
                        <span class="emoji" data-emoji="☀️">☀️</span>
                        <span class="emoji" data-emoji="☁️">☁️</span>
                        <span class="emoji" data-emoji="☂️">☂️</span>
                        <span class="emoji" data-emoji="☔">☔</span>

                        <span class="emoji" data-emoji="🌞">🌞</span> <!-- 太阳 -->
                        <span class="emoji" data-emoji="🌙">🌙</span> <!-- 月亮 -->
                        <span class="emoji" data-emoji="🌟">🌟</span> <!-- 星星 -->
                        <span class="emoji" data-emoji="⭐">⭐</span> <!-- 五角星 -->
                        <span class="emoji" data-emoji="🌈">🌈</span> <!-- 彩虹 -->
                        <span class="emoji" data-emoji="🌧️">🌧️</span> <!-- 下雨 -->
                        <span class="emoji" data-emoji="❄️">❄️</span> <!-- 雪花 -->
                        <span class="emoji" data-emoji="🔥">🔥</span> <!-- 火焰 -->
                        <span class="emoji" data-emoji="💧">💧</span> <!-- 水滴 -->
                        <span class="emoji" data-emoji="☃️">☃️</span>
                        <span class="emoji" data-emoji="🌀">🌀</span>


                        <span class="emoji" data-emoji="🚄">🚄</span> <!-- 高铁 -->

                        <span class="emoji" data-emoji="🚗">🚗</span> <!-- 汽车 -->
                        <span class="emoji" data-emoji="🚕">🚕</span> <!-- 出租车 -->
                        <span class="emoji" data-emoji="🚙">🚙</span> <!-- 轿车 -->
                        <span class="emoji" data-emoji="🚌">🚌</span> <!-- 公交车 -->
                        <span class="emoji" data-emoji="🚎">🚎</span> <!-- 电车 -->
                        <span class="emoji" data-emoji="🚑">🚑</span> <!-- 救护车 -->
                        <span class="emoji" data-emoji="🚒">🚒</span> <!-- 消防车 -->
                        <span class="emoji" data-emoji="🚓">🚓</span> <!-- 警车 -->
                        <span class="emoji" data-emoji="🚀">🚀</span> <!-- 火箭 -->
                        <span class="emoji" data-emoji="✈️">✈️</span> <!-- 飞机 -->
                        <span class="emoji" data-emoji="🚢">🚢</span> <!-- 船 -->
                        <span class="emoji" data-emoji="🚲">🚲</span> <!-- 自行车 -->
                        <span class="emoji" data-emoji="🛴">🛴</span> <!-- 滑板车 -->
                        <span class="emoji" data-emoji="🏍️">🏍️</span> <!-- 摩托车 -->
                        <span class="emoji" data-emoji="🏕️">🏕️</span> <!-- 露营 -->
                        <span class="emoji" data-emoji="🏖️">🏖️</span> <!-- 海滩 -->
                        <span class="emoji" data-emoji="🌆">🌆</span> <!-- 城市夜景 -->
                        <span class="emoji" data-emoji="🌅">🌅</span> <!-- 日落 -->
                        <span class="emoji" data-emoji="🌄">🌄</span> <!-- 日出 -->
                        <span class="emoji" data-emoji="🌍">🌍</span> <!-- 地球 -->
                        <span class="emoji" data-emoji="🗺️">🗺️</span> <!-- 地图 -->
                        <span class="emoji" data-emoji="🗻">🗻</span> <!-- 雪山 -->
                        <span class="emoji" data-emoji="⛰️">⛰️</span> <!-- 山 -->
                        <span class="emoji" data-emoji="🌳">🌳</span> <!-- 树 -->
                        <span class="emoji" data-emoji="🌸">🌸</span> <!-- 樱花 -->
                        <span class="emoji" data-emoji="🍃">🍃</span> <!-- 叶子 -->
                        <span class="emoji" data-emoji="💐">💐</span> <!-- 花束 -->
                        <span class="emoji" data-emoji="🍜">🍜</span> <!-- 面条 -->
                        <span class="emoji" data-emoji="🍔">🍔</span> <!-- 汉堡 -->
                        <span class="emoji" data-emoji="🍷">🍷</span> <!-- 红酒 -->
                        <span class="emoji" data-emoji="🍰">🍰</span> <!-- 蛋糕 -->
                        <span class="emoji" data-emoji="🛏️">🛏️</span> <!-- 床 -->
                        <span class="emoji" data-emoji="🛁">🛁</span> <!-- 浴缸 -->
                        <span class="emoji" data-emoji="🧳">🧳</span> <!-- 行李箱 -->
                        <span class="emoji" data-emoji="👒">👒</span> <!-- 帽子 -->
                        <span class="emoji" data-emoji="🕶️">🕶️</span> <!-- 太阳镜 -->
                        <!-- 国旗 -->
                        <span class="emoji" data-emoji="🇨🇳">🇨🇳</span> <!-- 中国国旗 -->
                        <span class="emoji" data-emoji="🇺🇸">🇺🇸</span> <!-- 美国国旗 -->
                        <span class="emoji" data-emoji="🇬🇧">🇬🇧</span> <!-- 英国国旗 -->
                        <span class="emoji" data-emoji="🇫🇷">🇫🇷</span> <!-- 法国国旗 -->
                        <span class="emoji" data-emoji="🇩🇪">🇩🇪</span> <!-- 德国国旗 -->
                        <span class="emoji" data-emoji="🇯🇵">🇯🇵</span> <!-- 日本国旗 -->
                        <span class="emoji" data-emoji="🇰🇷">🇰🇷</span> <!-- 韩国国旗 -->

                        <!-- 货币 -->
                        <span class="emoji" data-emoji="💴">💴</span> <!-- 日元 -->
                        <span class="emoji" data-emoji="💶">💶</span> <!-- 欧元 -->
                        <span class="emoji" data-emoji="💷">💷</span> <!-- 英镑 -->
                        <span class="emoji" data-emoji="💰">💰</span> <!-- 钱袋 -->
                        <span class="emoji" data-emoji="💳">💳</span> <!-- 信用卡（也可代表银行卡） -->

                        <!-- 停车相关 -->
                        <span class="emoji" data-emoji="🅿️">🅿️</span> <!-- 停车标志 -->
                        <span class="emoji" data-emoji="🚧">🚧</span> <!-- 施工标志，有时也可暗示道路情况与停车有关 -->

                        <!-- 红绿灯 -->
                        <span class="emoji" data-emoji="🚥">🚥</span> <!-- 红绿灯 -->

                        <!-- ATM -->
                        <span class="emoji" data-emoji="🏧">🏧</span> <!-- ATM机 -->

                        <!-- 银行卡 -->
                        <span class="emoji" data-emoji="💳">💳</span> <!-- 前面已提及，可代表银行卡 -->
                        <span class="emoji" data-emoji="📛">📛</span> <!-- 工牌之类的卡片，也可勉强表示卡片类东西，类似银行卡概念 -->
                    </div>
                    <div class="emoji-list other">
                        <!-- 动物 -->
                        <span class="emoji" data-emoji="🐶">🐶</span> <!-- 狗 -->
                        <span class="emoji" data-emoji="🐱">🐱</span> <!-- 猫 -->
                        <span class="emoji" data-emoji="🐭">🐭</span> <!-- 老鼠 -->
                        <span class="emoji" data-emoji="🐹">🐹</span> <!-- 仓鼠 -->
                        <span class="emoji" data-emoji="🐰">🐰</span> <!-- 兔子 -->
                        <span class="emoji" data-emoji="🐻">🐻</span> <!-- 熊 -->
                        <span class="emoji" data-emoji="🐼">🐼</span> <!-- 熊猫 -->
                        <span class="emoji" data-emoji="🐨">🐨</span> <!-- 考拉 -->
                        <span class="emoji" data-emoji="🐯">🐯</span> <!-- 老虎 -->
                        <span class="emoji" data-emoji="🦁">🦁</span> <!-- 狮子 -->
                        <span class="emoji" data-emoji="🐮">🐮</span> <!-- 牛 -->
                        <span class="emoji" data-emoji="🐷">🐷</span> <!-- 猪 -->
                        <span class="emoji" data-emoji="🐸">🐸</span> <!-- 青蛙 -->
                        <span class="emoji" data-emoji="🐢">🐢</span> <!-- 乌龟 -->
                        <span class="emoji" data-emoji="🐍">🐍</span> <!-- 蛇 -->
                        <span class="emoji" data-emoji="🦅">🦅</span> <!-- 鹰 -->

                        <!-- 餐具 -->
                        <span class="emoji" data-emoji="🍽️">🍽️</span> <!-- 餐具 -->
                        <span class="emoji" data-emoji="🍴">🍴</span> <!-- 叉子 -->
                        <span class="emoji" data-emoji="🍽">🍽</span> <!-- 刀叉和餐盘 -->
                        <span class="emoji" data-emoji="🍜">🍜</span> <!-- 面条 -->
                        <span class="emoji" data-emoji="🥢">🥢</span> <!-- 筷子 -->
                        <span class="emoji" data-emoji="🍲">🍲</span> <!-- 火锅 -->
                        <span class="emoji" data-emoji="🍳">🍳</span> <!-- 煎蛋 -->
                        <span class="emoji" data-emoji="🍞">🍞</span> <!-- 面包 -->
                        <span class="emoji" data-emoji="🥐">🥐</span> <!-- 牛角面包 -->
                        <span class="emoji" data-emoji="🥖">🥖</span> <!-- 法棍 -->

                        <!-- 爱心 -->
                        <span class="emoji" data-emoji="❤️">❤️</span> <!-- 红心 -->
                        <span class="emoji" data-emoji="💛">💛</span> <!-- 黄心 -->
                        <span class="emoji" data-emoji="💚">💚</span> <!-- 绿心 -->
                        <span class="emoji" data-emoji="💙">💙</span> <!-- 蓝心 -->
                        <span class="emoji" data-emoji="💜">💜</span> <!-- 紫心 -->
                        <span class="emoji" data-emoji="🖤">🖤</span> <!-- 黑心 -->
                        <span class="emoji" data-emoji="🤍">🤍</span> <!-- 白心 -->
                        <span class="emoji" data-emoji="💕">💕</span> <!-- 两颗心 -->
                        <span class="emoji" data-emoji="💞">💞</span> <!-- 旋转的心 -->
                        <span class="emoji" data-emoji="💓">💓</span> <!-- 心跳 -->

                        <!-- 红唇 -->
                        <span class="emoji" data-emoji="💋">💋</span> <!-- 飞吻 -->
                        <span class="emoji" data-emoji="💄">💄</span> <!-- 口红 -->
                        <span class="emoji" data-emoji="👄">👄</span> <!-- 嘴巴 -->

                        <!-- 对话 -->
                        <span class="emoji" data-emoji="💬">💬</span> <!-- 对话气泡 -->
                        <span class="emoji" data-emoji="🗨️">🗨️</span> <!-- 对话气泡（带箭头） -->
                        <span class="emoji" data-emoji="📢">📢</span> <!-- 喇叭 -->
                        <span class="emoji" data-emoji="📣">📣</span> <!-- 扩音器 -->

                        <!-- 信封 -->
                        <span class="emoji" data-emoji="✉️">✉️</span> <!-- 信封 -->
                        <span class="emoji" data-emoji="📩">📩</span> <!-- 收件箱 -->
                        <span class="emoji" data-emoji="📨">📨</span> <!-- 发件箱 -->
                        <span class="emoji" data-emoji="📧">📧</span> <!-- 电子邮件 -->

                        <!-- 笔 -->
                        <span class="emoji" data-emoji="✏️">✏️</span> <!-- 铅笔 -->
                        <span class="emoji" data-emoji="🖋️">🖋️</span> <!-- 钢笔 -->
                        <span class="emoji" data-emoji="🖊️">🖊️</span> <!-- 圆珠笔 -->
                        <span class="emoji" data-emoji="✒️">✒️</span> <!-- 毛笔 -->
                        <span class="emoji" data-emoji="🌼">🌼</span> <!-- 花朵 -->
                        <span class="emoji" data-emoji="🌹">🌹</span> <!-- 玫瑰 -->
                        <span class="emoji" data-emoji="🌻">🌻</span> <!-- 向日葵 -->
                        <span class="emoji" data-emoji="🍀">🍀</span> <!-- 四叶草 -->
                        <span class="emoji" data-emoji="🍁">🍁</span> <!-- 枫叶 -->
                        <span class="emoji" data-emoji="🍎">🍎</span> <!-- 苹果 -->
                        <span class="emoji" data-emoji="🍌">🍌</span> <!-- 香蕉 -->
                        <span class="emoji" data-emoji="🍉">🍉</span> <!-- 西瓜 -->
                        <span class="emoji" data-emoji="🍓">🍓</span> <!-- 草莓 -->
                        <span class="emoji" data-emoji="🍔">🍔</span> <!-- 汉堡 -->
                        <span class="emoji" data-emoji="🍕">🍕</span> <!-- 披萨 -->
                        <span class="emoji" data-emoji="🍟">🍟</span> <!-- 薯条 -->
                        <span class="emoji" data-emoji="🍗">🍗</span> <!-- 鸡腿 -->
                        <span class="emoji" data-emoji="🍜">🍜</span> <!-- 面条 -->
                        <span class="emoji" data-emoji="🍝">🍝</span> <!-- 意大利面 -->
                        <span class="emoji" data-emoji="🍣">🍣</span> <!-- 寿司 -->
                        <span class="emoji" data-emoji="🍤">🍤</span> <!-- 虾 -->
                        <span class="emoji" data-emoji="🍰">🍰</span> <!-- 蛋糕 -->
                        <span class="emoji" data-emoji="🍧">🍧</span> <!-- 刨冰 -->
                        <span class="emoji" data-emoji="☕">☕</span> <!-- 咖啡 -->
                        <span class="emoji" data-emoji="🍵">🍵</span> <!-- 茶 -->
                        <span class="emoji" data-emoji="🍾">🍾</span> <!-- 香槟 -->
                        <span class="emoji" data-emoji="🍷">🍷</span> <!-- 红酒 -->

                        <span class="emoji" data-emoji="🔔">🔔</span> <!-- 铃铛 -->
                        <span class="emoji" data-emoji="📢">📢</span> <!-- 喇叭 -->
                        <span class="emoji" data-emoji="📚">📚</span> <!-- 书本 -->
                        <span class="emoji" data-emoji="📖">📖</span> <!-- 打开的书本 -->
                        <span class="emoji" data-emoji="✏️">✏️</span> <!-- 铅笔 -->
                        <span class="emoji" data-emoji="🖊️">🖊️</span> <!-- 钢笔 -->
                        <span class="emoji" data-emoji="🖌️">🖌️</span> <!-- 画笔 -->
                        <span class="emoji" data-emoji="🎨">🎨</span> <!-- 调色板 -->
                        <span class="emoji" data-emoji="📐">📐</span> <!-- 三角尺 -->
                        <span class="emoji" data-emoji="📏">📏</span> <!-- 直尺 -->
                        <span class="emoji" data-emoji="💻">💻</span> <!-- 电脑 -->
                        <span class="emoji" data-emoji="🖥️">🖥️</span> <!-- 台式电脑 -->
                        <span class="emoji" data-emoji="📱">📱</span> <!-- 手机 -->
                        <span class="emoji" data-emoji="☎️">☎️</span> <!-- 电话 -->
                        <span class="emoji" data-emoji="📞">📞</span> <!-- 听筒 -->
                        <span class="emoji" data-emoji="📺">📺</span> <!-- 电视 -->
                        <span class="emoji" data-emoji="🎥">🎥</span> <!-- 摄像机 -->
                        <span class="emoji" data-emoji="🎬">🎬</span> <!-- 电影摄像机 -->

                        <span class="emoji" data-emoji="💡">💡</span> <!-- 灯泡 -->
                        <span class="emoji" data-emoji="🔦">🔦</span> <!-- 手电筒 -->
                        <span class="emoji" data-emoji="🕯️">🕯️</span> <!-- 蜡烛 -->
                        <span class="emoji" data-emoji="💣">💣</span> <!-- 炸弹 -->
                        <span class="emoji" data-emoji="🔪">🔪</span> <!-- 刀 -->
                        <span class="emoji" data-emoji="✂️">✂️</span> <!-- 剪刀 -->
                        <span class="emoji" data-emoji="🔒">🔒</span> <!-- 锁 -->
                        <span class="emoji" data-emoji="🔓">🔓</span> <!-- 开锁 -->
                        <span class="emoji" data-emoji="💰">💰</span> <!-- 钱 -->
                        <span class="emoji" data-emoji="💴">💴</span> <!-- 日元 -->
                        <span class="emoji" data-emoji="💵">💵</span> <!-- 美元 -->
                        <span class="emoji" data-emoji="💶">💶</span> <!-- 欧元 -->
                        <span class="emoji" data-emoji="💷">💷</span> <!-- 英镑 -->
                        <span class="emoji" data-emoji="🎁">🎁</span> <!-- 礼物 -->
                        <span class="emoji" data-emoji="🎊">🎊</span> <!-- 彩带 -->
                        <span class="emoji" data-emoji="🎉">🎉</span> <!-- 派对彩炮 -->
                        <span class="emoji" data-emoji="🎎">🎎</span> <!-- 日本玩偶 -->
                        <span class="emoji" data-emoji="🎏">🎏</span> <!-- 鲤鱼旗 -->
                        <span class="emoji" data-emoji="🏮">🏮</span> <!-- 红灯笼 -->
                        <span class="emoji" data-emoji="🎐">🎐</span> <!-- 风铃 -->
                    </div>
                    <div class="emoji-list move">
                        <!-- 服饰 -->
                        <span class="emoji" data-emoji="👕">👕</span> <!-- T恤 -->
                        <span class="emoji" data-emoji="👚">👚</span> <!-- 女式衬衫 -->
                        <span class="emoji" data-emoji="👖">👖</span> <!-- 裤子 -->
                        <span class="emoji" data-emoji="👗">👗</span> <!-- 连衣裙 -->
                        <span class="emoji" data-emoji="🧥">🧥</span> <!-- 外套 -->
                        <span class="emoji" data-emoji="👘">👘</span> <!-- 和服 -->
                        <span class="emoji" data-emoji="👙">👙</span> <!-- 比基尼 -->
                        <span class="emoji" data-emoji="👠">👠</span> <!-- 高跟鞋 -->
                        <span class="emoji" data-emoji="👢">👢</span> <!-- 靴子 -->
                        <span class="emoji" data-emoji="👟">👟</span> <!-- 运动鞋 -->
                        <span class="emoji" data-emoji="🧢">🧢</span> <!-- 帽子 -->
                        <span class="emoji" data-emoji="👒">👒</span> <!-- 遮阳帽 -->
                        <span class="emoji" data-emoji="👓">👓</span> <!-- 眼镜 -->
                        <span class="emoji" data-emoji="🕶️">🕶️</span> <!-- 太阳镜 -->
                        <span class="emoji" data-emoji="🧣">🧣</span> <!-- 围巾 -->
                        <span class="emoji" data-emoji="🧤">🧤</span> <!-- 手套 -->

                        <!-- 运动 -->
                        <span class="emoji" data-emoji="⚽">⚽</span> <!-- 足球 -->
                        <span class="emoji" data-emoji="🏀">🏀</span> <!-- 篮球 -->
                        <span class="emoji" data-emoji="🏈">🏈</span> <!-- 橄榄球 -->
                        <span class="emoji" data-emoji="⚾">⚾</span> <!-- 棒球 -->
                        <span class="emoji" data-emoji="🎾">🎾</span> <!-- 网球 -->
                        <span class="emoji" data-emoji="🏐">🏐</span> <!-- 排球 -->
                        <span class="emoji" data-emoji="🏉">🏉</span> <!-- 澳式橄榄球 -->
                        <span class="emoji" data-emoji="🏓">🏓</span> <!-- 乒乓球 -->
                        <span class="emoji" data-emoji="🏸">🏸</span> <!-- 羽毛球 -->
                        <span class="emoji" data-emoji="⛸️">⛸️</span> <!-- 滑冰 -->
                        <span class="emoji" data-emoji="🏂">🏂</span> <!-- 单板滑雪 -->
                        <span class="emoji" data-emoji="⛷️">⛷️</span> <!-- 双板滑雪 -->
                        <span class="emoji" data-emoji="🚴">🚴</span> <!-- 骑自行车 -->
                        <span class="emoji" data-emoji="🚴‍♂️">🚴‍♂️</span> <!-- 男性骑自行车 -->
                        <span class="emoji" data-emoji="🚴‍♀️">🚴‍♀️</span> <!-- 女性骑自行车 -->
                        <span class="emoji" data-emoji="🏊">🏊</span> <!-- 游泳 -->
                        <span class="emoji" data-emoji="🏊‍♂️">🏊‍♂️</span> <!-- 男性游泳 -->
                        <span class="emoji" data-emoji="🏊‍♀️">🏊‍♀️</span> <!-- 女性游泳 -->
                        <span class="emoji" data-emoji="🤸">🤸</span> <!-- 侧空翻 -->
                        <span class="emoji" data-emoji="🤸‍♂️">🤸‍♂️</span> <!-- 男性侧空翻 -->
                        <span class="emoji" data-emoji="🤸‍♀️">🤸‍♀️</span> <!-- 女性侧空翻 -->
                        <span class="emoji" data-emoji="🏹">🏹</span> <!-- 射箭 -->
                        <span class="emoji" data-emoji="🏌️">🏌️</span> <!-- 高尔夫 -->
                        <span class="emoji" data-emoji="🏌️‍♂️">🏌️‍♂️</span> <!-- 男性高尔夫 -->
                        <span class="emoji" data-emoji="🏌️‍♀️">🏌️‍♀️</span> <!-- 女性高尔夫 -->
                    </div>
                </div>
            </div>

            <!-- 隐藏的文件选择框 -->
            <input type="file" id="imageFileInput" accept="image/*" style="display: none;">
            <input type="file" id="videoFileInput" accept="video/*" style="display: none;">
            <input type="hidden" name="existingImages" id="existingImages">
        </div>

        <div class="form-group">
            <label class="form-label">地点</label>
            <input type="text" class="form-control-custom" name="place" id="travelNotesPlace">
        </div>

        <div class="form-group">
            <label class="form-label">封面图片</label>
            <label for="travelNotesBanImage" class="custom-file-upload">
                <i class="bi bi-image"></i> 选择封面图片
            </label>
            <input type="file" class="form-control-file" name="banImage" id="travelNotesBanImage">
            <div id="banImagePreview" class="image-preview"></div>
        </div>

        <div class="form-group">
            <label class="form-label">图片列表<h6>（重新上传你的图片）</h6></label>
            <label for="travelNotesImages" class="custom-file-upload">
                <i class="bi bi-images"></i> 选择图片
            </label>
            <input type="file" class="form-control-file" name="images" multiple id="travelNotesImages">
            <div id="imagesPreview" class="form-control" contenteditable="true" style="min-height: 300px; margin-top:10px;"></div>
        </div>

        <div class="form-group">
            <label class="form-label">视频</label>
            <label for="travelNotesVideo" class="custom-file-upload">
                <i class="bi bi-file-earmark-play"></i> 选择视频
            </label>
            <input type="file" class="form-control-file" name="video" id="travelNotesVideo">
            <div id="videoPreview" class="video-preview"></div>
        </div>

        <div class="action-buttons">
            <button type="button" class="btn-primary-custom" onclick="updateTravelNotes()">
                <i class="bi bi-save"></i> 保存修改
            </button>
            <button type="button" class="btn-secondary-custom" onclick="window.history.back()">
                <i class="bi bi-x"></i> 取消
            </button>
        </div>
    </form>
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>

//图片列表
    $(document).ready(function() {
        $(document).on('click', '.remove-image', function() {
            const fileName = $(this).data('file');
            const previewItem = $(this).parent();
            const existingImages = $('#imagesPreview').find('.image-preview').map((_, img) => {
                return $(img).find('img').attr('src').split('/').pop();
        }).get();

            const updatedImages = existingImages.filter(img => img !== fileName).join(',');

            $('#imagesPreview').find('.image-preview').each(function() {
                if ($(this).find('img').attr('src').includes(fileName)) {
                    $(this).remove();
                }
            });

            // 更新隐藏字段中的图片路径
            $('#existingImages').val(updatedImages);
        });
    });


//表情
    $(document).ready(function() {
        const travelNotesId = new URLSearchParams(window.location.search).get('id');
        if (travelNotesId) {
            loadTravelNotesDetail(travelNotesId);
        } else {
            alert('无效的游记ID');
            window.location.href = 'user-center-travelnotes.jsp';
        }

        // 图片预览功能
        $('#travelNotesImages').change(function(e) {
            previewImages(e, 'imagesPreview');
        });

        // 视频预览功能
        $('#travelNotesVideo').change(function(e) {
            previewVideo(e, 'videoPreview');
        });

        // 封面图片预览功能
        $('#travelNotesBanImage').change(function(e) {
            previewImage(e, 'banImagePreview');
        });

        // 绑定插入表情按钮的点击事件
        $('#insertEmojiBtn').click(function() {
            const emojiPanel = $('#emojiPanel');
            if (emojiPanel.is(':visible')) {
                emojiPanel.hide(); // 如果已经显示，则隐藏
            } else {
                // 计算表情面板的位置，使其显示在按钮左边
                const btnPosition = $('#insertEmojiBtn').offset();
                const btnWidth = $('#insertEmojiBtn').outerWidth();
                emojiPanel.css({
                    top: btnPosition.top + $('#insertEmojiBtn').outerHeight() + 10,
                    left: btnPosition.left - 360 // 调整为按钮左边的位置
                }).show();
            }
        });

        // 监听表情分类切换按钮的点击事件
        $('.emoji-tab').click(function() {
            const category = $(this).data('category');
            $('.emoji-tab').removeClass('active');
            $(this).addClass('active');
            $('.emoji-list').removeClass('active');
            $('.emoji-list.' + category).addClass('active');
        });

        // 监听表情符号的点击事件
        $(document).on('click', '.emoji', function() {
            const emoji = $(this).data('emoji');
            const currentContent = $('#travelNotesContent').html(); // 获取当前内容
            $('#travelNotesContent').html(currentContent + emoji); // 将表情符号追加到内容末尾

            // 插入表情后隐藏面板
            $('#emojiPanel').hide();
        });

        // 点击页面其他地方隐藏表情面板
        $(document).mouseup(function(e) {
            const emojiPanel = $('#emojiPanel');
            if (!emojiPanel.is(e.target) && emojiPanel.has(e.target).length === 0) {
                emojiPanel.hide();
            }
        });


    });
//标题
    $(document).ready(function() {
        // 绑定插入标题按钮的点击事件
        $('#insertTitleBtn').click(function() {
            const titleInputContainer = $('#titleInputContainer');
            if (titleInputContainer.is(':visible')) {
                titleInputContainer.hide(); // 如果已经显示，则隐藏
            } else {
                // 计算标题输入框的位置，使其显示在按钮右边
                const btnPosition = $('#insertTitleBtn').offset();
                const btnWidth = $('#insertTitleBtn').outerWidth();
                titleInputContainer.css({
                    width:350,
                    right: 0
                }).show();
            }
        });

        // 绑定确认按钮的点击事件
        $('#confirmTitleBtn').click(function() {
            const titleText = $('#titleInput').val(); // 获取输入框中的内容
            if (titleText) {
                const content = $('#travelNotesContent').html(); // 获取当前内容
                // 插入标题并换行
                $('#travelNotesContent').html(content + '<h4>' + titleText + '</h4><br>');
                $('#titleInput').val(''); // 清空输入框
                $('#titleInputContainer').hide(); // 隐藏输入框和按钮
            }
        });

        // 绑定取消按钮的点击事件
        $('#cancelTitleBtn').click(function() {
            $('#titleInput').val(''); // 清空输入框
            $('#titleInputContainer').hide(); // 隐藏输入框和按钮
        });

        // 点击页面其他地方隐藏标题输入框
        $(document).mouseup(function(e) {
            const titleInputContainer = $('#titleInputContainer');
            if (!titleInputContainer.is(e.target) && titleInputContainer.has(e.target).length === 0) {
                titleInputContainer.hide();
            }
        });
    });




    function insertEmoji(emoji) {
        const contentEditable = document.getElementById('travelNotesContent');
        const selection = window.getSelection();
        const range = selection.rangeCount > 0 ? selection.getRangeAt(0) : document.createRange();

        // 创建一个文本节点来存储表情
        const emojiNode = document.createTextNode(emoji);

        // 将表情插入到当前光标位置
        range.deleteContents();
        range.insertNode(emojiNode);

        // 将光标移动到表情后面
        range.setStartAfter(emojiNode);
        selection.removeAllRanges();
        selection.addRange(range);

        // 确保内容框重新聚焦
        contentEditable.focus();
    }

    function insertTitle(titleText) {
        if (!titleText) return;

        const contentEditable = document.getElementById('travelNotesContent');
        const selection = window.getSelection();
        const range = selection.rangeCount > 0 ? selection.getRangeAt(0) : document.createRange();

        const h4 = document.createElement('h4');
        h4.textContent = titleText;
        h4.style.margin = '10px 0';

        const br = document.createElement('br');

        // 将标题插入到当前光标位置
        range.deleteContents();
        range.insertNode(h4);
        range.insertNode(br);

        // 将光标移动到标题后面
        range.setStartAfter(br);
        selection.removeAllRanges();
        selection.addRange(range);

        // 确保内容框重新聚焦
        contentEditable.focus();
    }


    function loadTravelNotesDetail(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/travelNotes/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    const travelNotes = response.data;

                    // 填充表单字段
                    $('#travelNotesId').val(travelNotes.id);
                    $('#travelNotesTitle').val(travelNotes.title);
                    $('#travelNotesContent').html(travelNotes.content);
                    $('#travelNotesPlace').val(travelNotes.place);



                    // 显示已上传的视频
                    if (travelNotes.video && travelNotes.video.trim()) {
                        const fileName = extractFileName(travelNotes.video);
                        const videoPath = '${pageContext.request.contextPath}/assets/images/travelNotes/' + fileName;
                        const videoHtml = `
                        <div class="video-preview mb-2">
                            <video controls style="max-width: 300px;">
                                <source src="`+videoPath+`" type="video/mp4">
                                您的浏览器不支持视频播放。
                            </video>
                            <span class="text-muted">${fileName}</span>
                        </div>
                    `;
                        $('#videoPreview').html(videoHtml);
                    }

                    // 显示已上传的封面图片
                    if (travelNotes.banImage && travelNotes.banImage.trim()) {
                        const fileName = extractFileName(travelNotes.banImage);
                        const banImagePath = '${pageContext.request.contextPath}/assets/images/travelNotes/' + fileName;
                        const banImageHtml = `
                        <div class="image-preview mb-2">
                            <img src="`+banImagePath+`" class="img-thumbnail" style="max-width: 200px;">
                            <span class="text-muted">${fileName}</span>
                        </div>
                    `;
                        $('#banImagePreview').html(banImageHtml);
                    }

                } else {
                    alert('获取游记详情失败: ' + response.msg);
                    window.location.href = 'user-center-travelnotes.jsp';
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'user-center-travelnotes.jsp';
            }
        });
    }

    // 辅助函数：从路径中提取文件名
    function extractFileName(path) {
        return path.replace(/^.*[\\/]/, '');
    }


    // 单图预览函数
    function previewImage(event, previewId) {
        const preview = document.getElementById(previewId);
        preview.innerHTML = '';

        if (event.target.files && event.target.files[0]) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `
                <div class="image-preview mb-2">
                    <img src="`+e.target.result+`" class="img-thumbnail" style="max-width: 200px;">
                    <span class="text-muted">${file.name}</span>
                </div>
            `;
            };
            reader.readAsDataURL(file);
        }
    }


    // 图片预览函数
    function previewImages(event, previewId) {
        const preview = document.getElementById(previewId);
        const existingImages = $('#existingImages').val() || ''; // 获取现有图片路径
        const existingImageList = existingImages.split(',').filter(img => img.trim() !== ''); // 去除空字符串

        if (event.target.files) {
            Array.from(event.target.files).forEach(file => {
                const reader = new FileReader();
            reader.onload = function(e) {
                const imgPreview = document.createElement('div');
                imgPreview.className = 'image-preview mb-2';
                imgPreview.innerHTML = `
                    <img src="`+e.target.result+`" class="img-thumbnail" style="max-width: 200px;">
                    <span class="text-muted">${file.name}</span>
                `;
                preview.appendChild(imgPreview);

                // 将新上传的图片路径添加到现有图片路径列表中
                const newImagePath = 'assets/images/travelNotes/' + file.name;
                if (!existingImageList.includes(newImagePath)) {
                    existingImageList.push(newImagePath);
                }

                // 更新隐藏字段中的图片路径
                $('#existingImages').val(existingImageList.join(','));
            };
            reader.readAsDataURL(file);
        });
        }
    }

    // 视频预览函数
    function previewVideo(event, previewId) {
        const preview = document.getElementById(previewId);
        preview.innerHTML = '';

        if (event.target.files && event.target.files[0]) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `
                <div class="video-preview mb-2">
                    <video controls style="max-width: 300px;">
                        <source src="`+e.target.result+`" type="video/mp4">
                        您的浏览器不支持视频播放。
                    </video>
                    <span class="text-muted">${file.name}</span>
                </div>
            `;
            };
            reader.readAsDataURL(file);
        }
    }

    // 更新游记
    function updateTravelNotes() {
        const form = document.getElementById('editTravelNotesForm');
        const formData = new FormData(form);

        // 获取现有的图片路径
        const existingImages = $('#existingImages').val();

        // 获取新上传的图片
        const newImages = form.images.files;
        if (newImages.length > 0) {
            for (let i = 0; i < newImages.length; i++) {
                formData.append('newImages', newImages[i]);
                console.log("newImages"+newImages[i])
            }

        }

        // 将现有图片路径和新图片路径一起发送到后端
        if (existingImages) {
            formData.append('existingImages', existingImages);
        }

        // 确保内容字段被正确传递
        const content = $('#travelNotesContent').html();
        formData.append('content', content);
        console.log("content"+content)

        fetch('${pageContext.request.contextPath}/travelNotes/update', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
            if (!response.ok) {
            return response.json().then(err => {
                throw new Error(err.message || '网络请求失败: ' + response.status);
        });
        }
        return response.json();
    })
    .then(data => {
            if (data.code === 200) {
            alert('更新成功');
            window.location.reload(); // 刷新当前页面
            window.location.href = 'user-center-mytravelnotes.jsp';
        } else {
            alert('更新失败：' + (data.message || '未知错误'));
        }
    })
    .catch(error => {
            console.error('Error:', error);
        alert('更新失败: ' + error.message);
    });
    }


</script>
</body>
</html>