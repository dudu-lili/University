<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>红色旅游地图</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/echarts@4.6.0/dist/echarts.min.js"></script>
    <!-- 再加载地图数据（使用官方CDN的china.js） -->
    <script src="https://unpkg.com/echarts@4.6.0/map/js/china.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        .map-container {
            width: calc(100vw - 330px); /* 调整宽度，只留出右侧侧边栏宽度，假设侧边栏宽度为280px，再加上20px边距 */
            margin: 20px 20px 20px 0; /* 调整外边距，左侧不留边，上下和右侧有边距 */
            min-width: 600px;
            height: calc(100vh - 156px); /* 调整高度，考虑导航栏和页脚高度 */
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            background: white;
        }

        .side-panel {
            position: fixed;
            right: 20px;
            top: 80px;
            width: 280px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 15px;
            max-height: 80vh;
            overflow-y: auto;
        }

        .province-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 12px;
            margin: 5px 0;
            background: #fff5f5;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .province-item:hover {
            transform: translateX(5px);
            box-shadow: 0 2px 6px rgba(220,53,69,0.2);
        }

        .province-name {
            color: #B3100f;
            font-weight: 500;
        }

        .province-count {
            background: #B3100f;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.9em;
        }

        .navbar {
            background-color: #90201f;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 0px;

        }
        .navbar-brand,.nav-link {
            color: white!important;
            font-weight: bold;
        }

        .nav-link:hover {
            color: #ffc107!important;
        }

        .carousel-item img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }

        /* 确保 tooltip 不被外部样式限制 */
        .echarts-tooltip {
            max-width: 400px!important;
            white-space: pre-wrap!important;
            display: block!important;
            opacity: 1!important;
            z-index: 9999!important;
            background-color: rgba(255, 255, 255, 0.9)!important; /* 背景颜色 */
            border: 1px solid #B3100f!important; /* 边框颜色 */
            border-radius: 5px!important; /* 边框圆角 */
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2)!important; /* 阴影 */
            padding: 10px!important; /* 内边距 */
            font-size: 14px!important; /* 字体大小 */
            color: #333!important; /* 字体颜色 */
        }
        /* 鼠标悬停到红色标记上的样式 */
        .echarts-layer-echarts-tooltip + .echarts-layer canvas {
            cursor: pointer;
        }

        /* 滑块样式 */
        .slider-container {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.8);
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
            color: #dc3545;
        }
        .slider-container label {
            color: #dc3545;
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

<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <!-- 将文字替换为Logo图片 -->
        <a class="navbar-brand" href="index.jsp">
            <img src="../../assets/images/banners/logo2.png" alt="红色旅游" height="56">
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
                    <a class="nav-link active" href="red-Geocoding.jsp">地图展示</a>
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

<div class="container-fluid position-relative">
    <!-- 侧边统计面板 -->
    <div class="side-panel">
        <h4 class="mb-3 text-danger"><i class="bi bi-bar-chart-fill"></i> 省份统计</h4>
        <!-- 这里后续通过JavaScript动态插入内容 -->
        <div id="province-counts"></div>
    </div>

    <!-- 添加滑块容器 -->
    <div class= "slider-container">
        <label for="pointSize">所显示点的大小:</label>
        <input type="range" id="pointSize" min="1" max="50" value="5" style="width: 200px;">
        <span id="pointSizeValue">5</span>
    </div>

    <!-- 地图容器 -->
    <div id="map" class="map-container"></div>
</div>

<!-- 页脚（与首页一致） -->
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = "${pageContext.request.contextPath}";
    $(document).ready(function() {
        // 发起AJAX请求获取数据
        $.ajax({
            url:'/RedTourismSystem/guest/red-geocoding-info',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                var points = response.data.points;
                var counts = response.data.counts;
                console.log("✅ 成功获取景点数据，共", points.length, "条");
                if (points.length > 0) {
                    console.log("📦 景点数据结构示例:", points[0]);
                }
                // 渲染省份统计数据
                var provinceCountsDiv = $('#province-counts');
                counts.forEach(function(count) {
                    var provinceItem = $('<div>').addClass('province-item');
                    var provinceName = $('<span>').addClass('province-name').text(count.province);
                    var provinceCount = $('<span>').addClass('province-count').text(count.count + '处');
                    provinceItem.append(provinceName).append(provinceCount);
                    provinceCountsDiv.append(provinceItem);
                });

                // 初始化地图
                const mapChart = echarts.init(document.getElementById('map'));

                // 转换数据格式
                const mapPoints = points.map(function(point) {
                    return {
                        name: point.name,
                        value: [point.lng, point.lat],
                        province: point.province,
                        address: point.address
                    };
                });

                // 检查数据是否正确传递
                console.log('Points data:', mapPoints);

                // 地图配置
                const option = {
                    backgroundColor: '#F7F9FC',
                    title: {
                        text: '红色旅游景点分布图',
                        subtext: '数据来源：红色旅游系统',
                        left: 'center',
                        textStyle: {
                            color: '#dc3545',
                            fontSize: 22
                        }
                    },
                    tooltip: {
                        trigger: 'item',
                        show: true,
                        formatter: function (params) {
                            const data = params.data;
                            console.log('data.name:', data.name); // 检查景点名称
                            console.log('data.province:', data.province); // 检查省份
                            console.log('data.address:', data.address); // 检查地址
                            console.log('data.value:', data.value); // 新增，检查坐标值
                            if (data) {
                                return (
                                    '景点：' + data.name + '<br/>' +
                                    '省份：' + data.province + '<br/>' +
                                    '地址：' + data.address + '<br/>' +
                                    '坐标：' + data.value[0] + ',' + data.value[1]
                                );
                            } else {
                                return '数据缺失';
                            }
                        },
                        // 添加额外配置
                        enterable: true, // 允许鼠标进入 tooltip
                        alwaysShowContent: false, // 不总是显示内容
                        confine: true // 限制 tooltip 在图表区域内
                    },
                    geo: {
                        type:'map', // 明确指定地图类型
                        map: 'china',
                        roam: true,
                        // 添加地图边界配置
                        regions: [{
                            name: '中国',
                            itemStyle: {
                                borderColor: '#dc3545',
                                borderWidth: 1
                            }
                        }],
                        label: {
                            normal: {
                                show: true,
                                // 新增：标签字体优化（更大、更清晰）
                                textStyle: {
                                    color: '#666', // 深灰色标签
                                    fontSize: 12, // 字体大小从 10 改为 12
                                    fontWeight: '400' // 普通字体粗细
                                }
                            },
                            emphasis: { show: false }
                        },
                        itemStyle: {
                            normal: {
                                // 地图区域渐变色（提升立体感）
                                areaColor: {
                                    type: 'linear',
                                    x: 0,
                                    y: 0,
                                    x2: 1,
                                    y2: 1,
                                    colorStops: [{
                                        offset: 0, color: '#e9f5ff' // 左上浅蓝
                                    }, {
                                        offset: 1, color: '#f8f9fa' // 右下浅灰
                                    }],
                                    global: false
                                },
                                borderColor: '#dc3545', // 省份边界颜色（红色）
                                borderWidth: 1.2 // 边界宽度（更清晰）
                            },
                            emphasis: {
                                areaColor: '#ffe7e7', // 悬停时浅红色高亮
                                borderWidth: 1.5
                            }
                        },
                        // 添加中国地图中心点偏移（视角更居中）
                        center: [105, 36], // 中心点坐标（经度，纬度）
                        zoom: 1.2 // 初始缩放级别（1.0 为默认）
                    },
                    series: [{
                        type:'scatter',
                        coordinateSystem: 'geo',
                        symbol: 'path://M12,20 L12,20 12,20 C17.5228466,20 22,15.5228466 22,10 C22,4.47715342 17.5228466,0 12,0 C6.47715338,0 2,4.47715342 2,10 C2,15.5228466 6.47715338,20 12,20 Z M12,22 C16.418278,22 20,18.418278 20,14 C20,9.581722 16.418278,6 12,6 C7.581722,6 4,9.581722 4,14 C4,18.418278 7.581722,22 12,22 Z',
                        symbolSize: 5, // 图标大小（原 [30,40] 改为统一尺寸）
                        // 悬停时放大效果
                        emphasis: {
                            scale: 1.2, // 放大 1.2 倍
                            itemStyle: {
                                shadowBlur: 10, // 悬停阴影
                                shadowColor: 'rgba(220, 53, 69, 0.5)'
                            }
                        },
                        itemStyle: {
                            color: '#dc3545', // 主色（红色）
                            shadowBlur: 5, // 基础阴影
                            shadowColor: 'rgba(220, 53, 69, 0.3)'
                        },
                        data: mapPoints,
                        encode: {
                            lng: 0,  // 经度使用第0个元素
                            lat: 1   // 纬度使用第1个元素
                        },
                        showEffectOn:'render',
                        rippleEffect: {
                            brushType:'stroke'
                        },
                        hoverAnimation: true
                    }]
                };

                // 使用配置项显示地图
                mapChart.setOption(option);

                // 窗口大小变化时自适应
                window.addEventListener('resize', () => {
                    mapChart.resize();
            });

                // 添加滑块事件监听器
                document.getElementById('pointSize').addEventListener('input', function() {
                    const newSize = parseInt(this.value);
                    document.getElementById('pointSizeValue').textContent = newSize;

                    // 更新 series 中的 symbolSize
                    option.series[0].symbolSize = newSize;
                    mapChart.setOption(option);
                });
            },
            error: function(error) {
                console.error('请求数据失败:', error);
            }
        });
    });

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