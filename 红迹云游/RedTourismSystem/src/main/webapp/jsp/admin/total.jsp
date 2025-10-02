<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>数据统计 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://unpkg.com/echarts@4.6.0/dist/echarts.min.js"></script>

    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }
        .bg-dark1{
            background-color: #c6303e;
            height: 80px;
        }
        .navbar-custom {
            background-color: #f9534f !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            color: white !important; /* 白色文字 */
        }
        /* 确保导航链接文字也是白色 */
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: white !important;
        }

        /* 鼠标悬停效果 */
        .navbar-custom .nav-link:hover {
            color: #f8f9fa !important;
            opacity: 0.8;
        }

        .sidebar {
            position: fixed;
            top: 61px;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 20px 0;
            background-color: white;
            color: black;
        }
        .sidebar-sticky {
            position: relative;
            height: calc(100vh - 56px);
            width: 150px;
            overflow-x: hidden;
            overflow-y: auto;
        }

        .sidebar .nav-link {
            color: rgb(0, 0, 0);
            padding: 10px 20px;
            font-size: large;
        }
        .sidebar .nav-link:hover {
            color: #d81142;
            background-color: rgba(255, 255, 255, 0.2);
        }
        .sidebar .nav-link.active {
            color: white;
            background-color: rgb(216, 17, 66);
        }

        .main-content {
            margin-left: 220px;
            padding: 20px;
        }

        .card-row {
            display: flex;
            gap: 1rem;
            padding: 1rem;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .stats-card {
            flex: 1;
            min-width: 280px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-3px);
        }

        .content-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            padding: 0 1rem 1rem;
            margin-top: 20px;
        }
        .chart-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 1rem;
        }

        #mapContainer {
            height: 500px;
            border-radius: 8px;
            overflow: hidden;
        }

        .comments-box {
            margin-top: 1.5rem;
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        /* 确保数据容器可见性 */
        #topFavorites, #topComments {
            display: block !important;
        }
        .list-group-item {
            color: #333 !important;
            border: none !important;
            margin-bottom: 4px;
        }
        .card {
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
        }
        @media (max-width: 992px) {
            .content-container {
                grid-template-columns: 1fr;
            }}
        .three-charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 1.5rem;
            padding: 0 1rem;
        }
        /* 雷达图容器样式 */
        .radar-chart-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 1rem;
            height: 400px;
            display: flex;
            flex-direction: column;
        }

        .radar-chart-container h5 {
            margin-bottom: 15px;
            color: #333;
            font-weight: bold;
        }

        #userBehaviorRadarChart {
            flex: 1;
            width: 100%;
        }

        @media (max-width: 1200px) {
            .three-charts-container {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 768px) {
            .three-charts-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-red fixed-top bg-dark1">
    <div class="container-fluid">
        <a class="navbar-brand" style="color: white; font-weight:bolder;" href="#">红色旅游管理后台</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="logout()">
                    <i class="bi bi-box-arrow-right me-2"></i> 退出登录
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- 侧边栏 -->
<div class="sidebar">
    <div class="sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="total.jsp">
                    <i class="bi bi-star me-2"></i> 数据统计
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link " href="user-list.jsp">
                    <i class="bi bi-people me-2"></i> 用户管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="scenic-list.jsp">
                    <i class="bi bi-map me-2"></i> 景点管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="route-list.jsp">
                    <i class="bi bi-signpost-2 me-2"></i> 路线管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="comment-list.jsp">
                    <i class="bi bi-chat-left-dots me-2"></i> 评论管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="study-list.jsp">
                    <i class="bi bi-chat-square-text me-2"></i> 红色研学
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="video-admin.jsp">
                    <i class="bi bi-film me-2"></i> 影像视频
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="travelnotes-list.jsp">
                    <i class="bi bi-book me-2"></i> 游记论坛
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="news-list.jsp">
                    <i class="bi bi-newspaper me-2"></i> 新闻公告
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feedback-list.jsp">
                    <i class="bi bi-chat-left-text me-2"></i> 意见反馈
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="main-content">
    <div class="card-row">
        <!-- 用户统计卡片 -->
        <div class="stats-card p-3">
            <h5 class="d-flex align-items-center mb-3">
                <i class="bi bi-people fs-5 me-2"></i>用户统计
            </h5>
            <div class="d-flex justify-content-between align-items-end">
                <div>
                    <div class="h2 mb-0" id="totalUsers">0</div>
                    <small class="text-muted">总用户数</small>
                </div>
                <div class="text-success">
                    <span class="h4">+</span>
                    <span class="h3" id="todayNewUsers">0</span>
                    <div class="text-muted small">今日新增</div>
                </div>
            </div>
        </div>

        <!-- 收藏前三卡片 -->
        <div class="stats-card p-3">
            <h5 class="d-flex align-items-center mb-3">
                <i class="bi bi-star fs-5 me-2"></i>收藏前三景点
            </h5>
            <div id="topFavorites" class="list-group" style="gap: 8px;">
                <!-- 动态内容插入点 -->
            </div>
        </div>

        <!-- 省份统计卡片 -->
        <div class="stats-card p-3">
            <h5 class="d-flex align-items-center mb-3">
                <i class="bi bi-geo-alt fs-5 me-2"></i>景点最多的省份
            </h5>
            <div class="text-center">
                <div class="h2 mb-1" id="topProvinceCount">0</div>
                <div class="text-muted small" id="topProvinceName">--</div>
            </div>
        </div>
    </div>

    <!-- 替换原来的地图和评论容器部分 -->
    <div class="content-container">


        <!-- 互动趋势图表 -->
        <div class="chart-container" style="width: 1577px;">
            <div class="h-100 bg-white p-3 rounded shadow-sm">
                <h5 class="mb-3"><i class="bi bi-activity me-2"></i>互动趋势分析及用户增长趋势(30天)</h5>
                <div id="interactionTrendChart" style="height: 400px;"></div>
            </div>
        </div>
    </div>

    <!-- 新增三图表行 -->
    <div class="three-charts-container mt-4">
        <!-- 饼图容器 -->
        <div class="chart-container">
            <div class="h-100 bg-white p-3 rounded shadow-sm">
                <h5 class="mb-3"><i class="bi bi-pie-chart me-2"></i>景点地域分布</h5>
                <div id="pieChart" style="height: 350px;"></div>
            </div>
        </div>

        <!-- 柱形图容器 -->
        <div class="chart-container">
            <div class="h-100 bg-white p-3 rounded shadow-sm">
                <h5 class="mb-3"><i class="bi bi-bar-chart me-2"></i>评论前10的景点</h5>
                <div id="barChart" style="height: 350px;"></div>
            </div>
        </div>

        <!-- 雷达图容器 -->
        <div class="chart-container">
            <div class="h-100 bg-white p-3 rounded shadow-sm">
                <h5 class="mb-3"><i class="bi bi-radar me-2"></i>用户行为分布</h5>
                <div id="userBehaviorRadarChart" style="height: 350px;width: 100%;"></div>
            </div>
        </div>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        fetch('${pageContext.request.contextPath}/api/statistics/dashboard')
            .then(res => res.json())
            .then(data => {
                console.log('Received data:', data); // 调试用

                // 1. 更新用户数据
                document.getElementById('totalUsers').textContent = data.totalUsers || 0;
                document.getElementById('todayNewUsers').textContent = data.todayNewUsers || 0;

                // 2. 渲染收藏前三（使用转义模板字符串）
                if (data.top3Favorites && Array.isArray(data.top3Favorites)) {
                    const favoritesHtml = data.top3Favorites.map((item, index) => `
                        <div class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center" style="flex:1">
                                <span class="badge bg-danger me-2">\${index + 1}</span>
                                <span class="text-truncate" style="max-width: 160px">\${item.name || '未知景点'}</span>
                            </div>
                            <span class="badge bg-warning">\${item.favorite_count || 0}</span>
                        </div>
                    `).join('');
                    document.getElementById('topFavorites').innerHTML = favoritesHtml;
                }
                // 4. 更新省份数据
                if (data.topProvince) {
                    document.getElementById('topProvinceName').textContent = data.topProvince.province || '--';
                    document.getElementById('topProvinceCount').textContent = data.topProvince.scenic_count || 0;
                }

                //5.互动增长趋势 合并图表初始化
                if (data.userGrowthTrend && data.interactionTrend) {
                    initInteractionTrendChart(data.interactionTrend, data.userGrowthTrend);
                }

                // 6. 初始化用户行为雷达图
                console.log('User Behavior Stats:', data.userBehaviorStats); // 检查数据是否存在
                if (data.userBehaviorStats) {
                    initUserBehaviorRadarChart(data.userBehaviorStats);
                }else {
                    console.error('userBehaviorStats数据缺失');
                }

                if (data.top10Comments && Array.isArray(data.top10Comments)) {
                    initTopCommentsChart(data.top10Comments);
                }

                if (data.scenicDistribution) {
                    initPieChart(data.scenicDistribution);
                }

            })
            .catch(error => {
                console.error('数据请求失败:', error);
                alert('数据加载失败，请查看控制台获取详细信息');
            });


        function initInteractionTrendChart(data, userGrowthData) {
            const chart = echarts.init(document.getElementById('interactionTrendChart'));

            const dates = data.map(item => item.date);
            const comments = data.map(item => item.comments);
            const favorites = data.map(item => item.favorites);
            const likes = data.map(item => item.likes);
            const userCounts = userGrowthData.map(item => item.count);

            const option = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['评论', '收藏', '点赞', '用户增长']
                },
                xAxis: {
                    type: 'category',
                    data: dates
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: '评论',
                        data: comments,
                        type: 'line',
                        smooth: false,
                        itemStyle: { color: '#0d6efd' },
                        lineStyle: { width: 3 }
                    },
                    {
                        name: '收藏',
                        data: favorites,
                        type: 'line',
                        smooth: false,
                        itemStyle: { color: '#ffc107' },
                        lineStyle: { width: 3 }
                    },
                    {
                        name: '点赞',
                        data: likes,
                        type: 'line',
                        smooth: false,
                        itemStyle: { color: '#20c997' },
                        lineStyle: { width: 3 }
                    },
                    {
                        name: '用户增长',
                        data: userCounts,
                        type: 'line',
                        smooth: false,
                        itemStyle: { color: '#dc3545' },
                        lineStyle: { width: 3 }
                    }
                ]
            };

            chart.setOption(option);
            window.addEventListener('resize', function() {
                chart.resize();
            });
        }

        function initUserBehaviorRadarChart(data) {
            // 确保容器存在
            const container = document.getElementById('userBehaviorRadarChart');
            if (!container) {
                console.error('雷达图容器未找到');
                return;
            }

            // 初始化图表
            const chart = echarts.init(container);

            // 定义雷达图指标 - 使用实际数据计算最大值
            const indicators = [
                { name: '评论', max: Math.max(50, data.comment_count * 1.5) },
                { name: '收藏', max: Math.max(50, data.favorite_count * 1.5) },
                { name: '点赞', max: Math.max(50, data.like_count * 1.5) },
                { name: '新闻浏览', max: Math.max(100, data.news_view_count * 1.5) },
                { name: '研学参与', max: Math.max(100, data.study_view_count * 1.5) },
                { name: '景点互动', max: Math.max(50, data.scenic_like_count * 1.5) },
                { name: '路线互动', max: Math.max(50, data.route_like_count * 1.5) }
            ];

            const option = {
                title: {
                    text: '用户行为分布',
                    left: 'center',
                    textStyle: {
                        color: '#333',
                        fontSize: 16
                    }
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    data: ['行为数据'],
                    bottom: 10
                },
                radar: {
                    indicator: indicators,
                    radius: '65%',
                    splitNumber: 4,
                    axisName: {
                        color: '#666'
                    },
                    splitArea: {
                        areaStyle: {
                            color: [
                                'rgba(255, 255, 255, 0.7)',   // 白色（最外层）
                                'rgba(173, 216, 230, 0.5)',   // 浅蓝色
                                'rgba(100, 149, 237, 0.3)',   // 亮蓝色
                                'rgba(30, 144, 255, 0.2)'     // 道奇蓝
                            ]
                        }
                    },
                    axisLine: {
                        lineStyle: {
                            color: 'rgba(0, 0, 139, 0.8)'
                        }
                    },
                    splitLine: {
                        lineStyle: {
                            color:  'rgba(70, 130, 180, 0.5)'
                        }
                    }
                },
                series: [{
                    name: '用户行为',
                    type: 'radar',
                    data: [{
                        value: [
                            data.comment_count || 0,
                            data.favorite_count || 0,
                            data.like_count || 0,
                            data.news_view_count || 0,
                            data.study_view_count || 0,
                            data.scenic_like_count || 0,
                            data.route_like_count || 0
                        ],
                        name: '行为数据',
                        areaStyle: {
                            color: 'rgba(0, 0, 255, 0.4)'
                        },
                        lineStyle: {
                            width: 2,
                            color: '#0d6efd'
                        },
                        symbolSize: 6
                    }]
                }]
            };

            chart.setOption(option);

            // 响应式调整
            window.addEventListener('resize', function() {
                chart.resize();
            });

            return chart;
        }

        function initTopCommentsChart(data) {
            const chart = echarts.init(document.getElementById('barChart'));

            const names = data.map(item => item.name); // 景点名称
            const commentCounts = data.map(item => item.comment_count); // 评论数

            // 定义一组不同的颜色
            const colors = [
                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
                '#FF9F40', '#56B4E9', '#009E73', '#F0E442', '#D55E00'
            ];
            const option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                xAxis: {
                    type: 'category',
                    data: names, // 景点名称放在X轴
                    axisLabel: {
                        rotate: 45, // 如果景点名称过长，可以旋转45度
                        interval: 0, // 强制显示所有标签
                        formatter: function(value) {
                            return value.length > 10 ? value.slice(0, 10) + '...' : value; // 如果景点名称过长，截断显示
                        }
                    }
                },
                yAxis: {
                    type: 'value',
                    boundaryGap: [0, 0.01]
                },
                series: [
                    {
                        name: '评论数',
                        type: 'bar',
                        data: commentCounts,
                        itemStyle: {
                            color: function(params) {
                                return colors[params.dataIndex % colors.length];
                            }                        }
                    }
                ]
            };

            chart.setOption(option);
            window.addEventListener('resize', function() {
                chart.resize();
            });
        }

        function initPieChart(data) {
            const chart = echarts.init(document.getElementById('pieChart'));

            // 定义7大区映射关系
            const regionMapping = {
                '华东': ['上海', '江苏', '浙江', '安徽', '福建', '江西', '山东'],
                '华北': ['北京', '天津', '河北', '山西', '内蒙古'],
                '华中': ['河南', '湖北', '湖南'],
                '华南': ['广东', '广西', '海南'],
                '西南': ['重庆', '四川', '贵州', '云南', '西藏'],
                '西北': ['陕西', '甘肃', '青海', '宁夏', '新疆'],
                '东北': ['辽宁', '吉林', '黑龙江']
            };

            // 初始化所有大区（确保即使目前没有数据后期也显示）
            const regionData = Object.keys(regionMapping).map(region => ({
                name: region,
                value: 0
            }));

            // 统计每个区域的景点数量
            data.forEach(item => {
                for (const [region, provinces] of Object.entries(regionMapping)) {
                if (provinces.includes(item.name.replace(/省|市|自治区|特别行政区/g, ''))) {
                    const target = regionData.find(r => r.name === region);
                    if (target) target.value += item.value;
                    break;
                }
            }
        });

            // 过滤掉值为0的大区（可选）
            const filteredData = regionData.filter(item => item.value > 0);

            // 按数量降序排列
            const processedData = [...filteredData].sort((a, b) => b.value - a.value);

            // 定义7大区的专属颜色
            const regionColors = {
                '华东': '#c23531', // 红色
                '华北': '#2f4554', // 深蓝
                '华中': '#61a0a8', // 青色
                '华南': '#d48265', // 橙色
                '西南': '#91c7ae', // 浅绿
                '西北': '#749f83', // 橄榄绿
                '东北': '#ca8622'  // 金色
            };

            const option = {
                title: {
                    text: '景点大区分布',
                    subtext: '当前数据：' + data.reduce((sum, item) => sum + item.value, 0) + '个景点',
                left: 'center',
                textStyle: {
                fontSize: 16,
                    fontWeight: 'bold'
            }
        },
            tooltip: {
                trigger: 'item',
                    formatter: '{b}: {c}个景点 ({d}%)'
            },
            legend: {
                orient: 'vertical',
                    right: 10,
                    top: 'center',
                    data: processedData.map(item => item.name)
            },
            series: [{
                name: '大区分布',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: true,
                itemStyle: {
                    color: function(params) {
                        return regionColors[params.data.name];
                    },
                    borderRadius: 5,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: true,
                    formatter: '{b}: {c}',
                    fontSize: 12
                },
                labelLine: {
                    show: true
                },
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },
                    label: {
                        show: true,
                        fontSize: '14',
                        fontWeight: 'bold'
                    }
                },
                data: processedData
            }]
        };

            chart.setOption(option);
            window.addEventListener('resize', function() {
                chart.resize();
            });
        }

    });

    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin'
        }).then(() => window.location.href = '../RedTourismSystem/login-admin.jsp');
    }
</script>
<script src="../../js/bootstrap.bundle.min.js"></script>
</body>
</html>