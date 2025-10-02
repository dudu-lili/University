<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>红色旅游系统 - 写游记</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.1/dist/echarts.min.js"></script>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>

        .img-card img {
            width: 100%; /* 图片宽度占满容器 */
            height: 100%; /* 图片高度占满容器 */
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            position: relative;
        }
        .header img {
            margin-top:10px;
            border-radius: 10px;
            width: 500px;
            height: 400px;
            border: 1px solid #ccc;
        }
        .header h4 {
            margin: 0;
        }
        .header .upload-btn {
            background-color: #ffc107;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 10px 20px; /* 调整按钮的内边距，使按钮变大 */
            color: white;
            font-size: 18px; /* 调整按钮文字大小 */
            transition: all 0.3s ease;
            margin-right: 50px; /* 向左移动按钮 */
            margin-left:-20px;
            position: relative; /* 相对定位 */
        }
        .header .upload-btn:hover {
            background-color: #e0a800;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea {
            width: 1296px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group textarea {
            height: 300px;
            resize: vertical;
        }
        .form-actions {
            display: flex;
            justify-content: center; /* 居中对齐 */
            align-items: center;
            margin-top: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 10px; /* 添加按钮之间的间距 */
        }
        .form-actions .preview-btn {
            background-color: #f8f9fa;
        }
        .form-actions .submit-btn {
            background-color: #dc3545;
            color: white;
        }
        .form-actions .submit-btn:hover {
            background-color: #b71c1c;
        }
        .form-cont {
            display: flex;
            margin-bottom: 20px;
        }
        .form-cont .form-group {
            flex: 1;
            margin-right: 20px;
        }
        .form-cont .form-group:last-child {
            margin-right: 0;
        }
        .sidebar {
            width: 200px;
            height:120px;
            padding: 10px;
            margin-top:30px;
            border: 1px solid #ccc;
            border-radius: 5px;

        }
        .sidebar button {
            background-color: #dc3545;
            color: #fff;
            transition: all 0.3s;
            display: block;
            width: 180px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        .form-group button{
            background-color: #dc3545;
            color: #fff;
            transition: all 0.3s;
            display: block;
            width: 180px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top:-40px;
            margin-left:1100px;
        }
        .sidebar button:hover {
            background-color: #c82333;
            color: #fff;
            transform: translateY(-2px);
        }
        .form-group button:hover{
            background-color: #c82333;
            color: #fff;
            transform: translateY(-2px);
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
        #content {
            border: 1px solid #ccc;
            padding: 10px;
            min-height: 300px;
            overflow: auto;
        }
        #titleInputContainer {
            display: none;
            margin-top: 10px;
        }
        #titleInput {
            margin-bottom: 10px;
        }
        .form-actions {

            display: flex;
            justify-content: space-between;
        }
        .form-actions button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 180px;
            height:50px;
        }
        .form-actions .btn-primary {
            background-color: #dc3545;
            color: white;
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
        .video-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 10px;
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

<div class="container mt-4" id="submitTravelNote">
    <!-- 写游记-->
    <div class="header">
        <img id="previewImage" src="../../assets/images/banners/bj11.png" alt="头图" style=" max-width: 100%; height: auto; margin-bottom: 10px;">
        <h4>设置游记头图</h4>
        <label for="banImage" class="upload-btn">上传头图</label>
        <input type="file" id="banImage" accept="image/*" style="display: none;">
    </div>
    <div class="form-group">
        <label for="place">填写地点</label>
        <input type="text" id="place" class="form-control">
    </div>
    <div class="form-group">
        <label for="title">填写游记标题</label>
        <input type="text" id="title" class="form-control">
    </div>
    <div class="form-cont">
        <div class="form-group">
            <label for="content">从这里开始游记正文...</label>
            <div id="content" class="form-control" contenteditable="true" style="min-height: 300px;width:1050px;"></div>
        </div>
        <div class="sidebar">
            <button class="bi bi-emoji-smile" id="insertEmojiBtn"> 插入表情</button>
            <button class="bi bi-bar-chart-steps" id="insertTitleBtn"> 插入标题</button>
            <div id="titleInputContainer" style="display: none; margin-top: 10px;">
                <input type="text" id="titleInput" placeholder="请输入标题内容" class="form-control">
                <div class="form-actions">
                    <button id="confirmTitleBtn" class="btn btn-primary">确认</button>
                    <button id="cancelTitleBtn" class="btn btn-secondary">取消</button>
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
                    <span class="emoji" data-emoji="🌟">🌟</span>
                    <span class="emoji" data-emoji="💯">💯</span>
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

                    <!-- 建筑相关表情 -->
                    <span class="emoji" data-emoji="🏛️">🏛️</span> <!-- 古典建筑，可代表博物馆等 -->
                    <span class="emoji" data-emoji="🏢">🏢</span> <!-- 办公楼 -->
                    <span class="emoji" data-emoji="🏬">🏬</span> <!-- 购物中心 -->
                    <span class="emoji" data-emoji="🏫">🏫</span> <!-- 学校 -->
                    <span class="emoji" data-emoji="🏨">🏨</span> <!-- 酒店 -->
                    <span class="emoji" data-emoji="🗼">🗼</span> <!-- 东京塔，可代表地标建筑 -->
                    <span class="emoji" data-emoji="🗽">🗽</span> <!-- 自由女神像，可代表地标建筑 -->
                    <span class="emoji" data-emoji="🏰">🏰</span> <!-- 城堡 -->
                    <span class="emoji" data-emoji="🏘️">🏘️</span> <!-- 住宅小区 -->
                    <span class="emoji" data-emoji="🌁">🌁</span> <!-- 城市天际线 -->
                    <span class="emoji" data-emoji="🏭">🏭</span> <!-- 工厂 -->
                    <span class="emoji" data-emoji="🚢">🚢</span> <!-- 船，可代表港口相关建筑 -->
                    <span class="emoji" data-emoji="🛳️">🛳️</span> <!-- 大型轮船，可代表港口相关建筑 -->
                    <span class="emoji" data-emoji="🚁">🚁</span> <!-- 直升机，可代表机场相关建筑 -->
                    <span class="emoji" data-emoji="🛫">🛫</span> <!-- 飞机起飞，可代表机场相关建筑 -->
                    <span class="emoji" data-emoji="🛬">🛬</span> <!-- 飞机降落，可代表机场相关建筑 -->
                    <span class="emoji" data-emoji="🕌">🕌</span> <!-- 清真寺 -->
                    <span class="emoji" data-emoji="⛪">⛪</span> <!-- 教堂 -->
                    <span class="emoji" data-emoji="🛕">🛕</span> <!-- 印度教寺庙 -->

                    <!-- 闹钟及相关 -->
                    <span class="emoji" data-emoji="⏰">⏰</span> <!-- 闹钟 -->
                    <span class="emoji" data-emoji="🕙">🕙</span> <!-- 一点钟 -->
                    <span class="emoji" data-emoji="🕚">🕚</span> <!-- 两点钟 -->
                    <span class="emoji" data-emoji="🕛">🕛</span> <!-- 十二点钟 -->
                    <span class="emoji" data-emoji="⏱️">⏱️</span> <!-- 秒表 -->
                    <span class="emoji" data-emoji="⌚">⌚</span> <!-- 手表 -->
                    <span class="emoji" data-emoji="⌛">⌛</span> <!-- 沙漏 -->

                    <!-- 石头 -->
                    <span class="emoji" data-emoji="🪨">🪨</span> <!-- 石头 -->


                    <span class="emoji" data-emoji="🚄">🚄</span> <!-- 高铁 -->
                    <span class="emoji" data-emoji="🚉">🚉</span> <!-- 高铁 -->

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
    </div>
    <div class="form-cont" style="width:1000px;">
        <div class="form-group">
            <label for="images">从这里开始游记图片...<button class="bi bi-file-image" id="insertImageBtn"> 插入图片</button></label>
            <div id="images" class="form-control" contenteditable="true" style="min-height: 300px;"></div>
        </div>
    </div>

    <div class="form-cont"  style="width:1000px;">
        <div class="form-group">
            <label for="viedo">从这里开始游记视频...<button class="bi bi-camera-video" id="insertVideoBtn"> 插入视频</button></label>
            <div id="viedo" class="form-control" contenteditable="true" style="min-height: 300px;"></div>
        </div>
    </div>

    <div class="form-actions" style="margin-left:550px;">
        <button class="submit-btn">发表游记</button>
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
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 声明全局变量保存所有图片文件
    let allImages = [];

    $(document).ready(function() {
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
            const currentContent = $('#content').html(); // 获取当前内容
            $('#content').html(currentContent + emoji); // 将表情符号追加到内容末尾

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


    $(document).ready(function() {
        // 绑定插入标题按钮的点击事件
        $('#insertTitleBtn').click(function() {
            $('#titleInputContainer').show(); // 显示输入框和按钮
            $('#titleInput').focus(); // 聚焦到输入框
        });

        // 绑定确认按钮的点击事件
        $('#confirmTitleBtn').click(function() {
            const titleText = $('#titleInput').val(); // 获取输入框中的内容
            if (titleText) {
                const content = $('#content').html(); // 获取当前内容
                // 插入标题并换行
                $('#content').html(content + '<h4>' + titleText + '</h4><br>');
                $('#titleInput').val(''); // 清空输入框
                $('#titleInputContainer').hide(); // 隐藏输入框和按钮
            }
        });

        // 绑定取消按钮的点击事件
        $('#cancelTitleBtn').click(function() {
            $('#titleInput').val(''); // 清空输入框
            $('#titleInputContainer').hide(); // 隐藏输入框和按钮
        });

        // 绑定插入图片按钮的点击事件
        $('#insertImageBtn').click(function() {
            $('#imageFileInput').click(); // 触发隐藏的文件选择框
        });

        // 绑定插入视频按钮的点击事件
        $('#insertVideoBtn').click(function() {
            $('#videoFileInput').click(); // 触发隐藏的文件选择框
        });


// 图片选择框的 change 事件
        $('#imageFileInput').on('change', function(event) {
            const files = event.target.files;
            if (files.length > 0) {
                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    if (file) {
                        allImages.push(file);
                    }
                }
                // 更新 #images 的内容
                let newContent = $('#images').html();
                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const imageUrl = e.target.result;
                        const imageDiv = '<div style="display: flex; flex-direction: column; align-items: center; margin-bottom: 10px;">' +
                            '<img src="' + imageUrl + '" alt="图片" style="max-width: 600px; height: 300px;">' +
                            '</div>';
                        newContent += imageDiv;
                        if (i === files.length - 1) {
                            $('#images').html(newContent);
                        }
                    };
                    reader.readAsDataURL(file);
                }
            }
        });


        // 监听视频文件选择框的变化
        $('#videoFileInput').on('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const videoUrl = e.target.result; // 获取 Base64 视频数据
                    const content = $('#viedo').html(); // 获取当前内容
                    // 将视频追加到现有内容中，不覆盖
                    $('#viedo').html(content + '<div class="video-container">' +
                        '<video src="' + videoUrl + '" controls  style="max-width: 600px; height: 300px;"></video>' +
                        '</div>');
                    // 调整光标位置到视频后面
                    const range = document.createRange();
                    const videoElement = document.querySelector('video:last-child'); // 获取最后一个视频元素
                    range.setStartAfter(videoElement); // 将光标设置到视频后面
                    const selection = window.getSelection();
                    selection.removeAllRanges();
                    selection.addRange(range);
                };
                reader.readAsDataURL(file);
            }
        });

        // 监听删除操作
        $('#content').on('keydown', function(e) {
            if (e.key === 'Backspace' || e.key === 'Delete') {
                const selection = window.getSelection();
                const range = selection.rangeCount > 0 ? selection.getRangeAt(0) : document.createRange();
                const startContainer = range.startContainer;

                // 如果光标在图片或视频前面，删除图片或视频
                if (startContainer.nodeType === Node.ELEMENT_NODE && startContainer.tagName === 'IMG') {
                    startContainer.remove();
                    e.preventDefault();
                } else if (startContainer.nodeType === Node.ELEMENT_NODE && startContainer.tagName === 'VIDEO') {
                    startContainer.remove();
                    e.preventDefault();

                    // 修复光标位置
                    const newRange = document.createRange();
                    newRange.setStart(startContainer.parentNode, 0);
                    selection.removeAllRanges();
                    selection.addRange(newRange);
                }
            }
        });
    });

    $(document).ready(function() {
        // 绑定点击事件到按钮
        $('#uploadBtn').click(function() {
            $('#banImage').click(); // 触发隐藏的文件选择框
        });

        // 监听文件选择框的变化
        $('#banImage').on('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#previewImage').attr('src', e.target.result); // 更新图片预览
                    $('#previewImage').show(); // 显示图片预览框
                };
                reader.readAsDataURL(file);
            }
        });
    });



    // 提交游记
    function submitTravelNote() {
        var title = $('#title').val();
        var place = $('#place').val();
        var content = $('#content').html();
        var banImage = $('#banImage')[0].files[0];
        var video = $('#videoFileInput')[0].files[0];
        var userId = $('#userId').val();

        var formData = new FormData();
        formData.append('title', title);
        formData.append('place', place);
        formData.append('content', content);
        formData.append('userId', userId);
        if (banImage) {
            formData.append('banImage', banImage);
        }
        if (allImages.length > 0) {
            for (let i = 0; i < allImages.length; i++) {
                if (allImages[i] instanceof File) {
                    formData.append('images', allImages[i]);
                }
            }
        }
        if (video) {
            formData.append('video', video);
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/travelNotes/add',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                alert('提交成功！');
                fetchTravelNotesList(); // 动态更新游记列表
                fetchMyTravelNotes();
                window.location.href = 'travelnotes-list.jsp';
            },
            error: function(xhr, status, error) {
                alert('提交失败: ' + xhr.responseText);
            }
        });
    }




    $(document).ready(function() {
        $('.submit-btn').click(function(e) {
            e.preventDefault();
            submitTravelNote();
        });
    });

    $(document).ready(function() {
        $('#banImage').on('change', function() {
            var reader = new FileReader();
            var file = this.files[0];
            if (file) {
                reader.onload = function(e) {
                    $('#previewImage').attr('src', e.target.result);
                    $('#previewImage').show();
                };
                reader.readAsDataURL(file);
            }
        });

    });
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



</script>
</body>
</html>