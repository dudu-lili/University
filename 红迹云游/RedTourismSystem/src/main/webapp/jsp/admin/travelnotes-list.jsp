<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>游记论坛 - 红色旅游系统</title>
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
                <a class="nav-link  active" href="travelnotes-list.jsp">
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
        <h3>游记论坛</h3>
    </div>
    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchPlace" placeholder="按地点搜索">
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchAuthor" placeholder="按作者搜索">
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="searchTitle" placeholder="按标题搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterTravelNotesSpots()">搜索</button>
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
                        <th style="width: 100px;">头图</th>
                        <th style="width: 100px;">标题</th>
                        <th style="width: 80px;">作者</th>
                        <th style="width: 80px;">浏览数</th>
                        <th style="width: 80px;">收藏数</th>
                        <th style="width: 150px;">内容</th>
                        <th style="width: 80px;">地点</th>

                        <th style="width: 80px;">时间</th>
<%--                        <th style="width: 80px;">图片</th>--%>
                        <th style="width: 100px;">操作</th>
                    </tr>
                    </thead>
                    <tbody id="travelNotesSpotsTable">
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>


<!-- 修改景点模态框 -->
<div class="modal fade" id="editTravelNotesSpotModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改内容</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editTravelNotesSpotForm" enctype="multipart/form-data">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">标题</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">图片</label>
                        <input type="file" class="form-control" name="banImage" accept="image/*">
                        <div class="mt-2">
                            <div id="imageLoading" class="text-center" style="display: none;">
                                <div class="spinner-border spinner-border-sm" role="status">
                                    <span class="visually-hidden">加载中...</span>
                                </div>
                            </div>
                            <img id="currentBanImage"
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
                    </div>
                    <div class="mb-3">
                        <label class="form-label">地点</label>
                        <input type="text" class="form-control" name="place">
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="updateTravelNotesSpot()">保存</button>
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
        fetchTravelNotesSpots();
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



    function fetchTravelNotesSpots() {
        fetch('${pageContext.request.contextPath}/travelNotes/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const tableBody = document.getElementById('travelNotesSpotsTable');
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
                        if (spot.banImage) {
                            var img = document.createElement('img');
                            img.style.maxHeight = '50px';
                            img.className = 'img-thumbnail';
                            img.src = '${pageContext.request.contextPath}/' + spot.banImage;
                            coverCell.appendChild(img);
                        } else {
                            coverCell.textContent = '无图片';
                        }
                        row.appendChild(coverCell);

                        // 标题列

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

                        // 收藏数列
                        var favoriteCell = document.createElement('td');
                        favoriteCell.textContent = spot.favoriteCount || 0;
                        row.appendChild(favoriteCell);

                        // 内容列
                        var contentCell = document.createElement('td');

                        contentCell.appendChild(createContentCell(extractTextFromHTML(spot.content || 'N/A')));
                        row.appendChild(contentCell);

                        // 地点列
                        var placeCell = document.createElement('td');
                        placeCell.textContent = spot.place || 'N/A';
                        row.appendChild(placeCell);

                        // 时间列
                        var timeCell = document.createElement('td');
                        timeCell.textContent = spot.createtime || 'N/A';
                        row.appendChild(timeCell);

                        // // 图片列
                        // var imagesCell = document.createElement('td');
                        // imagesCell.appendChild(createContentCell(spot.images || 'N/A'));
                        // row.appendChild(imagesCell);

                        // 操作列
                        var actionCell = document.createElement('td');

                        var editBtn = document.createElement('button');
                        editBtn.className = 'btn btn-primary btn-sm me-2';
                        editBtn.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editBtn.onclick = function() {
                            showEditTravelNotesSpotModal(spot.id);
                            console.log("id:" + spot.id)
                        };
                        actionCell.appendChild(editBtn);

                        var deleteBtn = document.createElement('button');
                        deleteBtn.className = 'btn btn-danger btn-sm';
                        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteBtn.onclick = function() {
                            deleteTravelNotesSpot(spot.id);
                        };
                        actionCell.appendChild(deleteBtn);

                        row.appendChild(actionCell);
                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('获取数据失败:', data.message);
                    const tableBody = document.getElementById('travelNotesSpotsTable');
                    tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载数据失败</td></tr>';
                }
            })
            .catch(error => {
                console.error('获取数据出错:', error);
                const tableBody = document.getElementById('travelNotesSpotsTable');
                tableBody.innerHTML = '<tr><td colspan="12" class="text-center">加载数据出错</td></tr>';
            });
    }

    function extractTextFromHTML(htmlContent) {
        // 创建一个临时的div元素
        const tempDiv = document.createElement('div');
        // 将HTML内容赋给它的innerHTML
        tempDiv.innerHTML = htmlContent;
        // 通过textContent获取纯文本内容
        return tempDiv.textContent || tempDiv.innerText || '';
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


    function showEditTravelNotesSpotModal(spotId) {
        fetch('${pageContext.request.contextPath}/travelNotes/' + spotId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('获取详情失败');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    const spot = data.data;
                    const form = document.getElementById('editTravelNotesSpotForm');

                    form.querySelector('[name="id"]').value = spot.id;
                    form.querySelector('[name="title"]').value = spot.title;
                    form.querySelector('[name="author"]').value = spot.author || '';
                    form.querySelector('[name="content"]').value = spot.content || '';
                    form.querySelector('[name="place"]').value = spot.place || '';

                    const imgPreview = document.getElementById('currentBanImage');

                    // 重置图片状态
                    imgPreview.onerror = null;
                    imgPreview.style.display = 'none';

                    if (spot.banImage) {
                        // 设置一次性加载尝试
                        imgPreview.onerror = function() {
                            this.style.display = 'none';
                            this.onerror = null; // 防止无限循环
                        };

                        // 设置图片源
                        imgPreview.src = '${pageContext.request.contextPath}/' + spot.banImage;
                        imgPreview.style.display = 'block';
                    }

                    const modal = new bootstrap.Modal(document.getElementById('editTravelNotesSpotModal'));
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

    function updateTravelNotesSpot() {
        const form = document.getElementById('editTravelNotesSpotForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/travelNotes/update', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('修改成功');
                    fetchTravelNotesSpots();
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editTravelNotesSpotModal'));
                    modal.hide();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error updating TravelNotes spot:', error);
                alert('修改失败');
            });
    }

    function deleteTravelNotesSpot(spotId) {
        if (confirm('确定要删除这个内容吗？')) {
            fetch('${pageContext.request.contextPath}/TravelNotes/delete/' + spotId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchTravelNotesSpots();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting TravelNotes spot:', error);
                    alert('删除失败');
                });
        }
    }



    // 搜索框
    function filterTravelNotesSpots() {
        const place = document.getElementById("searchPlace").value.trim().toLowerCase();
        const author = document.getElementById("searchAuthor").value.trim().toLowerCase();
        const title = document.getElementById("searchTitle").value.trim().toLowerCase();
        const rows = document.querySelectorAll("#travelNotesSpotsTable tr");

        rows.forEach(row => {
            const PlaceText = row.cells[7].textContent.toLowerCase(); // 地点列
            const AuthorText = row.cells[3].textContent.toLowerCase(); // 作者列
            const TitleText = row.cells[2].textContent.toLowerCase();  // 标题列

            const matchesPlace = place === "" || PlaceText.includes(place);
            const matchesAuthor = author === "" || AuthorText.includes(author);
            const matchesTitle = title === "" || TitleText.includes(title);

            row.style.display = (matchesPlace && matchesAuthor && matchesTitle) ? "" : "none";
        });
    }
</script>

</body>
</html>