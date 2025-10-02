<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>红色研学 - 红色旅游系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <!-- D3.js for word cloud -->
    <script src="https://d3js.org/d3.v6.min.js"></script>
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

        .content-container {
            position: relative;
            min-height: 40px;
            padding-bottom: 20px;
            width: 300px;
        }

        .content-preview {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
            cursor: pointer;
        }

        .content-full {
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

        .content-container.expanded .content-preview {
            display: none;
        }

        .content-container.expanded .content-full {
            display: block;
        }

        .toggle-content {
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

        .content-container.expanded .toggle-content {
            bottom: 10px; /* 预留一定空间 */
            right: 10px; /* 预留一定空间 */
        }
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        .study-checkbox {
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
                <a class="nav-link  active" href="study-list.jsp">
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

<!-- 主内容区 -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>红色研学</h3>
<%--        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#addStudySpotModal">--%>
<%--            <i class="bi bi-plus"></i> 添加内容--%>
<%--        </button>--%>
        <div class="ms-auto">
            <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#addStudySpotModal">
                <i class="bi bi-plus"></i> 添加内容
            </button>
            <button id="batchDeleteBtn" class="btn btn-danger" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>
    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchSource" placeholder="按来源搜索">
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchAuthor" placeholder="按作者搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchTitle" placeholder="按标题搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100 ss" onclick="filterStudySpots()">搜索</button>
                </div>
            </form>
        </div>
    </div>
    <%--表格优化--%>
    <!-- 景点表格 -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive"> <!-- 添加响应式容器 -->
                <table class="table table-hover table-bordered align-middle text-nowrap">
                    <thead class="table-danger">
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th style="width: 100px;">图片</th>
                        <th style="width: 150px;">标题</th>
                        <th style="width: 80px;">作者</th>
                        <th style="width: 80px;">浏览数</th>
                        <th style="width: 150px;">内容</th>
                        <th style="width: 80px;">来源</th>
                        <th style="width: 120px;">时间</th>
                        <th style="width: 100px;">操作</th>
                        <th>
                            全选  <input type="checkbox" id="selectAll" onclick="selectAllStudies(this)">
                        </th>
                    </tr>
                    </thead>
                    <tbody id="studySpotsTable">
<%--                    <input type="checkbox" class="study-checkbox" name="studyIds" value="${spot.id}">--%>
                </table>
            </div>
        </div>
    </div>

</div>

<!-- 添加景点模态框 -->
<div class="modal fade" id="addStudySpotModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加内容</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addStudySpotForm" enctype="multipart/form-data" method="post">
                    <div class="mb-3">
                        <label class="form-label">标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">内容</label>
                        <textarea class="form-control" name="content" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">作者</label>
                        <input type="text" class="form-control" name="author">
                    </div>                <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    <div class="mb-3">
                        <label class="form-label">来源</label>
                        <input type="text" class="form-control" name="source">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">时间</label>
                        <input type="text" class="form-control" name="time">
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addStudySpot()">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改景点模态框 -->
<div class="modal fade" id="editStudySpotModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改内容</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editStudySpotForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*">
                        <div class="mt-2">
                            <div id="imageLoading" class="text-center" style="display: none;">
                                <div class="spinner-border spinner-border-sm" role="status">
                                    <span class="visually-hidden">加载中...</span>
                                </div>
                            </div>
                            <img id="currentCoverImage"
                                 src=""
                                 style="max-height: 150px; display: none;"
                                 class="img-thumbnail">
                            <div id="imageError" class="text-danger small mt-1" style="display: none;">
                                图片加载失败
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">内容</label>
                        <textarea class="form-control" name="content" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">作者</label>
                        <input type="text" class="form-control" name="author">
                    </div>                <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    <div class="mb-3">
                        <label class="form-label">来源</label>
                        <input type="text" class="form-control" name="source">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">时间</label>
                        <input type="text" class="form-control" name="time">
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateStudySpot()">保存</button>
            </div>
        </div>
    </div></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const navLinks = document.querySelectorAll('.sidebar .nav-link');
        navLinks.forEach(link =>{
            if(window.location.pathname.includes(link.getAttribute('href'))) {
                link.classList.add('active');
            }
        });
        fetchStudySpots();
    });

    function fetchStudySpots() {
        fetch('${pageContext.request.contextPath}/study/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('studySpotsTable');
                    tableBody.innerHTML = '';
                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td colspan="12" class="text-center">暂无内容</td>';
                        tableBody.appendChild(row);
                        return;
                    }

                    data.data.forEach(function(spot) {
                        var row = document.createElement('tr');

                        // ID列
                        var idCell = document.createElement('td');
                        idCell.textContent = spot.id;
                        row.appendChild(idCell);

                        // 封面列
                        var coverCell = document.createElement('td');
                        if (spot.coverImage) {
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + spot.coverImage;
                            coverCell.appendChild(img);
                        } else {
                            coverCell.textContent = '无图片';
                        }
                        row.appendChild(coverCell);

                        // 标题列
                        // var titleCell = document.createElement('td');
                        // titleCell.textContent = spot.title || 'N/A';
                        // row.appendChild(titleCell);
                        var titleCell = document.createElement('td');
                        titleCell.appendChild(createContentCell(spot.title || 'N/A'))
                        row.appendChild(titleCell);

                        // 作者列
                        var authorCell = document.createElement('td');
                        authorCell.textContent = spot.author || 'N/A';
                        row.appendChild(authorCell);

                        // 浏览次数列
                        var viewCell = document.createElement('td');
                        viewCell.textContent = spot.viewCount || 0;
                        row.appendChild(viewCell);

                        // 内容列
                        var contentCell = document.createElement('td');
                        contentCell.appendChild(createContentCell(spot.content || 'N/A'));
                        row.appendChild(contentCell);

                        // 来源列
                        var sourceCell = document.createElement('td');
                        sourceCell.textContent = spot.source || 'N/A';
                        row.appendChild(sourceCell);

                        // 时间列
                        var timeCell = document.createElement('td');
                        timeCell.textContent = spot.time || 'N/A';
                        row.appendChild(timeCell);

                        // 操作列
                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditStudySpotModal(spot.id);
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteStudySpot(spot.id);
                        };
                        actionCell.appendChild(deleteBtn);

                        row.appendChild(actionCell);
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'studyIds';
                        checkbox.value = spot.id; // 确保使用 spot.id 而不是 study.id
                        checkbox.className = 'study-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取数据失败:', data.message);
                    const tableBody = document.getElementById('studySpotsTable');
                    tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载数据失败</td></tr>';
                }
            })
            .catch(error => {
                console.error('获取数据出错:', error);
                const tableBody = document.getElementById('studySpotsTable');
                tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载数据出错</td></tr>';
            });
    }

    function createContentCell(content) {
        const container = document.createElement('div');
        container.className = 'content-container';

        const preview = document.createElement('div');
        preview.className = 'content-preview';
        preview.textContent = content || 'N/A';
        container.appendChild(preview);

        const full = document.createElement('div');
        full.className = 'content-full';
        full.textContent = content || 'N/A';
        container.appendChild(full);

        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'toggle-content';
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

    function addStudySpot() {
        const form = document.getElementById('addStudySpotForm');
        const formData = new FormData(form);
        fetch('${pageContext.request.contextPath}/study/add', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('内容添加成功');
                    fetchStudySpots(); // 刷新列表
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addStudySpotModal'));
                    modal.hide(); // 关闭模态框
                    form.reset(); // 重置表单
                } else {
                    alert(data.message || '添加内容失败!');
                }
            })
            .catch(error => {
                console.error('添加内容失败:', error);
                alert('添加内容失败');
            });
    }

    function showEditStudySpotModal(spotId) {
        fetch('${pageContext.request.contextPath}/study/' + spotId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('获取详情失败');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const spot = data.data;
                    const form = document.getElementById('editStudySpotForm');

                    form.querySelector('[name="id"]').value = spot.id;
                    form.querySelector('[name="title"]').value = spot.title;
                    form.querySelector('[name="author"]').value = spot.author || '';
                    form.querySelector('[name="content"]').value = spot.content || '';

                    // 等级、省份、城市、开放时间、门票信息、关键词
                    form.querySelector('[name="source"]').value = spot.source || '';
                    form.querySelector('[name="time"]').value = spot.time || '';

                    const imgPreview = document.getElementById('currentCoverImage');

                    // 重置图片状态
                    imgPreview.onerror = null;
                    imgPreview.style.display = 'none';

                    if (spot.coverImage) {
                        // 设置一次性加载尝试
                        imgPreview.onerror = function() {
                            this.style.display = 'none';
                            this.onerror = null; // 防止无限循环
                        };

                        // 设置图片源
                        imgPreview.src = '${pageContext.request.contextPath}/' + spot.coverImage;
                        imgPreview.style.display = 'block';
                    }

                    const modal = new bootstrap.Modal(document.getElementById('editStudySpotModal'));
                    modal.show();
                } else {
                    alert('获取详情失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('获取详情出错:', error);
                alert('获取详情出错，请稍后重试');
            });
    }

    function updateStudySpot() {
        const form = document.getElementById('editStudySpotForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/study/update', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('修改成功');
                    fetchStudySpots();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editStudySpotModal'));
                    modal.hide();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error updating study spot:', error);
                alert('修改失败');
            });
    }

    function deleteStudySpot(spotId) {
        if (confirm('确定要删除这个内容吗？')) {
            fetch('${pageContext.request.contextPath}/study/delete/' + spotId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchStudySpots();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting study spot:', error);
                    alert('删除失败');
                });
        }
    }

    // 搜索框
    function filterStudySpots() {
        const source = document.getElementById("searchSource").value.trim().toLowerCase();
        const author = document.getElementById("searchAuthor").value.trim().toLowerCase();
        const title = document.getElementById("searchTitle").value.trim().toLowerCase();
        const rows = document.querySelectorAll("#studySpotsTable tr");

        rows.forEach(row => {
            const SourceText = row.cells[6].textContent.toLowerCase(); // 来源列
            const AuthorText = row.cells[3].textContent.toLowerCase(); // 作者列
            const TitleText = row.cells[2].textContent.toLowerCase();  // 标题列

            const matchesSource = source === "" || SourceText.includes(source);
            const matchesAuthor = author === "" || AuthorText.includes(author);
            const matchesTitle = title === "" || TitleText.includes(title);

            row.style.display = (matchesSource && matchesAuthor && matchesTitle) ? "" : "none";
        });
    }
    //4.29
    // 更新全选逻辑
    function selectAllStudies(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="studyIds"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn();
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.classList.contains('study-checkbox')) {
            updateBatchDeleteBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAll').checked = false;
            }
        }
    });

    // 批量删除按钮点击事件
    // 批量删除按钮点击事件
    document.getElementById('batchDeleteBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="studyIds"]:checked').forEach(function(cb) {
            selectedIds.push(parseInt(cb.value)); // 确保值是整数
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的内容');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '个内容吗？')) {
            fetch('${pageContext.request.contextPath}/study/batchDelete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({studyIds: selectedIds})
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('服务器响应错误: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchStudySpots(); // 刷新列表
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
        const checkedCount = document.querySelectorAll('input[name="studyIds"]:checked').length;
        document.getElementById('batchDeleteBtn').disabled = checkedCount === 0;
    }

    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin' //确保携带cookie/session
        })
            .then(response => {
                //无论后端返回什么，都跳转到登录页
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