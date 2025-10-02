<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>路线管理 - 红色旅游系统</title>
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
            color: #d81142 ;
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
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        /* 修改描述容器样式 */
        .description-container {
            position: relative;
            min-height: 40px;
            padding-bottom: 20px;
            width: 300px;
        }

        .description-preview {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
            cursor: pointer;
        }

        .description-full {
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
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        /* 添加展开状态样式 */
        .description-container.expanded .description-preview {
            display: none;
        }

        .description-container.expanded .description-full {
            display: block;
        }

        .toggle-description {
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

        /* 确保收起按钮在内容下方 */
        .description-container.expanded .toggle-description {
            bottom: 10px; /* 预留一定空间 */
            right: 10px; /* 预留一定空间 */
        }
        .route-checkbox {
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
                <a class="nav-link " href="scenic-list.jsp">
                    <i class="bi bi-map me-2"></i> 景点管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="route-list.jsp">
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

<!-- 主内容区 -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>路线管理</h3>
        <div class="ms-auto">
            <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#addRouteModal">
                <i class="bi bi-plus"></i> 添加路线
            </button>
            <button id="batchDeleteRoutesBtn" class="btn btn-danger" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>


    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-4">
                    <input type="text" class="form-control" id="searchRouteDescription" placeholder="按路线简介搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterRoutes()">搜索</button>
                </div>
            </form>
        </div>
    </div>



    <!-- 路线表格 -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>封面</th>
                    <th>路线名称</th>

                    <!-- 路线简介 -->
                    <th>路线简介</th>
                    <!-- 路线简介 -->

                    <th>点赞数</th>
                    <th>操作</th>
                    <th>
                        全选 <input type="checkbox" id="selectAllRoutes" onclick="selectAllRoutes(this)">
                    </th>
                </tr>
                </thead>
                <tbody id="routesTable">
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 添加路线模态框 -->
<div class="modal fade" id="addRouteModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加路线</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addRouteForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">路线名称</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">路线简介</label>
                        <textarea class="form-control" name="description" rows="5"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addRoute()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改路线模态框 -->
<div class="modal fade" id="editRouteModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改路线</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editRouteForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">路线名称</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*">
                        <div class="mt-2">
<%--                            <div id="routeImageLoading" class="text-center" style="display: none;">--%>
<%--                                <div class="spinner-border spinner-border-sm" role="status">--%>
<%--                                    <span class="visually-hidden">加载中...</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                            <img id="currentRouteImage"
                                 src=""
                                 style="max-height: 150px; display: none;"
                                 class="img-thumbnail">
                            <div id="imageLoading" style="display: none;">加载中...</div>
                            <div id="routeImageError" class="text-danger small mt-1" style="display: none;">
                                图片加载失败
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">路线简介</label>
                        <textarea class="form-control" name="description" rows="5"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateRoute()">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchRoutes();
    });
    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin'//确保携带cookie/session
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
    // 使用事件委托绑定点击事件
    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('toggle-description')) {
            const container = event.target.parentElement;
            const preview = container.querySelector('.description-preview');
            const full = container.querySelector('.description-full');
            const toggleBtn = container.querySelector('.toggle-description');

            container.classList.toggle('expanded');
            toggleBtn.textContent = container.classList.contains('expanded') ? '收起' : '显示更多';
        }
    });


    // 全选/取消全选路线
    function selectAllRoutes(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="routeId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn();
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.classList.contains('route-checkbox')) {
            updateBatchDeleteBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAllRoutes').checked = false;
            }
        }
    });

    // 批量删除按钮点击事件
    document.getElementById('batchDeleteRoutesBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="routeId"]:checked').forEach(function(cb) {
            selectedIds.push(cb.value);
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的路线');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '个路线吗？')) {
            fetch('${pageContext.request.contextPath}/route/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({routeIds: selectedIds})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchRoutes();
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
        const checkedCount = document.querySelectorAll('input[name="routeId"]:checked').length;
        document.getElementById('batchDeleteRoutesBtn').disabled = checkedCount === 0;
    }
    function fetchRoutes() {
        fetch('${pageContext.request.contextPath}/route/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('routesTable');
                    tableBody.innerHTML = '';

                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        //row.innerHTML = '<td colspan="5" class="text-center">暂无路线数据</td>';
                        //路线简介
                        row.innerHTML = '<td colspan="6" class="text-center">暂无路线数据</td>';
                        //路线简介
                        tableBody.appendChild(row);
                        return;
                    }

                    data.data.forEach(function(route) {
                        var row = document.createElement('tr');

                        // ID列
                        var idCell = document.createElement('td');
                        idCell.textContent = route.id;
                        row.appendChild(idCell);

                        // 封面列
                        var coverCell = document.createElement('td');
                        if (route.coverImage) {
                            <%--var img = document.createElement('img');--%>
                            <%--img.style.maxHeight = '50px';--%>
                            <%--img.className = 'img-thumbnail';--%>

                            <%--// 一次性加载尝试--%>
                            <%--img.onerror = function() {--%>
                            <%--    this.src = '${pageContext.request.contextPath}/assets/images/default-route.jpg';--%>
                            <%--    this.onerror = null;--%>
                            <%--};--%>

                            <%--img.src = '${pageContext.request.contextPath}/' + route.coverImage;--%>
                            <%--coverCell.appendChild(img);--%>
                            console.log("sss"+route.coverImage)
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + route.coverImage;
                            console.log("sss2"+'${pageContext.request.contextPath}/')
                            img.onerror = function() {
                                this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                                this.onerror = null;
                            };
                            coverCell.appendChild(img);
                        } else {
                            coverCell.textContent = '无封面';
                        }
                        row.appendChild(coverCell);

                        // 名称列
                        var nameCell = document.createElement('td');
                        nameCell.textContent = route.name;
                        row.appendChild(nameCell);

                        // 路线简介列
                        var descriptionCell = document.createElement('td');
                        descriptionCell.appendChild(createDescriptionCell(route.description || 'N/A'));
                        row.appendChild(descriptionCell);



                        // 点赞数列
                        var likeCell = document.createElement('td');
                        likeCell.textContent = route.likeCount || 0;
                        row.appendChild(likeCell);

                        // 操作列
                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditRouteModal(route.id);
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteRoute(route.id);
                        };
                        actionCell.appendChild(deleteBtn);

                        row.appendChild(actionCell);
                        // 添加复选框
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'routeId';
                        checkbox.value = route.id;
                        checkbox.className = 'route-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取路线数据失败:', data.message);
                    const tableBody = document.getElementById('routesTable');
                    // tableBody.innerHTML = '<tr><td colspan="5" class="text-center">加载路线数据失败</td></tr>';
                    //路线简介
                    tableBody.innerHTML = '<tr><td colspan="6" class="text-center">加载路线数据失败</td></tr>';
                    //路线简介
                }
            })
            .catch(error => {
                console.error('获取路线数据出错:', error);
                const tableBody = document.getElementById('routesTable');
                // tableBody.innerHTML = '<tr><td colspan="5" class="text-center">加载路线数据出错</td></tr>';
                //路线简介
                tableBody.innerHTML = '<tr><td colspan="6" class="text-center">加载路线数据出错</td></tr>';
                //路线简介
            });
    }
    function createDescriptionCell(description) {
        const container = document.createElement('div');
        container.className = 'description-container';

        const preview = document.createElement('div');
        preview.className = 'description-preview';
        preview.textContent = description || 'N/A';
        container.appendChild(preview);

        const full = document.createElement('div');
        full.className = 'description-full';
        full.textContent = description || 'N/A';
        container.appendChild(full);

        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'toggle-description';
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

    function addRoute() {
        const form = document.getElementById('addRouteForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/route/add', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('路线添加成功');
                    fetchRoutes();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addRouteModal'));
                    modal.hide();
                    form.reset();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error adding route:', error);
                alert('添加路线失败');
            });
    }

    function showEditRouteModal(routeId) {
        fetch('${pageContext.request.contextPath}/route/' + routeId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('获取路线详情失败');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const route = data.data;
                    const form = document.getElementById('editRouteForm');

                    form.querySelector('[name="id"]').value = route.id;
                    form.querySelector('[name="name"]').value = route.name;
                    form.querySelector('[name="description"]').value = route.description || '';
                    const imgPreview = document.getElementById('currentRouteImage');
                    if (route.coverImage) {
                        imgPreview.src = '${pageContext.request.contextPath}/' + route.coverImage;
                        imgPreview.style.display = 'block';
                        imgPreview.onerror = function() {
                            this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                            this.onerror = null;
                        };
                    } else {
                        imgPreview.style.display = 'none';
                    }

                    const modal = new bootstrap.Modal(document.getElementById('editRouteModal'));
                    modal.show();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error fetching route:', error);
                alert('获取路线详情失败');
            });
    }
    function updateRoute() {
        const form = document.getElementById('editRouteForm');
        const formData = new FormData(form);

        // 确保id参数被正确添加
        const routeId = form.querySelector('[name="id"]').value;
        if (!routeId) {
            alert('路线ID不能为空');
            return;
        }

        // 显示加载状态
        const saveBtn = document.querySelector('#editRouteModal .btn-danger');
        const originalText = saveBtn.innerHTML;
        saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> 处理中...';
        saveBtn.disabled = true;

        // 打印表单数据用于调试
        for (let [key, value] of formData.entries()) {
            console.log(key + ': ' + value);
        }

        fetch('${pageContext.request.contextPath}/route/update', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                console.log('响应状态:', response.status);
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`HTTP ${response.status}: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
                console.log('响应数据:', data);
                if (data.code === 200) {
                    alert('路线更新成功');
                    fetchRoutes();
                    $('#editRouteModal').modal('hide');
                } else {
                    throw new Error(data.message || '更新失败');
                }
            })
            .catch(error => {
                console.error('详细错误:', error);
                alert('更新失败: ' + error.message);
            })
            .finally(() => {
                saveBtn.innerHTML = originalText;
                saveBtn.disabled = false;
            });
    }

    function deleteRoute(routeId) {
        if (confirm('确定要删除这条路线吗？')) {
            fetch('${pageContext.request.contextPath}/route/delete/' + routeId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('路线删除成功');
                        fetchRoutes();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting route:', error);
                    alert('删除路线失败');
                });
        }
    }

    <!-- 搜索框 -->
    function filterRoutes() {
        const searchDescription = document.getElementById('searchRouteDescription').value.toLowerCase();

        const tableRows = document.querySelectorAll('#routesTable tr');
        tableRows.forEach(function(row) {
            const descriptionCell = row.querySelector('td:nth-child(4)');
            if (descriptionCell) {
                const descriptionText = descriptionCell.textContent.toLowerCase();
                if (descriptionText.includes(searchDescription)) {
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
