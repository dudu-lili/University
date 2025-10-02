<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>红色旅游系统 - 附近景点</title>
<%--   <script src="../../js/jquery-3.6.0.min.js"></script>--%>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <style>
        .distance-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0,0,0,0.7);
            color: white;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 12px;
        }
        .card-img-container {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        .card-img-top {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .card:hover .card-img-top {
            transform: scale(1.05);
        }
        #mapContainer {
            height: 400px;
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
        }
        .sort-option.active {
            color: #dc3545;
            font-weight: bold;
        }
        .location-card {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        body {
            padding-top: 56px;
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
            background-color: transparent; /* 透明背景 */
            border: none; /* 移除边框 */

        }
        .btn-like.active{
            background-color: #dc3545;
            color: white;
        }
        .btn-like .bi-hand-thumbs-up {
            width: 0;
            height: 15px;
        }
        .btn-favorite {
            color: #ffc107;
            background-color: transparent; /* 透明背景 */
            border: none; /* 移除边框 */
        }
        .btn-favorite.active {
            background-color: #ffc107;
            color: white;
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
        .distance-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0,0,0,0.7);
            color: white;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 12px;
        }

        .card-img-container {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        .sort-option.active {
            color: #dc3545;
            font-weight: bold;
        }
        .card-img-top {
            height: 180px;
            object-fit: cover;
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="section-title">附近景点</h3>
        <div class="d-flex align-items-center gap-3">
            <!-- 搜索框 -->
            <div class="input-group input-group-sm" style="max-width: 200px;">
                <input type="text" id="searchInput" class="form-control" placeholder="搜索景点..." aria-label="搜索景点">
                <button class="btn btn-outline-secondary" type="button" id="searchBtn">
                    <i class="bi bi-search"></i>
                </button>
            </div>
            <!-- 刷新位置按钮 -->
            <button id="refreshLocation" class="btn btn-sm btn-outline-danger">
                <i class="bi bi-geo-alt"></i> 刷新位置
            </button>

            <!-- 选择位置按钮 -->
            <button id="selectLocationBtn" class="btn btn-sm btn-outline-primary">
                <i class="bi bi-geo-alt"></i> 选择位置
            </button>

            <!-- 排序方式下拉菜单 -->
            <div class="btn-group">
                <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle"
                        data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-filter"></i> 排序方式
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item sort-option" href="#" data-sort="distance">按距离排序</a></li>
                    <li><a class="dropdown-item sort-option" href="#" data-sort="level">按等级排序</a></li>
                    <li><a class="dropdown-item sort-option" href="#" data-sort="likes">按点赞数排序</a></li>
                </ul>
            </div>
        </div>

    </div>

    <!-- 地图容器 -->
    <div id="mapContainer"></div>

    <div id="addressInfo">
        <p>我的地址：<span id="address"></span></p>
    </div>


    <!-- 附近景点列表容器 -->
    <!-- ... 前面的代码保持不变 ... -->

    <!-- 附近景点列表容器 -->
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
                            <button class="btn btn-sm btn-favorite btn-action" data-scenic-id="${scenic.id}"  onclick="toggleFavorite(${scenic.id}, this)">
                                <i class="bi bi-heart"></i> 收藏
                            </button>
                            <button class="btn btn-sm btn-like btn-action"data-scenic-id="${scenic.id}" onclick="toggleLike(${scenic.id}, this)">
                                <i class="bi bi-hand-thumbs-up"></i>点赞
                                <span class="like-count">${scenic.likeCount}</span>
                            </button>
                            <button class="btn btn-sm btn-primary btn-action" data-id="${scenic.id}" onclick="showCommentBox(this)">
                                <i class="bi bi-chat"></i> 评论
                            </button>
                                <%--                            <button class="btn btn-sm btn-primary btn-action" data-id="${scenic.id}" onclick="showComments(this)">--%>
                                <%--                                <i class="bi bi-chat-left-text"></i> 查看评论--%>
                                <%--                            </button>--%>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


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


<!-- 引入高德地图API -->
<%-- 从 web.xml 获取 AMap Key 和 Security Code --%>
<c:set var="amapKey" value="${initParam['amap.key']}" />
<c:set var="amapSecurityCode" value="${initParam['amap.securityJsCode']}" />

<script type="text/javascript">
    // 动态设置安全配置
    window._AMapSecurityConfig = {
        securityJsCode: '${amapSecurityCode}',
    };
</script>

<script type="text/javascript"
        src="https://webapi.amap.com/maps?v=2.0&key=${amapKey}&plugin=AMap.Geolocation,AMap.ToolBar,AMap.Scale">
</script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="../../js/bootstrap.bundle.min.js"></script>

<script>

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

    $(document).ready(function() {
        // 初始加载完成后立即初始化状态
        initLikeFavoriteStatus();



        let userLat = null;
        let userLng = null;
        let map = null;
        let markers = [];
        let allScenicCards = [];
        let filteredScenicCards = [];
        const pageSize = 8; // 每页显示8条记录
        let currentPage = 1;
        let totalPages = 1;

        // 初始化获取位置
        getLocation();
        // getLocation((lat, lng) => {
        //     loadScenics('level', lat, lng);
        // });

        // 刷新位置按钮点击事件
        $('#refreshLocation').click(function() {
            // getLocation();
            $('#loadingIndicator').removeClass('d-none');
            $('#noDataMessage').addClass('d-none');
            $('#errorMessage').addClass('d-none');

            getLocation((lat, lng) => {
                if (lat && lng) {
                    loadScenics('level', lat, lng);
                } else {
                    $('#errorMessage').removeClass('d-none');
                    $('#errorText').text('无法获取位置信息，请稍后再试。');
                }
                // 隐藏加载指示器
                $('#loadingIndicator').addClass('d-none');
            });
        });
        // 添加位置选择按钮点击事件
        // 在script部分修改位置选择功能
        // 修改位置选择按钮点击事件
        // 在script部分修改位置选择功能
        $('#selectLocationBtn').click(function() {
            // 移除之前的模态框（如果存在）
            $('#locationModal').remove();
            // 创建地图弹窗
            const modal = $(`
        <div class="modal fade" id="locationModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">选择位置</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <!-- 添加搜索框 -->
                        <div class="input-group mb-3">
                            <input type="text" id="locationSearchInput" class="form-control" placeholder="搜索地点...">
                            <button class="btn btn-danger" type="button" id="locationSearchBtn">
                                <i class="bi bi-search"></i> 搜索
                            </button>
                        </div>
                        <div id="selectMapContainer" style="height: 500px; width: 100%;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="confirmLocation">确认选择</button>
                    </div>
                </div>
            </div>
        </div>
    `).appendTo('body');

            // 显示模态框
            const modalInstance = new bootstrap.Modal(modal[0]);
            modalInstance.show();

            let selectMap = null;
            let marker = null;
            let selectedLocation = null;

            // 初始化地图
            modal.on('shown.bs.modal', function() {
                const selectMap = new AMap.Map('selectMapContainer', {
                    zoom: 13,
                    center: userLat && userLng ? [userLng, userLat] : [116.4074, 39.9042]
                });

                // 添加地图控件
                selectMap.addControl(new AMap.ToolBar());
                if (typeof AMap.Scale !== 'undefined') {
                    selectMap.addControl(new AMap.Scale());
                }

                // 添加标记
                let marker = null;
                if(userLat && userLng) {
                    marker = new AMap.Marker({
                        position: [userLng, userLat],
                        map: selectMap
                    });
                }

                // 点击地图选择位置
                let selectedLocation = null;
                selectMap.on('click', function(e) {
                    if(marker) {
                        marker.setPosition([e.lnglat.lng, e.lnglat.lat]);
                    } else {
                        marker = new AMap.Marker({
                            position: [e.lnglat.lng, e.lnglat.lat],
                            map: selectMap
                        });
                    }

                    // 反向地理编码获取地址
                    const geocoder = new AMap.Geocoder();
                    geocoder.getAddress([e.lnglat.lng, e.lnglat.lat], function(status, result) {
                        if (status === 'complete' && result.info === 'OK') {
                            selectedLocation = {
                                lat: e.lnglat.lat,
                                lng: e.lnglat.lng,
                                address: result.regeocode.formattedAddress
                            };
                        }
                    });
                });

                // 搜索按钮点击事件
                $('#locationSearchBtn').click(function() {
                    const keyword = $('#locationSearchInput').val();
                    if (keyword) {
                        AMap.plugin('AMap.PlaceSearch', function() {
                            const placeSearch = new AMap.PlaceSearch({
                                pageSize: 1,
                                pageIndex: 1
                            });

                            placeSearch.search(keyword, function(status, result) {
                                if (status === 'complete' && result.poiList.pois.length > 0) {
                                    const poi = result.poiList.pois[0];
                                    selectMap.setCenter([poi.location.lng, poi.location.lat]);
                                    selectMap.setZoom(15);

                                    // 更新选中位置
                                    if(marker) {
                                        marker.setPosition([poi.location.lng, poi.location.lat]);
                                    } else {
                                        marker = new AMap.Marker({
                                            position: [poi.location.lng, poi.location.lat],
                                            map: selectMap
                                        });
                                    }

                                    selectedLocation = {
                                        lat: poi.location.lat,
                                        lng: poi.location.lng,
                                        address: poi.name
                                    };
                                }
                            });
                        });
                    }
                });

                $('#confirmLocation').click(function() {
                    if (selectedLocation) {
                        userLat = selectedLocation.lat;
                        userLng = selectedLocation.lng;
                        loadScenics('distance', userLat, userLng); // 加载景点列表
                        updateAddress(selectedLocation.address); // 更新地址显示
                        initMap(userLat, userLng); // 更新地图中心点
                    }
                    modalInstance.hide();
                });
            });
            // 确保模态框在隐藏后被销毁
            modal.on('hidden.bs.modal', function() {
                modal.remove();
            });
        });

        // 更新地址显示
        function updateAddress(address) {
            $('#address').text(address);
        }

        $('.sort-option').click(function(e) {
            e.preventDefault();
            const sortBy = $(this).data('sort');

            // 检查是否有用户手动选择的位置
            if (userLat && userLng) {
                loadScenics(sortBy, userLat, userLng);
            } else {
                getLocation((lat, lng) => {
                    if (lat && lng) {
                        loadScenics(sortBy, lat, lng);
                    } else {
                        alert('无法获取位置信息，请稍后再试。');
                    }
                });
            }

            $('.sort-option').removeClass('active');
            $(this).addClass('active');
        });
        // 处理搜索按钮点击事件
        $('#searchBtn').click(function () {
            const keyword = $('#searchInput').val().trim();
            if (!keyword) {
                alert("请输入搜索关键词");
                return;
            }

            // 发送搜索请求
            $.ajax({
                url: '${pageContext.request.contextPath}/scenic/search',
                type: 'GET',
                data: {
                    keyword: keyword
                },
                success: function (response) {
                    if (response.code === 200 && response.data && response.data.length > 0) {
                        filteredScenicCards = response.data;
                        currentPage = 1;
                        updatePagination();
                        showPage(currentPage);
                    } else {
                        alert('未找到相关景点');
                        filteredScenicCards = [];
                        $('#scenicListContainer').empty();
                    }
                },
                error: function () {
                    alert('搜索失败，请稍后再试');
                }
            });
        });
        function loadScenics(sortBy, lat, lng) {
            $.ajax({
                url: '${pageContext.request.contextPath}/scenic/list/sorted',
                type: 'GET',
                data: {
                    sortBy: sortBy,
                    latitude: lat,
                    longitude: lng
                },
                success: function(response) {
                    console.log('加载景点成功:', response);
                    if (response.code === 200) {
                        // renderScenicCards(response.data);
                        filteredScenicCards = response.data; // 更新数据
                        currentPage = 1; // 重置当前页码
                        updatePagination(); // 更新分页信息
                        showPage(currentPage); // 显示第一页数据
                    }
                },
                error: function(xhr) {
                    console.error('加载附近景点失败:', xhr.statusText, xhr.responseText);
                    alert('加载附近景点失败，请稍后再试。');
                }
            });
        }


        // 修改getLocation的调用方式
        getLocation(function(lat, lng) {
            if (lat && lng) {
                loadScenics('level', lat, lng);
            }
        });
        function updatePagination() {
            totalPages = Math.ceil(filteredScenicCards.length / pageSize) || 1;
            $('#totalPages').text(totalPages);
            updatePaginationButtons();
        }

        function updatePaginationButtons() {
            $('#prevPage').toggleClass('disabled', currentPage === 1);
            $('#nextPage').toggleClass('disabled', currentPage === totalPages);
        }

        function renderScenicCard(scenic) {
            // 创建卡片容器
            const cardContainer = $('<div>')
                .addClass('col-md-3 mb-4 scenic-card')
                .attr('data-index', scenic.index)
                .attr('data-province', scenic.province)
                .attr('data-city', scenic.city)
                .attr('data-name', scenic.name);

            // 创建卡片主体
            const card = $('<div>').addClass('card h-100');


            // 创建图片部分
            const imgContainer = $('<div>').addClass('card-img-container position-relative');
            const img = $('<img>')
                .attr('src', `${pageContext.request.contextPath}/`+scenic.coverImage)
                .attr('alt', scenic.name)
                .addClass('card-img-top')
                .css({
                    height: '180px',
                    'object-fit': 'cover',
                    cursor: 'pointer'
                })
                .click(() => viewScenicDetail(scenic.id));

            // 计算距离
            let distanceText = '距离未知';
            if (userLat && userLng && scenic.latitude && scenic.longitude) {
                const distance = calculateDistance(userLat, userLng, scenic.latitude, scenic.longitude);
                distanceText = distance.toFixed(2) + 'km';
            }

            // 创建距离徽章
            const distanceBadge = $('<span>')
                .addClass('distance-badge')
                .text(distanceText);

            imgContainer.append(img, distanceBadge);

            // 创建卡片内容部分
            const cardBody = $('<div>').addClass('card-body');
            cardBody.append(
                $('<h5>').addClass('card-title').text(scenic.name),
                $('<p>').addClass('card-text text-muted').text(scenic.address)
            );

            // 创建按钮区域
            const buttons = $('<div>').addClass('d-flex justify-content-between');
            buttons.append(
                $('<button>')
                    .addClass('btn btn-sm btn-favorite btn-action')
                    .attr('data-scenic-id', scenic.id)//添加4.27
                    // .click(() => toggleFavorite(scenic.id, this))
                    .on('click', function() { toggleFavorite(scenic.id, this); })
                    .append($('<i>').addClass('bi bi-heart'), ' 收藏'),
                $('<button>')
                    .addClass('btn btn-sm btn-like btn-action')
                    .attr('data-scenic-id', scenic.id)//添加4.27
                    // .click(() => toggleLike(scenic.id, this))
                    .on('click', function() { toggleLike(scenic.id, this); })
                    .append($('<i>').addClass('bi bi-hand-thumbs-up'), ' 点赞', $('<span>').addClass('like-count').text(scenic.likeCount)),
                $('<button>')
                    .addClass('btn btn-sm btn-primary btn-action')
                    .attr('data-id', scenic.id)
                    // .click(() => showCommentBox(this))
                    .on('click', function() { showCommentBox(this); })
                    .append($('<i>').addClass('bi bi-chat'), ' 评论'),

            );

            cardBody.append(buttons);

            // 组装卡片
            card.append(imgContainer, cardBody);
            cardContainer.append(card);

            // 将卡片添加到页面
            $('#scenicListContainer').append(cardContainer);
        }
        function showPage(page) {
            // 隐藏所有卡片
            $('#scenicListContainer').empty();

            // 计算开始和结束索引
            const startIndex = (page - 1) * pageSize;
            const endIndex = Math.min(startIndex + pageSize, filteredScenicCards.length);

            // 显示当前页的卡片
            for (let i = startIndex; i < endIndex; i++) {
                const scenic = filteredScenicCards[i];
                renderScenicCard(scenic); // 调用 renderScenicCard 函数
            }

            // 初始化点赞和收藏状态
            initLikeFavoriteStatus();
            // 更新分页信息
            $('#currentPage').text(page);

            // 更新分页按钮状态
            updatePaginationButtons();
        }
        // 新增初始化状态函数
        function initLikeFavoriteStatus() {
            // 初始化点赞状态
            $('.btn-like').each(function() {
                const scenicId = $(this).data('scenic-id');
                const likeButton = $(this);

                $.ajax({
                    url: '${pageContext.request.contextPath}/scenic/status/' + scenicId,
                    type: 'GET',
                    success: function(response) {
                        if (response.code === 200) {
                            const data = response.data;
                            likeButton.find('.like-count').text(data.likeCount);
                            if (data.liked) {
                                likeButton.addClass('active btn-primary').removeClass('btn-outline-primary');
                            } else {
                                likeButton.removeClass('active btn-primary').addClass('btn-outline-primary');
                            }
                        }
                    }
                });
            });

            // 初始化收藏状态
            $('.btn-favorite').each(function() {
                const scenicId = $(this).data('scenic-id');
                const favoriteButton = $(this);

                $.ajax({
                    url: '${pageContext.request.contextPath}/scenic/status/' + scenicId,
                    type: 'GET',
                    success: function(response) {
                        if (response.code === 200) {

                            // const isFavorited = response.data.favorited;
                            const isFavorited = (response.data && response.data.favorited) || false;
                            favoriteButton.toggleClass('active', isFavorited);
                            if(isFavorited) {
                                favoriteButton.addClass('btn-danger').removeClass('btn-outline-danger');
                            } else {
                                favoriteButton.addClass('btn-outline-danger').removeClass('btn-danger');
                            }
                        }
                    }
                });
            });
        }


        // 显示上一页
        $('#prevPage').click(function(e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        });

        // 显示下一页
        $('#nextPage').click(function(e) {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        });

        function getLocation(callback) {
            console.log('开始获取位置...');
            $('#loadingIndicator').removeClass('d-none');
            $('#noDataMessage').addClass('d-none');
            $('#errorMessage').addClass('d-none');

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    position => {
                        const lat = position.coords.latitude;
                        const lng = position.coords.longitude;
                        userLat = lat;
                        userLng = lng;
                        if (typeof callback === 'function') {
                            callback(lat, lng);
                        }
                        updateLocationInfo(position);
                    },
                    error => {
                        console.error("获取位置失败:", error);
                        if (typeof callback === 'function') {
                            callback(null, null);
                        }
                        handleLocationError(error);
                        tryBrowserGeolocation();
                    }
                );
            } else {
                console.error('浏览器不支持定位功能');
                $('#locationInfo').html('<i class="bi bi-exclamation-triangle"></i> 浏览器不支持定位功能');
                tryBrowserGeolocation();
            }
        }


        // 新增浏览器定位备用方案
        function tryBrowserGeolocation() {
            if (navigator.geolocation) {
                $('#locationInfo').html('<i class="bi bi-info-circle"></i> 正在尝试浏览器定位...');

                navigator.geolocation.getCurrentPosition(
                    position => {
                        userLat = position.coords.latitude;
                        userLng = position.coords.longitude;
                        updateLocationInfo(position);
                        loadNearbyScenics(userLat, userLng);
                    },
                    error => {
                        console.error('浏览器定位失败:', error);
                        handleLocationError(error);
                        useDefaultLocation();
                    },
                    {
                        timeout: 8000,
                        enableHighAccuracy: true
                    }
                );
            } else {
                handleLocationError({code: 2, message: '浏览器不支持定位功能'});
                useDefaultLocation();
            }
        }
        function loadSortedScenics(sortBy, lat, lng) {
            $.ajax({
                url: '${pageContext.request.contextPath}/scenic/list/sorted',
                type: 'GET',
                data: {
                    sortBy: sortBy,
                    latitude: lat,
                    longitude: lng
                },
                success: function(response) {
                    console.log('加载景点成功:', response)
                    if(response.code === 200) {
                        renderScenicCards(response.data);
                    }
                }
            });
        }


        // 初始化地图
        function initMap(lat, lng) {
            if (!map) {
                map = new AMap.Map('mapContainer', {
                    zoom: 13,
                    center: [lng, lat],
                    viewMode: '3D'
                });

                // 添加用户位置标记
                new AMap.Marker({
                    position: [lng, lat],
                    map: map,
                    icon: new AMap.Icon({
                        image: 'https://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
                        size: new AMap.Size(20, 30)
                    }),
                    title: '我的位置'
                });
            } else {
                map.setCenter([lng, lat]);
            }
        }

        // 更新地图标记
        function updateMapMarkers(scenics) {
            // 清除现有标记
            markers.forEach(marker => marker.setMap(null));
            markers = [];

            // 添加新标记
            scenics.forEach(scenic => {
                if (scenic.longitude && scenic.latitude) {
                    const marker = new AMap.Marker({
                        position: [scenic.longitude, scenic.latitude],
                        map: map,
                        title: scenic.name,
                        extData: scenic.id
                    });

                    // 点击标记跳转到景点详情
                    marker.on('click', function() {
                        viewScenicDetail(scenic.id);
                    });

                    markers.push(marker);
                }
            });

            // 自动调整地图视野
            if (markers.length > 0) {
                map.setFitView(markers);
            }
        }

        // 更新位置信息显示
        function updateLocationInfo(position) {
            const lat = position.position ? position.position.lat : position.coords.latitude;
            const lng = position.position ? position.position.lng : position.coords.longitude;

            // 使用高德地图API反向地理编码获取地址
            AMap.plugin('AMap.Geocoder', function() {
                const geocoder = new AMap.Geocoder({
                    radius: 1000,
                    extensions: "all"
                });

                geocoder.getAddress([lng, lat], function(status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                        const address = result.regeocode.formattedAddress;
                        const addressElement = document.getElementById('address');
                        addressElement.textContent = address;
                    } else {
                        console.error('反向地理编码失败:', result);
                    }
                });
            });

            // 确保地图已初始化
            if (!map) {
                initMap(lat, lng);
            }
        }

        // 处理位置获取错误
        function renderScenicCards(scenics) {
            $('#scenicListContainer').empty();
            console.log('渲染景点卡片:', scenics)

            scenics.forEach(scenic => {
                // 确保所有字段都有默认值
                const scenicData = {
                    id: scenic.id || 0,
                    name: scenic.name || '未知景点',
                    description: scenic.description || '暂无描述',
                    level: scenic.level || '等级未提供',
                    openningHours: scenic.openningHours || '开放时间未提供',
                    ticketInfo: scenic.ticketInfo || '门票信息未提供',
                    address: scenic.address || '地址未提供',
                    keywords: scenic.keywords || '无关键词',
                    likeCount: scenic.likeCount || 0,
                    latitude: scenic.latitude || null,  // 添加纬度
                    longitude: scenic.longitude || null, // 添加经度
                    distance: userLat && userLng && scenic.latitude && scenic.longitude ?
                        calculateDistance(userLat, userLng, scenic.latitude, scenic.longitude).toFixed(2) + 'km' :
                        '距离未知' // 添加距离信息
                    // distance: scenic.distance ? scenic.distance.toFixed(2) + 'km' : '距离未知' // 添加距离信息
                };
                // console.log('渲染景点卡片:', scenicData)

                // 创建卡片元素
                const card = $('<div>').addClass('col-md-4 mb-4');
                const cardInner = $('<div>').addClass('card h-100');

                // 图片部分
                const imageUrl = `${pageContext.request.contextPath}/${scenic.coverImage}`;
                // console.log('图片URL:', imageUrl);
                // console.log('图片URL1:', scenicData.id);
                const imgContainer = $('<div>').addClass('card-img-container position-relative');
                const img = $('<img>')
                    .addClass('card-img-top')
                    .attr('alt', scenicData.name)
                    .css({
                        'height': '180px',
                        'object-fit': 'cover'
                    })
                    .attr('src', `${pageContext.request.contextPath}/`+scenic.coverImage)
                    .click(() => viewScenicDetail(scenicData.id));
                //距离徽章
                const distanceBadge = $('<span>')
                    .addClass('distance-badge')
                    .text(scenicData.distance);
                imgContainer.append(img, distanceBadge);
                // 卡片内容
                const cardBody = $('<div>').addClass('card-body');

                // 标题
                cardBody.append($('<h5>').addClass('card-title').text(scenicData.name));

                // 描述
                // cardBody.append(
                //     $('<div>').addClass('card-text text-muted mb-2')
                //         .append($('<small>').text(scenicData.description))
                // );

                // 信息徽章
                const badges = $('<div>').addClass('d-flex flex-wrap mb-2');
                badges.append(
                    $('<span>').addClass('badge bg-primary me-2 mb-1')
                        .append($('<i>').addClass('bi bi-star-fill'))
                        .append(' ' + scenicData.level),
                    $('<span>').addClass('badge bg-success me-2 mb-1')
                        .append($('<i>').addClass('bi bi-clock'))
                        .append(' ' + scenicData.openningHours),
                    $('<span>').addClass('badge bg-info me-2 mb-1')
                        .append($('<i>').addClass('bi bi-ticket-perforated'))
                        .append(' ' + scenicData.ticketInfo)
                );
                cardBody.append(badges);

                // 地址
                cardBody.append(
                    $('<div>').addClass('card-text text-muted mb-2')
                        .append($('<small>')
                            .append($('<i>').addClass('bi bi-geo-alt'))
                            .append(' ' + scenicData.address))
                );

                // 关键词
                cardBody.append(
                    $('<div>').addClass('card-text text-muted mb-3')
                        .append($('<small>')
                            .append($('<i>').addClass('bi bi-tags'))
                            .append(' ' + scenicData.keywords))
                );

                // 按钮区域
                // const buttons = $('<div>').addClass('d-flex justify-content-between align-items-center');
                // buttons.append(
                //     $('<button>').addClass('btn btn-sm btn-outline-danger')
                //         .append($('<i>').addClass('bi bi-heart'))
                //         .append(' 收藏')
                //         .click(() => toggleFavorite(scenicData.id, this)),
                //     $('<button>').addClass('btn btn-sm btn-outline-primary')
                //         .append($('<i>').addClass('bi bi-hand-thumbs-up'))
                //         .append(' 点赞')
                //         .append($('<span>').addClass('badge bg-danger ms-1').text(scenicData.likeCount))
                //         .click(() => toggleLike(scenicData.id, this))
                // );
                const buttons = $('<div>').addClass('d-flex justify-content-between');
                buttons.append(
                    $('<button>')
                        .addClass('btn btn-sm btn-outline-danger btn-favorite btn-action')
                        .attr('data-scenic-id', scenic.id)
                        // .click(function() { toggleFavorite(scenic.id, this); })
                        .on('click', function() { toggleFavorite(scenic.id, this); })
                        .append($('<i>').addClass('bi bi-heart'), ' 收藏'),
                    $('<button>')
                        .addClass('btn btn-sm btn-outline-primary btn-like btn-action')
                        .attr('data-scenic-id', scenic.id)
                        // .click(function() { toggleLike(scenic.id, this); })
                        .on('click', function() { toggleLike(scenic.id, this); })
                        .append($('<i>').addClass('bi bi-hand-thumbs-up'), ' 点赞',
                            $('<span>').addClass('like-count').text(scenic.likeCount || 0)),
                    $('<button>')
                        .addClass('btn btn-sm btn-primary btn-action')
                        .attr('data-id', scenic.id)
                        // .click(function() { showCommentBox(this); })
                        .on('click', function() { showCommentBox(this); })
                        .append($('<i>').addClass('bi bi-chat'), ' 评论')
                );

                cardBody.append(buttons);

                // 组装卡片
                cardInner.append(imgContainer, cardBody);
                card.append(cardInner);
                $('#scenicListContainer').append(card);


            });
        }
    });
    function calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 6371; // 地球半径，单位为公里
        const dLat = toRadians(lat2 - lat1);
        const dLon = toRadians(lon2 - lon1);
        const a =
            Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // 返回距离，单位为公里
    }

    function toRadians(degrees) {
        return degrees * (Math.PI / 180);
    }



    // 在地图上查看
    function showOnMap(lat, lng) {
        const url = `https://uri.amap.com/marker?position=${lng},${lat}`;
        window.open(url, '_blank');
    }

    // 查看景点详情
    function viewScenicDetail(scenicId) {
        window.location.href = 'scenic-detail.jsp?id=' + scenicId;
    }

    // 点赞景点
    function toggleLike(scenicId, element) {
        const likeButton = $(element);//4.27
        // 添加加载状态
        likeButton.prop('disabled', true);
        // 从数据属性获取当前点赞状态
        //     const isLiked = likeButton.data('liked') === 'true';
        const isLiked = likeButton.hasClass('active'); // 判断当前是否已点赞
        const url = isLiked ? '${pageContext.request.contextPath}/scenic/unlike' : '${pageContext.request.contextPath}/scenic/like';


        $.ajax({
            <%--url: '${pageContext.request.contextPath}/scenic/like',--%>
            <%--url: isLiked ? '${pageContext.request.contextPath}/scenic/unlike' : '${pageContext.request.contextPath}/scenic/like',--%>
            url:url,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({scenicId: scenicId}),
            success: function(response) {
                if (response.code === 200) {
                    // const likeCount = response.data.likeCount;
                    const data = response.data;

                    // $(element).find('.like-count').text(response.data.likeCount);
                    // $(element).find('.badge').text(likeCount);
                    // const likeButton = $(element);
                    // 更新点赞数
                    likeButton.find('.like-count').text(data.likeCount);
                    // 更新按钮状态
                    if (data.liked) {
                        likeButton.addClass('active');
                    } else {
                        likeButton.removeClass('active');
                    }
                    // likeButton.toggleClass('btn-primary', data.liked);
                    // likeButton.toggleClass('btn-outline-primary', !data.liked);

                    // 更新所有卡片中相同景点的点赞状态
                    $(`.btn-like[data-scenic-id="${scenicId}"]`).each(function() {

                        $(this).find('.like-count').text(data.likeCount);
                        if (data.liked) {
                            $(this).addClass('active');
                        } else {
                            $(this).removeClass('active');
                        }
                        // $(this).toggleClass('btn-primary', data.liked);
                        // $(this).toggleClass('btn-outline-primary', !data.liked);
                    });


                     } else {
                    alert(response.message || '操作失败');
                    // 若失败，恢复原有状态（避免按钮状态错乱）
                    if (isLiked) {
                        likeButton.addClass('btn-primary');
                    } else {
                        likeButton.addClass('btn-outline-primary');
                    }
                }
            },
            error: function() {
                alert('请求失败，请检查网络');
                // 恢复原有状态
                if (isLiked) {
                    likeButton.addClass('btn-primary');
                } else {
                    likeButton.addClass('btn-outline-primary');
                }
            }
        }).always(() => {
            // 无论成功或失败，都要移除加载状态
            likeButton.prop('disabled', false);
        });
    }
    function toggleFavorite(scenicId, element) {
        const favoriteButton = $(element);
        // 添加加载状态
        favoriteButton.prop('disabled', true);
        const isFavorited = favoriteButton.hasClass('active'); // 判断当前是否已收藏
        const url = isFavorited ? '${pageContext.request.contextPath}/scenic/unfavorite' : '${pageContext.request.contextPath}/scenic/favorite';

        $.ajax({
            url: url,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({scenicId: scenicId}),
            success: function(response) {
                if (response.code === 200) {
                    // 确保有 data 字段，如果没有则假设操作成功
                    const favorited = (response.data && response.data.favorited !== undefined) ?
                        response.data.favorited : !isFavorited;

                    // 更新当前按钮状态
                    favoriteButton.toggleClass('active', favorited);
                    favoriteButton.toggleClass('btn-danger', favorited);
                    favoriteButton.toggleClass('btn-outline-danger', !favorited);

                    // 更新所有卡片中相同景点的收藏状态
                    $(`.btn-favorite[data-scenic-id="${scenicId}"]`).each(function() {
                        $(this).toggleClass('active', favorited);
                        $(this).toggleClass('btn-danger', favorited);
                        $(this).toggleClass('btn-outline-danger', !favorited);
                    });

                    alert(response.message || (favorited ? '收藏成功' : '已取消收藏'));
                } else {
                    alert(response.message || '操作失败');
                    // 恢复原有状态
                    favoriteButton.toggleClass('active', isFavorited);
                    favoriteButton.toggleClass('btn-danger', isFavorited);
                    favoriteButton.toggleClass('btn-outline-danger', !isFavorited);
                }
            },
            error: function() {
                alert('请求失败，请检查网络');
                // 恢复原有状态
                favoriteButton.toggleClass('active', isFavorited);
                favoriteButton.toggleClass('btn-danger', isFavorited);
                favoriteButton.toggleClass('btn-outline-danger', !isFavorited);
            }
        }).always(() => {
            // 无论成功或失败，都要移除加载状态
            favoriteButton.prop('disabled', false);
        });
    }

    // 显示评论框
    function showCommentBox(button) {
        const scenicId = $(button).data('id');

        // 移除之前可能存在的模态框
        $('#commentModal').remove();

        // 创建评论模态框
        const modal = $(`
        <div class="modal fade" id="commentModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">发表评论</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <textarea class="form-control" id="commentContent" rows="3" placeholder=""></textarea>
                        </div>
                        <div id="commentError" class="text-danger mb-2" style="display: none;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="submitComment">提交</button>
                    </div>
                </div>
            </div>
        </div>
    `).appendTo('body');

        // 显示模态框
        const modalInstance = new bootstrap.Modal(modal[0]);
        modalInstance.show();

        // 提交评论按钮点击事件
        $('#submitComment').click(function() {
            const content = $('#commentContent').val().trim();

            if (!content) {
                $('#commentError').text('评论内容不能为空').show();
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
                        modalInstance.hide();
                        alert('评论发表成功');
                    } else {
                        $('#commentError').text(response.message || '评论发表失败').show();
                    }
                },
                error: function() {
                    $('#commentError').text('请求失败，请检查网络').show();
                }
            });
        });

        // 模态框关闭时移除
        modal.on('hidden.bs.modal', function() {
            modal.remove();
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
    // 新增：监听浏览器后退/前进事件并刷新页面
    window.addEventListener('popstate', function() {
        location.reload(true);
    });
    // 监听页面从缓存加载
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            location.reload(true);
        }
    });

</script>
</body>
</html>