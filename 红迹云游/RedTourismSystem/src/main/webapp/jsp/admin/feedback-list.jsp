<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户管理 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">


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
            flex: 1;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1rem;
            padding: 0 1rem 1rem;
        }

        #mapContainer {
            height: 500px;
            border-radius: 8px;
            overflow: hidden;
        }

        .comments-box {
            background: white;
            border-radius: 8px;
            padding: 1rem;
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
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        .status-pill {
            display: inline-block;
            padding: 0.25em 0.6em;
            font-size: 85%;
            border-radius: 1rem;
        }
        .feedback-content {
            max-height: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
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
                <a class="nav-link " href="total.jsp">
                    <i class="bi bi-star me-2"></i> 数据统计
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="user-list.jsp">
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
                <a class="nav-link active" href="feedback-list.jsp">
                    <i class="bi bi-chat-left-text me-2"></i> 意见反馈
                </a>
            </li>

        </ul>
    </div>
</div>
<!-- 搜索框 -->

<!-- 主内容区 -->
<div class="main-content">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>反馈管理</h3>
        <button class="btn btn-danger" onclick="deleteSelected()">
            <i class="bi bi-trash"></i> 批量删除
        </button>
    </div>

    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3">
                <div class="col-md-2">
                    <select name="status" class="form-select">
                        <option value="">全部状态</option>
                        <option value="pending">待处理</option>
                        <option value="processing">处理中</option>
                        <option value="resolved">已解决</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="number" name="userId" class="form-control" placeholder="用户ID">
                </div>
                <div class="col-md-3">
                    <input type="date" name="startDate" class="form-control" placeholder="开始日期">
                </div>
                <div class="col-md-3">
                    <input type="date" name="endDate" class="form-control" placeholder="结束日期">
                </div>
                <div class="col-md-3">
                    <input type="text" name="keyword" class="form-control" placeholder="关键词">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="search()">
                        <i class="bi bi-search"></i> 搜索
                    </button>
                </div>

            </form>
        </div>
    </div>

    <!-- 反馈列表卡片 -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" onclick="toggleAll(this)"></th>
                    <th>ID</th>
                    <th>用户ID</th>
                    <th>类型</th>
                    <th>内容</th>
                    <th>状态</th>
                    <th>提交时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="feedbackTable">
                <%-- 动态加载反馈数据 --%>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    // 页面加载时获取反馈列表
    window.onload = function() {
        loadFeedbacks();
    };
    console.log('页面加载完成');

    function loadFeedbacks(params) {
        fetch('<%= request.getContextPath() %>/feedback/list?' + new URLSearchParams(params))
            .then(response => response.json())
    .then(data => {
            console.log('原始响应数据:', data);
        if (data.code === 200) {
            console.log('有效反馈数据:', data.data);
            renderTable(data.data);
        } else {
            console.error('数据加载失败:', data.message);
            alert('数据加载失败: ' + data.message);
        }
    })
    .catch(error => {
            console.error('请求失败:', error);
        alert('请求失败，请检查控制台');
    });
    }

    // 渲染表格（核心修改：字符串拼接改用 + 号）
    function renderTable(feedbacks) {
        const tbody = document.getElementById('feedbackTable');
        tbody.innerHTML = '';
        if (feedbacks.length === 0) {
            tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">暂无反馈数据</td></tr>';
            return;
        }
        feedbacks.forEach(feedback => {
            const row = document.createElement('tr');
        // 复选框列
        const checkCell = document.createElement('td');
        const checkbox = document.createElement('input');
        checkbox.type = 'checkbox';
        checkbox.className = 'feedback-checkbox';
        checkbox.name = 'feedbackIds';
        checkbox.value = feedback.feedbackId;
        checkCell.appendChild(checkbox);
        row.appendChild(checkCell);
        // 数据列（改用普通字符串拼接）
        row.innerHTML +=
            '<td>' + feedback.feedbackId + '</td>' +
            '<td>' + feedback.userId + '</td>' +
            '<td>' + feedback.feedbackType + '</td>' +
            '<td class="text-break">' + feedback.content + '</td>' +
            '<td><span class="badge bg-' + getStatusClass(feedback.status) + '">' + feedback.status + '</span></td>' +
            '<td>' + formatDate(feedback.createTime) + '</td>' +
            '<td>' + getOperations(feedback.status, feedback.feedbackId) + '</td>';
        tbody.appendChild(row);
    });
    }

    // 搜索功能
    function search() {
        const form = document.getElementById('searchForm');
        const params = {}; // 初始化空参数对象

        // 处理status：非空时添加
        const status = form.status.value.trim();
        if (status !== '') {
            params.status = status;
        }

        // 处理userId：非空时添加（输入框为number类型，空值为''，需转为数字）
        const userId = form.userId.value.trim();
        if (userId !== '') {
            params.userId = userId; // 后端会自动转换为Integer（需确保输入为合法数字）
        }

        // 处理startDate：非空时添加（格式为YYYY-MM-DD）
        const startDate = form.startDate.value.trim();
        if (startDate !== '') {
            params.startDate = startDate;
        }

        // 处理endDate：非空时添加（格式为YYYY-MM-DD）
        const endDate = form.endDate.value.trim();
        if (endDate !== '') {
            params.endDate = endDate;
        }

        // 处理keyword：非空时添加
        const keyword = form.keyword.value.trim();
        if (keyword !== '') {
            params.keyword = keyword;
        }

        loadFeedbacks(params); // 传递过滤后的参数
    }

    // 批量删除（无反引号，无需修改）
    function deleteSelected() {
        const checkboxes = document.querySelectorAll('input[name="feedbackIds"]:checked');
        if (checkboxes.length === 0) {
            alert('请选择要删除的反馈');
            return;
        }
        const feedbackIds = Array.from(checkboxes).map(cb => cb.value);
        if (confirm('确认删除选中的' + feedbackIds.length + '条反馈？')) {
            fetch('/feedback/batch-delete?feedbackIds=' + feedbackIds.join(','), {
                method: 'DELETE'
            }).then(() => loadFeedbacks());
        }
    }

    // 操作按钮生成（改用字符串拼接）
    function getOperations(status, feedbackId) {
        let buttons = '';
        if (status === 'pending') {
            buttons += '<button class="btn btn-sm btn-warning" onclick="startProcess(' + feedbackId + ')">开始处理</button>';
        }
        if (status === 'processing') {
            buttons += '<button class="btn btn-sm btn-success" onclick="markResolved(' + feedbackId + ')">标记解决</button>';
        }
        buttons += '<button class="btn btn-sm btn-danger" onclick="deleteFeedback(' + feedbackId + ')">删除</button>';
        return buttons;
    }

    // 日期格式化（无反引号，无需修改）
    function formatDate(timestamp) {
        return new Date(timestamp).toLocaleString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
    }

    // Toast 提示（改用字符串拼接）
    function showToast(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = 'toast align-items-center text-white bg-' + type + ' border-0';
        toast.role = 'alert';
        toast.innerHTML =
            '<div class="d-flex">' +
            '<div class="toast-body">' + message + '</div>' +
            '<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>' +
            '</div>';
        document.body.appendChild(toast);
        new bootstrap.Toast(toast).show();
        setTimeout(() => toast.remove(), 3000);
    }

    // 确认对话框（改用字符串拼接）
    function showConfirm(message, callback) {
        const modal = new bootstrap.Modal(document.createElement('div'), {
            keyboard: false,
            backdrop: 'static'
        });
        const modalContent =
            '<div class="modal-dialog">' +
            '<div class="modal-content">' +
            '<div class="modal-header">' +
            '<h5 class="modal-title">系统提示</h5>' +
            '</div>' +
            '<div class="modal-body">' + message + '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>' +
            '<button type="button" class="btn btn-danger" onclick="modal.hide(); callback()">确认</button>' +
            '</div>' +
            '</div>' +
            '</div>';
        document.body.insertAdjacentHTML('beforeend', modalContent);
        const modalElement = document.querySelector('.modal');
        modalElement.addEventListener('hidden.bs.modal', () => modalElement.remove());
        modal.show(modalElement);
    }

    // 其他函数（getStatusClass、toggleAll、startProcess 等，无反引号，无需修改）
    function getStatusClass(status) {
        const statusMap = {
            'pending': 'warning',
            'processing': 'primary',
            'resolved': 'success'
        };
        return statusMap[status] || 'secondary';
    }

    function toggleAll(checkbox) {
        document.querySelectorAll('.feedback-checkbox').forEach(cb => {
            cb.checked = checkbox.checked;
    });
    }

    function startProcess(feedbackId) {
        fetch('<%= request.getContextPath() %>/feedback/process/' + feedbackId, { method: 'POST' })
            .then(() => loadFeedbacks());
    }

    function markResolved(feedbackId) {
        fetch('<%= request.getContextPath() %>/feedback/resolve/' + feedbackId, { method: 'POST' })
            .then(() => loadFeedbacks());
    }

    function deleteFeedback(feedbackId) {
        if (confirm('确认删除这条反馈？')) {
            fetch('<%= request.getContextPath() %>/feedback/delete/' + feedbackId, { method: 'DELETE' })
                .then(() => loadFeedbacks());
        }
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