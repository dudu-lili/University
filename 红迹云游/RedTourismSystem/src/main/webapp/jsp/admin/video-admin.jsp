<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 2025/4/10
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>影像视频 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }
        .bg-dark1 {
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
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        .video-thumbnail {
            width: 120px;
            height: 68px;
            object-fit: cover;
            border-radius: 4px;
        }
        .route-checkbox {
            transform: scale(1.5);
            margin-top: 12px;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark1">
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
                <a class="nav-link" href="total.jsp">
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
                <a class="nav-link" href="route-list.jsp">
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
                <a class="nav-link active" href="video-admin.jsp">
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
        <h3>视频管理</h3>
        <div class="ms-auto">
            <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#addVideoModal">
                <i class="bi bi-plus"></i> 添加视频
            </button>
            <button id="batchDeleteVideosBtn" class="btn btn-danger" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>

    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-4">
                    <input type="text" class="form-control" id="searchVideoTitle" placeholder="按视频标题搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterVideos()">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 视频表格 -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>封面</th>
                    <th>视频标题</th>
                    <th>分类</th>
                    <th>观看数</th>
                    <th>点赞数</th>
                    <th>操作</th>
                    <th>
                        全选 <input type="checkbox" id="selectAllVideos" onclick="selectAllVideos(this)">
                    </th>
                </tr>
                </thead>
                <tbody id="videosTable">
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 添加视频模态框 -->
<div class="modal fade" id="addVideoModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加视频</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addVideoForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">视频标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频分类</label>
                        <select class="form-select" name="category" required>
                            <option value="">请选择分类</option>
                            <option value="红色教育">红色教育</option>
                            <option value="历史回顾">历史回顾</option>
                            <option value="革命故事">革命故事</option>
                            <option value="纪录片">纪录片</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频文件</label>
                        <input type="file" class="form-control" name="videoFile" accept="video/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频描述</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addVideo()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改视频模态框 -->
<div class="modal fade" id="editVideoModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改视频</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editVideoForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">视频标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频分类</label>
                        <select class="form-select" name="category" required>
                            <option value="红色教育">红色教育</option>
                            <option value="历史回顾">历史回顾</option>
                            <option value="革命故事">革命故事</option>
                            <option value="纪录片">纪录片</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*">
                        <div class="mt-2">
                            <img id="currentVideoImage"
                                 src="${pageContext.request.contextPath}/assets/images/default-video.jpg"
                                 style="max-height: 150px; display: none;"
                                 class="img-thumbnail">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频文件</label>
                        <input type="file" class="form-control" name="videoFile" accept="video/*">
                        <div class="mt-2">
                            <video id="currentVideoPlayer" controls style="max-width: 100%; display: none;">
                                <source id="currentVideoSource" src="" type="video/mp4">
                            </video>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">视频描述</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateVideo()">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchVideos();
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

    // 更新批量删除按钮状态
    function updateBatchDeleteBtn() {
        const checkedCount = document.querySelectorAll('input[name="videoId"]:checked').length;
        document.getElementById('batchDeleteVideosBtn').disabled = checkedCount === 0;
    }

    // 全选/取消全选视频
    function selectAllVideos(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="videoId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn(); // 调用更新函数
    }

    // 单个复选框状态变化时更新批量删除按钮
    document.addEventListener('change', function(event) {
        if (event.target.name === 'videoId') {
            updateBatchDeleteBtn(); // 当单个复选框状态变化时调用更新函数
        }
    });

    // 批量删除视频
    document.getElementById('batchDeleteVideosBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="videoId"]:checked').forEach(function(cb) {
            selectedIds.push(parseInt(cb.value));
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的视频');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '个视频吗？')) {
            fetch('${pageContext.request.contextPath}/video/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({videoIds: selectedIds})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchVideos();
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

    // 获取视频列表
    function fetchVideos() {
        fetch('${pageContext.request.contextPath}/video/list')
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('videosTable');
                    tableBody.innerHTML = '';

                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td colspan="8" class="text-center">暂无视频数据</td>';
                        tableBody.appendChild(row);
                        return;
                    }

                    data.data.forEach(function(video) {
                        const row = document.createElement('tr');

                        // ID列
                        const idCell = document.createElement('td');
                        idCell.textContent = video.id;
                        row.appendChild(idCell);

                        // 封面列
                        const coverCell = document.createElement('td');
                        if (video.coverImage) {
                            const img = document.createElement('img');
                            img.className = 'video-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + video.coverImage;
                            img.onerror = function() {
                                this.src = '${pageContext.request.contextPath}/assets/images/default-video.jpg';
                                this.onerror = null;
                            };
                            coverCell.appendChild(img);
                        } else {
                            coverCell.textContent = '无封面';
                        }
                        row.appendChild(coverCell);

                        // 标题列
                        const titleCell = document.createElement('td');
                        titleCell.textContent = video.title;
                        row.appendChild(titleCell);

                        // 分类列
                        const categoryCell = document.createElement('td');
                        categoryCell.textContent = video.category || '未分类';
                        row.appendChild(categoryCell);

                        // 观看数列
                        const viewsCell = document.createElement('td');
                        viewsCell.textContent = video.viewCount || 0;
                        row.appendChild(viewsCell);

                        // 点赞数列
                        const likesCell = document.createElement('td');
                        likesCell.textContent = video.likeCount || 0;
                        row.appendChild(likesCell);

                        // 操作列
                        const actionCell = document.createElement('td');

                        const editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditVideoModal(video.id);
                        };
                        actionCell.appendChild(editBtn);

                        const deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteVideo(video.id);
                        };
                        actionCell.appendChild(deleteBtn);

                        row.appendChild(actionCell);

                        // 复选框列
                        const checkboxCell = document.createElement('td');
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'videoId';
                        checkbox.value = video.id;
                        checkbox.className = 'route-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取视频数据失败:', data.message);
                    const tableBody = document.getElementById('videosTable');
                    tableBody.innerHTML = '<tr><td colspan="8" class="text-center">加载视频数据失败</td></tr>';
                }
            })
            .catch(error => {
                console.error('获取视频数据出错:', error);
                const tableBody = document.getElementById('videosTable');
                tableBody.innerHTML = '<tr><td colspan="8" class="text-center">加载视频数据出错</td></tr>';
            });
    }

    // 添加视频
    function addVideo() {
        const form = document.getElementById('addVideoForm');
        const formData = new FormData(form);

        // 检查必要字段是否已填写
        if (!formData.get('title') || !formData.get('category') || 
            !formData.get('coverImage') || !formData.get('videoFile')) {
            alert('请填写所有必填字段');
            return;
        }

        fetch('${pageContext.request.contextPath}/video/add', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('服务器返回错误');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('视频添加成功');
                    fetchVideos();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addVideoModal'));
                    modal.hide();
                } else {
                    alert('视频添加失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('视频添加失败，请检查控制台错误信息');
            });
    }

    // 修改视频
    function showEditVideoModal(videoId) {
        fetch('${pageContext.request.contextPath}/video/' + videoId)
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    const video = data.data;
                    const form = document.getElementById('editVideoForm');
                    form.elements['id'].value = video.id;
                    form.elements['title'].value = video.title;
                    form.elements['category'].value = video.category;
                    form.elements['description'].value = video.description;

                    // 显示当前封面图片
                    const currentImage = document.getElementById('currentVideoImage');
                    currentImage.src = '${pageContext.request.contextPath}/' + video.coverImage;
                    currentImage.style.display = 'block';

                    // 显示当前视频文件
                    const currentVideoPlayer = document.getElementById('currentVideoPlayer');
                    const currentVideoSource = document.getElementById('currentVideoSource');
                    currentVideoSource.src = '${pageContext.request.contextPath}/' + video.videoUrl;
                    currentVideoPlayer.style.display = 'block';

                    const modal = new bootstrap.Modal(document.getElementById('editVideoModal'));
                    modal.show();
                } else {
                    alert('获取视频信息失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('获取视频信息失败，请稍后再试');
            });
    }

    function updateVideo() {
        const form = document.getElementById('editVideoForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/video/update', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('视频修改成功');
                    fetchVideos();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editVideoModal'));
                    modal.hide();
                } else {
                    alert('视频修改失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('视频修改失败，请稍后再试');
            });
    }

    function deleteVideo(videoId) {
        if (confirm('确定要删除该视频吗？')) {
            fetch('${pageContext.request.contextPath}/video/delete/' + videoId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('视频删除成功');
                        fetchVideos();
                    } else {
                        alert('视频删除失败: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('视频删除失败，请稍后再试');
                });
        }
    }

    function batchDeleteVideos() {
        const selectedIds = [];
        document.querySelectorAll('input[name="videoId"]:checked').forEach(function(cb) {
            selectedIds.push(cb.value);
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的视频');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '个视频吗？')) {
            fetch('${pageContext.request.contextPath}/video/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({videoIds: selectedIds})
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('服务器返回错误');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('删除成功');
                    fetchVideos();
                } else {
                    alert('删除失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('删除失败，请稍后再试');
            });
        }
    }

</script>
</body>
</html>
