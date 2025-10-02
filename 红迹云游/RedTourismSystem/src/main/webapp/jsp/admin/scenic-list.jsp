<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>景点管理 - 红色旅游系统</title>
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
        /* 修改描述容器样式 */
        .description-container {
            position: relative;
            min-height: 40px;
            padding-bottom: 20px;
            width: 150px;
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
        .mb-4 {
            margin-bottom: 0.1rem !important;
            height: 61px;
        }
        .scenic-checkbox {
            transform: scale(1.5); /* 增加复选框的大小 */
            margin-top: 12px;
        }
    </style>
</head>
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
                <a class="nav-link active" href="scenic-list.jsp">
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


<!-- 主内容区 -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>景点管理</h3>
        <div class="ms-auto">
            <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#addScenicSpotModal">
                <i class="bi bi-plus"></i> 添加景点
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
                    <input type="text" class="form-control" id="searchProvince" placeholder="按省份搜索">
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchCity" placeholder="按城市搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchName" placeholder="按景点名称搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterScenicSpots()">搜索</button>
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
                        <th style="width: 100px;">封面</th>
                        <th style="width: 150px;">景点名称</th>
                        <th style="width: 150px;">地址</th>
                        <th style="width: 80px;">点赞数</th>
                        <th style="max-width: 150px;">简介</th>
                        <th style="width: 80px;">等级</th>
                        <th style="width: 120px;">省份</th>
                        <th style="width: 120px;">城市</th>
                        <th style="width: 120px;">开放时间</th>
                        <th style="width: 100px;">门票信息</th>
                        <th style="width: 150px;">关键词</th>
                        <th style="width: 100px;">操作</th>
                        <th>
                            全选  <input type="checkbox" id="selectAll" onclick="selectAllScenics(this)">
                        </th>

                    </tr>
                    </thead>
                    <tbody id="scenicSpotsTable">
                    <td>
                        <input type="checkbox" class="scenic-checkbox" name="scenicId" value="${spot.id}">
                    </td>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 添加景点模态框 -->
<div class="modal fade" id="addScenicSpotModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加景点</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addScenicSpotForm" enctype="multipart/form-data" method="post">
                    <div class="mb-3">
                        <label class="form-label">景点名称</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">景点描述</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">景点地址</label>
                        <input type="text" class="form-control" name="address">
                    </div>

                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    <div class="mb-3">
                        <label class="form-label">等级</label>
                        <input type="text" class="form-control" name="level">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">省份</label>
                        <input type="text" class="form-control" name="province">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">城市</label>
                        <input type="text" class="form-control" name="city">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">开放时间</label>
                        <input type="text" class="form-control" name="openningHours">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">门票信息</label>
                        <input type="text" class="form-control" name="ticketInfo">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">关键词</label>
                        <input type="text" class="form-control" name="keywords">
                    </div>
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addScenicSpot()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改景点模态框 -->
<div class="modal fade" id="editScenicSpotModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改景点</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editScenicSpotForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">景点名称</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">封面图片</label>
                        <input type="file" class="form-control" name="coverImage">
                        <div class="mt-2">
                            <img id="currentCoverImage"
                                 src=""
                                 style="max-height: 150px; display: none;"
                                 class="img-thumbnail">
                            <div id="imageLoading" style="display: none;">加载中...</div>
                            <div id="imageError" style="display: none; color: red;">图片加载失败</div>
                           </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">景点描述</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">景点地址</label>
                        <input type="text" class="form-control" name="address">
                    </div>

                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    <div class="mb-3">
                        <label class="form-label">等级</label>
                        <input type="text" class="form-control" name="level">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">省份</label>
                        <input type="text" class="form-control" name="province">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">城市</label>
                        <input type="text" class="form-control" name="city">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">开放时间</label>
                        <input type="text" class="form-control" name="openningHours">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">门票信息</label>
                        <input type="text" class="form-control" name="ticketInfo">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">关键词</label>
                        <input type="text" class="form-control" name="keywords">
                    </div>
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateScenicSpot()">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchScenicSpots();
    });
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
    function fetchScenicSpots() {
        fetch('${pageContext.request.contextPath}/scenic/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('scenicSpotsTable');
                    tableBody.innerHTML = '';

                    if (!data.data || data.data.length === 0) {
                        const row = document.createElement('tr');
                        <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                        // row.innerHTML = '<td colspan="6" class="text-center">暂无景点数据</td>';
                        row.innerHTML = '<td colspan="12" class="text-center">暂无景点数据</td>';
                        <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
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
                            // 修改图片显示部分
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + spot.coverImage;
                            img.onerror = function() {
                                this.src = '${pageContext.request.contextPath}/assets/images/default-avatar1.png';
                                this.onerror = null;
                            };
                            coverCell.appendChild(img);
                        } else {
                            coverCell.textContent = '无封面';
                        }
                        row.appendChild(coverCell);

                        // 其他列保持不变...
                        var nameCell = document.createElement('td');
                        nameCell.textContent = spot.name;
                        row.appendChild(nameCell);

                        var addressCell = document.createElement('td');
                        addressCell.textContent = spot.address || 'N/A';
                        row.appendChild(addressCell);

                        var likeCell = document.createElement('td');
                        likeCell.textContent = spot.likeCount || 0;
                        row.appendChild(likeCell);

                        <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                        // var descriptionCell = document.createElement('td');
                        // descriptionCell.textContent = spot.description || 'N/A';
                        // row.appendChild(descriptionCell);
                        <!-- 简介列 -->
                        var descriptionCell = document.createElement('td');
                        descriptionCell.appendChild(createDescriptionCell(spot.description));
                        row.appendChild(descriptionCell);


                        var levelCell = document.createElement('td');
                        levelCell.textContent = spot.level || 'N/A';
                        row.appendChild(levelCell);

                        var provinceCell = document.createElement('td');
                        provinceCell.textContent = spot.province || 'N/A';
                        row.appendChild(provinceCell);

                        var cityCell = document.createElement('td');
                        cityCell.textContent = spot.city || 'N/A';
                        row.appendChild(cityCell);

                        // var openningHoursCell = document.createElement('td');
                        // openningHoursCell.textContent = spot.openningHours || 'N/A';
                        // row.appendChild(openningHoursCell);
                        // 开放时间列
                        var openningHoursCell = document.createElement('td');
                        openningHoursCell.appendChild(createDescriptionCell(spot.openningHours || 'N/A'));
                        row.appendChild(openningHoursCell);

                        var ticketInfoCell = document.createElement('td');
                        ticketInfoCell.textContent = spot.ticketInfo || 'N/A';
                        row.appendChild(ticketInfoCell);
                        // 关键词列
                        var keywordsCell = document.createElement('td');
                        keywordsCell.appendChild(createDescriptionCell(spot.keywords || 'N/A'));
                        row.appendChild(keywordsCell);

                        // var keywordsCell = document.createElement('td');
                        // keywordsCell.textContent = spot.keywords || 'N/A';
                        // row.appendChild(keywordsCell);

                        <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->


                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditScenicSpotModal(spot.id);
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteScenicSpot(spot.id);
                        };
                        actionCell.appendChild(deleteBtn);
                        row.appendChild(actionCell);

                        // 添加复选框4.29
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'scenicId';
                        checkbox.value = spot.id;
                        checkbox.className = 'scenic-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取景点数据失败:', data.message);
                    const tableBody = document.getElementById('scenicSpotsTable');
                    // tableBody.innerHTML = '<tr><td colspan="6" class="text-center">加载景点数据失败</td></tr>';
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载景点数据失败</td></tr>';
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                }
            })
            .catch(error => {
                console.error('获取景点数据出错:', error);
                const tableBody = document.getElementById('scenicSpotsTable');
                <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载景点数据出错</td></tr>';
                <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                //tableBody.innerHTML = '<tr><td colspan="6" class="text-center">加载景点数据出错</td></tr>';
            });
    }

    function addScenicSpot() {
        const form = document.getElementById('addScenicSpotForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/scenic/add', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('景点添加成功');
                    fetchScenicSpots();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addScenicSpotModal'));
                    modal.hide();
                    form.reset();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error adding scenic spot:', error);
                alert('添加景点失败');
            });
    }

    function showEditScenicSpotModal(spotId) {
        fetch('${pageContext.request.contextPath}/scenic/' + spotId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('获取景点详情失败');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const spot = data.data;
                    const form = document.getElementById('editScenicSpotForm');

                    form.querySelector('[name="id"]').value = spot.id;
                    form.querySelector('[name="name"]').value = spot.name;
                    form.querySelector('[name="description"]').value = spot.description || '';
                    form.querySelector('[name="address"]').value = spot.address || '';
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
                    form.querySelector('[name="level"]').value = spot.level || '';
                    form.querySelector('[name="province"]').value = spot.province || '';
                    form.querySelector('[name="city"]').value = spot.city || '';
                    form.querySelector('[name="openningHours"]').value = spot.openningHours || '';
                    form.querySelector('[name="ticketInfo"]').value = spot.ticketInfo || '';
                    form.querySelector('[name="keywords"]').value = spot.keywords || '';
                    <!-- 等级、省份、城市、开放时间、门票信息、关键词 -->
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

                    const modal = new bootstrap.Modal(document.getElementById('editScenicSpotModal'));
                    modal.show();
                } else {
                    alert('获取景点详情失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('获取景点详情出错:', error);
                alert('获取景点详情出错，请稍后重试');
            });
    }

    function updateScenicSpot() {
        const formData = new FormData(document.getElementById('editScenicSpotForm'));

        fetch('${pageContext.request.contextPath}/scenic/update', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP错误!`);
                }
                return response.json();
            })
            .then(data => {
                if(data.code === 200) {
                    alert('更新成功');
                    // $('#editScenicSpotModal').modal('hide');
                    location.reload();
                } else {
                    throw new Error(data.message || '更新失败');
                }
            })
            .catch(error => {
                console.error('错误:', error);
                alert('更新失败: ' + error.message);
            });
    }




    function deleteScenicSpot(spotId) {
        if (confirm('确定要删除这个景点吗？')) {
            fetch('${pageContext.request.contextPath}/scenic/delete/' + spotId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('景点删除成功');
                        fetchScenicSpots();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting scenic spot:', error);
                    alert('删除景点失败');
                });
        }
    }

    <!-- 搜索框 -->
    function filterScenicSpots() {
        const province = document.getElementById("searchProvince").value.trim().toLowerCase();
        const city = document.getElementById("searchCity").value.trim().toLowerCase();
        const name = document.getElementById("searchName").value.trim().toLowerCase();

        const rows = document.querySelectorAll("#scenicSpotsTable tr");

        rows.forEach(row => {
            const provinceText = row.children[7].textContent.toLowerCase(); // 省份列
            const cityText = row.children[8].textContent.toLowerCase();     // 城市列
            const nameText = row.children[2].textContent.toLowerCase();     // 景点名称列

            const matchesProvince = province === "" || provinceText.includes(province);
            const matchesCity = city === "" || cityText.includes(city);
            const matchesName = name === "" || nameText.includes(name);

            row.style.display = (matchesProvince && matchesCity && matchesName) ? "" : "none";
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

    document.addEventListener("DOMContentLoaded", function() {
        fetchScenicSpots();

        // 使用事件委托绑定点击事件
        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('toggle-description')) {
                console.log('Toggle button clicked via event delegation'); // 调试信息
                const container = event.target.parentElement;
                const preview = container.querySelector('.description-preview');
                const full = container.querySelector('.description-full');
                const toggleBtn = container.querySelector('.toggle-description');

                container.classList.toggle('expanded');
                toggleBtn.textContent = container.classList.contains('expanded') ? '收起' : '显示更多';
            }
        });
    });
    // 4/29全选/取消全选景点
    // 全选/取消全选景点
    function selectAllScenics(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="scenicId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn();
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.classList.contains('scenic-checkbox')) {
            updateBatchDeleteBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAll').checked = false;
            }
        }
    });

    // 批量删除按钮点击事件
    document.getElementById('batchDeleteBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="scenicId"]:checked').forEach(function(cb) {
            selectedIds.push(cb.value);
        });

        if (confirm('确定要删除选中的' + selectedIds.length + '个景点吗？')) {
            fetch('${pageContext.request.contextPath}/scenic/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({scenicIds: selectedIds})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        location.reload();
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
        const checkedCount = document.querySelectorAll('input[name="scenicId"]:checked').length;
        document.getElementById('batchDeleteBtn').disabled = checkedCount === 0;
    }

</script>
</body>
</html>
