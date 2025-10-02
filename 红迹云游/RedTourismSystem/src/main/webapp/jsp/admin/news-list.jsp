<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新闻公告管理 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        .article-preview {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .article-container {
            position: relative;
            min-height: 40px;
            padding-bottom: 20px;
            width: 300px;
        }

        .article-preview {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
            cursor: pointer;
        }

        .article-full {
            white-space: pre-wrap;
            display: none;
            width: auto;
            max-height: 300px;
            overflow-y: auto;
            position: absolute;
            left: 0;
            top: 0;
            background: white;
            z-index: 10;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .article-container.expanded .article-preview {
            display: none;
        }

        .article-container.expanded .article-full {
            display: block;
        }

        .toggle-article {
            position: absolute;
            bottom: 0;
            right: 0;
            font-size: 12px;
            color: #dc3545;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .article-container.expanded .toggle-article {
            bottom: 10px; /* 预留一定空间 */
            right: 10px; /* 预留一定空间 */
        }
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        .news-checkbox {
            transform: scale(1.5); /* 增加复选框的大小 */
            margin-top: 12px;
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
                <a class="nav-link active" href="news-list.jsp">
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

<!-- 主内容区 -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>新闻公告管理</h3>
        <div class="ms-auto">
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#addNewsModal">
                <i class="bi bi-plus"></i> 添加新闻
            </button>
            <button id="batchDeleteNewsBtn" class="btn btn-danger" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>

    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-4">
                    <input type="text" class="form-control" id="searchNewsTitle" placeholder="按新闻标题搜索">
                </div>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="searchNewsAuthor" placeholder="按作者搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterNews()">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 新闻表格 -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>封面</th>
                        <th>标题</th>
                        <th>来源</th>
                        <th>内容预览</th>
                        <th>新闻正文</th>
                        <th>作者</th>
                        <th>发布时间</th>
                        <th>浏览次数</th>
                        <th>操作</th>
                        <th>
                            全选 <input type="checkbox" id="selectAllNews" onclick="selectAllNews(this)">
                        </th>
                    </tr>
                    </thead>
                    <tbody id="newsTable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 添加新闻模态框 -->
<div class="modal fade" id="addNewsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加新闻</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addNewsForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">新闻标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻来源</label>
                        <input type="text" class="form-control" name="source" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">作者</label>
                        <input type="text" class="form-control" name="author" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻摘要</label>
                        <textarea class="form-control" name="content" rows="5" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻正文</label>
                        <textarea class="form-control" name="article" rows="5" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">发布时间</label>
                        <input type="text" class="form-control" name="publishTime" placeholder="YYYY-MM-DD HH:mm:ss" required>
                        <small class="text-muted">请输入完整时间格式，例如: 2025-03-12 14:30:45</small> <!-- 移除 readonly 和自动获取时间代码 -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addNews()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改新闻模态框 -->
<div class="modal fade" id="editNewsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改新闻</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editNewsForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">新闻标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*">
                        <div class="mt-2">
                            <div id="newsImageLoading" class="text-center" style="display: none;">
                                <div class="spinner-border spinner-border-sm" role="status">
                                    <span class="visually-hidden">加载中...</span>
                                </div>
                            </div>
                            <img id="currentNewsImage"
                                 src=""
                                 style="max-height: 150px; display: none;"
                                 class="img-thumbnail">
                            <div id="newsImageError" class="text-danger small mt-1" style="display: none;">
                                图片加载失败
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻来源</label>
                        <input type="text" class="form-control" name="source" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">作者</label>
                        <input type="text" class="form-control" name="author" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻内容</label>
                        <textarea class="form-control" name="content" rows="5" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新闻正文</label>
                        <textarea class="form-control" name="article" rows="5" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">发布时间</label>
                        <input type="text" class="form-control" name="publishTime"> <!-- 移除 readonly -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateNews()">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchNews();
    });

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

    // 在提交前验证时间格式
    function validateDateTime(input) {
        const regex = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/;
        const isValid = regex.test(input.value);
        console.log('Input:', input.value, 'Is Valid:', isValid);
        if (!isValid) {
            alert('请输入正确的时间格式: YYYY-MM-DD HH:mm:ss');
            input.focus();
            return false;
        }
        return true;
    }
    // 全选/取消全选新闻
    function selectAllNews(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="newsId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn();
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.classList.contains('news-checkbox')) {
            updateBatchDeleteBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAllNews').checked = false;
            }
        }
    });

    // 批量删除按钮点击事件
    document.getElementById('batchDeleteNewsBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="newsId"]:checked').forEach(function(cb) {
            selectedIds.push(cb.value);
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的新闻');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '个新闻吗？')) {
            fetch('${pageContext.request.contextPath}/news/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({newsIds: selectedIds})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchNews();
                    } else {
                        alert('删除失败: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('删除失败，请稍后再试');
                });
        }
    });

    // 更新批量删除按钮状态
    function updateBatchDeleteBtn() {
        const checkedCount = document.querySelectorAll('input[name="newsId"]:checked').length;
        document.getElementById('batchDeleteNewsBtn').disabled = checkedCount === 0;
    }

    // 在 fetchNews 函数中添加复选框
    function fetchNews() {
        fetch('${pageContext.request.contextPath}/news/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('newsTable');
                    tableBody.innerHTML = '';

                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td colspan="11" class="text-center">暂无新闻数据</td>';
                        tableBody.appendChild(row);
                        return;
                    }

                    data.data.forEach(function(news) {
                        var row = document.createElement('tr');

                        // ID列
                        var idCell = document.createElement('td');
                        idCell.textContent = news.id;
                        row.appendChild(idCell);

                        // 封面列
                        var coverCell = document.createElement('td');
                        if(news.coverImage){
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + news.coverImage;
                            img.onerror = function() {
                                this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                                this.onerror = null;
                            };
                            coverCell.appendChild(img);
                        }else{
                            coverCell.textContent = '无封面';
                        }
                        row.appendChild(coverCell);

                        // 标题列
                        var titleCell = document.createElement('td');
                        titleCell.textContent = news.title;
                        row.appendChild(titleCell);

                        var sourceCell = document.createElement('td');
                        sourceCell.textContent = news.source;
                        row.appendChild(sourceCell);

                        //内容预览
                        var contentCell = document.createElement('td');
                        contentCell.appendChild(createArticleCell(news.content || 'N/A'));
                        row.appendChild(contentCell);

                        //正文列
                        var articleCell = document.createElement('td');
                        articleCell.appendChild(createArticleCell(news.article || 'N/A'));
                        row.appendChild(articleCell);

                        // 作者列
                        var authorCell = document.createElement('td');
                        authorCell.textContent = news.author;
                        row.appendChild(authorCell);

                        // 发布时间列
                        var timeCell = document.createElement('td');
                        timeCell.textContent = news.publishTime;
                        row.appendChild(timeCell);

                        // 浏览次数列
                        var viewCell = document.createElement('td');
                        viewCell.textContent = news.viewCount || 0;
                        row.appendChild(viewCell);

                        // 操作列
                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditNewsModal(news.id);
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteNews(news.id);
                        };
                        actionCell.appendChild(deleteBtn);
                        row.appendChild(actionCell);

                        // 添加复选框
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'newsId';
                        checkbox.value = news.id;
                        checkbox.className = 'news-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取新闻数据失败:', data.message);
                    const tableBody = document.getElementById('newsTable');
                    tableBody.innerHTML = '<tr><td colspan="11" class="text-center">加载新闻数据失败</td></tr>';
                }
            })
            .catch(error => {
                console.error('获取新闻数据出错:', error);
                const tableBody = document.getElementById('newsTable');
                tableBody.innerHTML = '<tr><td colspan="11" class="text-center">加载新闻数据出错</td></tr>';
            });
    }


    function fetchNews() {
        fetch('${pageContext.request.contextPath}/news/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('newsTable');
                    tableBody.innerHTML = '';

                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td colspan="10" class="text-center">暂无新闻数据</td>';
                        tableBody.appendChild(row);
                        return;
                    }

                    data.data.forEach(function(news) {
                        var row = document.createElement('tr');

                        // ID列
                        var idCell = document.createElement('td');
                        idCell.textContent = news.id;
                        row.appendChild(idCell);

                        // 封面列
                        var coverCell = document.createElement('td');
                        if(news.coverImage){
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + news.coverImage;
                            img.onerror = function() {
                                this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                                this.onerror = null;
                            };
                            coverCell.appendChild(img);
                        }else{
                            coverCell.textContent = '无封面';
                        }
                        row.appendChild(coverCell);

                        // 标题列
                        var titleCell = document.createElement('td');
                        titleCell.textContent = news.title;
                        row.appendChild(titleCell);

                        var sourceCell = document.createElement('td');
                        sourceCell.textContent = news.source;
                        row.appendChild(sourceCell);

                        //内容预览
                        var contentCell = document.createElement('td');
                        // contentCell.textContent = news.content;
                        contentCell.appendChild(createArticleCell(news.content || 'N/A'));
                        row.appendChild(contentCell);

                        //正文列
                        var articleCell = document.createElement('td');
                        // articleCell.textContent = news.article;
                        articleCell.appendChild(createArticleCell(news.article || 'N/A'));
                        row.appendChild(articleCell);

                        // 作者列
                        var authorCell = document.createElement('td');
                        authorCell.textContent = news.author;
                        row.appendChild(authorCell);

                        // 发布时间列
                        var timeCell = document.createElement('td');
                        timeCell.textContent = news.publishTime;
                        row.appendChild(timeCell);

                        // 浏览次数列
                        var viewCell = document.createElement('td');
                        viewCell.textContent = news.viewCount || 0;
                        row.appendChild(viewCell);

                        // 操作列
                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditNewsModal(news.id);
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteNews(news.id);
                        };
                        actionCell.appendChild(deleteBtn);

                        row.appendChild(actionCell);
                        // 添加复选框
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'newsId';
                        checkbox.value = news.id;
                        checkbox.className = 'news-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);
                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取新闻数据失败:', data.message);
                    const tableBody = document.getElementById('newsTable');
                    tableBody.innerHTML = '<tr><td colspan="10" class="text-center">加载新闻数据失败</td></tr>';
                }
            })
            .catch(error => {
                console.error('获取新闻数据出错:', error);
                const tableBody = document.getElementById('newsTable');
                tableBody.innerHTML = '<tr><td colspan="10" class="text-center">加载新闻数据出错</td></tr>';
            });
    }

    function createArticleCell(article) {
        const container = document.createElement('div');
        container.className = 'article-container';

        const preview = document.createElement('div');
        preview.className = 'article-preview';
        preview.textContent = article || 'N/A';
        container.appendChild(preview);

        const full = document.createElement('div');
        full.className = 'article-full';
        full.textContent = article || 'N/A';
        container.appendChild(full);

        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'toggle-article';
        toggleBtn.textContent = '显示更多';
        container.appendChild(toggleBtn);

        // 添加点击事件监听器到整个 container
        container.onclick = function(e) {
            e.stopPropagation(); // 阻止事件冒泡
            container.classList.toggle('expanded');
            toggleBtn.textContent = container.classList.contains('expanded') ? '收起' : '显示更多';
        };

        return container;
    }

    function addNews() {
        const form = document.getElementById('addNewsForm');
        const timeInput = form.querySelector('[name="publishTime"]');

        if (!validateDateTime(timeInput)) {
            return;
        }
        const formData = new FormData(form);


        fetch('${pageContext.request.contextPath}/news/add', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`HTTP ${response.status}: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('新闻添加成功');
                    fetchNews();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addNewsModal'));
                    modal.hide();
                    form.reset();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('添加新闻失败:', error);
                alert('添加新闻失败: ' + error.message);
            });
    }

    function showEditNewsModal(newsId) {
        fetch('${pageContext.request.contextPath}/news/' + newsId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('获取新闻详情失败');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const news = data.data;
                    const form = document.getElementById('editNewsForm');

                    form.querySelector('[name="id"]').value = news.id;
                    form.querySelector('[name="title"]').value = news.title;
                    form.querySelector('[name="source"]').value = news.source;
                    form.querySelector('[name="author"]').value = news.author;
                    form.querySelector('[name="content"]').value = news.content || '';
                    form.querySelector('[name="article"]').value = news.article || '';

                    form.querySelector('[name="publishTime"]').value = news.publishTime || ''; // 确保发布时间正确显示

                    const imgPreview = document.getElementById('currentNewsImage');
                    imgPreview.src = '${pageContext.request.contextPath}/news/image/' + news.id;
                    imgPreview.style.display = 'block';
                    imgPreview.onerror = function() {
                        this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                        this.onerror = null;
                    };

                    const modal = new bootstrap.Modal(document.getElementById('editNewsModal'));
                    modal.show();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('获取新闻详情失败:', error);
                alert('获取新闻详情失败');
            });
    }

    function updateNews() {
        const form = document.getElementById('editNewsForm');
        const timeInput = form.querySelector('[name="publishTime"]');

        if (!validateDateTime(timeInput)) {
            return;
        }
        const formData = new FormData(form);

        // 显示加载状态
        const saveBtn = document.querySelector('#editNewsModal .btn-danger');
        const originalText = saveBtn.innerHTML;
        saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> 处理中...';
        saveBtn.disabled = true;

        fetch('${pageContext.request.contextPath}/news/update', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`HTTP ${response.status}: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('新闻更新成功');
                    fetchNews();
                    const newsId = form.querySelector('[name="id"]').value;
                    const imgPreview = document.getElementById('currentNewsImage');
                    // 添加随机参数以避免缓存
                    imgPreview.src = '${pageContext.request.contextPath}/news/image/' + newsId + '?t=' + new Date().getTime();
                    $('#editNewsModal').modal('hide');
                } else {
                    throw new Error(data.message || '更新失败');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                alert('更新失败: ' + error.message);
            })
            .finally(() => {
                saveBtn.innerHTML = originalText;
                saveBtn.disabled = false;
            });
    }

    function deleteNews(newsId) {
        if (confirm('确定要删除这条新闻吗？')) {
            fetch('${pageContext.request.contextPath}/news/delete/' + newsId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('新闻删除成功');
                        fetchNews();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('删除新闻失败:', error);
                    alert('删除新闻失败');
                });
        }
    }

    function filterNews() {
        const searchTitle = document.getElementById('searchNewsTitle').value.toLowerCase();
        const searchAuthor = document.getElementById('searchNewsAuthor').value.toLowerCase();

        const tableRows = document.querySelectorAll('#newsTable tr');
        tableRows.forEach(function(row) {
            const titleCell = row.querySelector('td:nth-child(3)');
            const authorCell = row.querySelector('td:nth-child(7)');

            if (titleCell && authorCell) {
                const titleText = titleCell.textContent.toLowerCase();
                const authorText = authorCell.textContent.toLowerCase();

                if ((titleText.includes(searchTitle) || searchTitle === '') &&
                    (authorText.includes(searchAuthor) || searchAuthor === '')) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        });
    }
</script>
</body>
</html>