<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评论管理 - 红色旅游系统</title>
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
        .content-container {
            position: relative;
            min-height: 40px;
            padding-bottom: 20px;
            width: 100px;
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
            height: 65px;
            margin-top: 28px;
        }
        .comment-checkbox {
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
                <a class="nav-link active" href="comment-list.jsp">
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
        <h3>评论管理</h3>
        <div class="ms-auto">
            <button id="batchDeleteCommentsBtn" class="btn btn-danger" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>
    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 900px; margin: 0 auto;">
                <div class="col-md-4">
                    <input type="text" class="form-control" id="searchComment" placeholder="按评论内容搜索">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterComments()">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 评论表格 -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户ID</th>
                    <th>景点ID</th>
                    <th>路线ID</th>
                    <th>研学ID</th>
                    <th>评论内容</th>
                    <th>评论时间</th>
                    <th>操作</th>
                    <th>
                        全选 <input type="checkbox" id="selectAllComments" onclick="selectAllComments(this)">
                    </th>
                </tr>
                </thead>
                <tbody id="commentsTable">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchComments();
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
    // 全选/取消全选评论
    function selectAllComments(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="commentId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteBtn();
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.classList.contains('comment-checkbox')) {
            updateBatchDeleteBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAllComments').checked = false;
            }
        }
    });

    // 批量删除按钮点击事件
    document.getElementById('batchDeleteCommentsBtn').addEventListener('click', function() {
        const selectedIds = [];
        document.querySelectorAll('input[name="commentId"]:checked').forEach(function(cb) {
            selectedIds.push(cb.value);
        });

        if (selectedIds.length === 0) {
            alert('请选择要删除的评论');
            return;
        }

        if (confirm('确定要删除选中的' + selectedIds.length + '条评论吗？')) {
            fetch('${pageContext.request.contextPath}/comment/batch-delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({commentIds: selectedIds})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        fetchComments();
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
        const checkedCount = document.querySelectorAll('input[name="commentId"]:checked').length;
        document.getElementById('batchDeleteCommentsBtn').disabled = checkedCount === 0;
    }

    function fetchComments() {
        fetch('${pageContext.request.contextPath}/comment/getAll')
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    const commentsTable = document.getElementById('commentsTable');
                    commentsTable.innerHTML = '';
                    data.data.forEach(function(comment) {
                        var row = document.createElement('tr');

                        var cell1 = document.createElement('td');
                        cell1.textContent = comment.id;
                        row.appendChild(cell1);

                        var cell2 = document.createElement('td');
                        cell2.textContent = comment.userId;
                        row.appendChild(cell2);

                        var cell3 = document.createElement('td');
                        cell3.textContent = comment.scenicId || 'N/A';
                        row.appendChild(cell3);

                        var cell4 = document.createElement('td');
                        cell4.textContent = comment.routeId || 'N/A';
                        row.appendChild(cell4);

                        var cell5 = document.createElement('td');
                        cell5.textContent = comment.studyId || 'N/A';
                        row.appendChild(cell5);

                        var cell6 = document.createElement('td');
                        cell6.appendChild(createContentCell(comment.content)); // 使用 createDescriptionCell 函数
                        row.appendChild(cell6);

                        var cell7 = document.createElement('td');
                        cell7.textContent = new Date(comment.createTime).toLocaleString();
                        row.appendChild(cell7);

                        var cell8 = document.createElement('td');
                        var deleteButton = document.createElement('button');
                        deleteButton.className = 'btn btn-danger btn-sm ss';
                        deleteButton.textContent = '删除';
                        deleteButton.onclick = function() {
                            deleteComment(comment.id);
                        };
                        cell8.appendChild(deleteButton);
                        row.appendChild(cell8);
                        // 添加复选框
                        var checkboxCell = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'commentId';
                        checkbox.value = comment.id;
                        checkbox.className = 'comment-checkbox';
                        checkboxCell.appendChild(checkbox);
                        row.appendChild(checkboxCell);

                        commentsTable.appendChild(row);
                    });
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error fetching comments:', error);
            });
    }

    function createContentCell(content) {
        const container = document.createElement('div');
        container.className = 'content-container';

        const preview = document.createElement('div');
        preview.className = 'content-preview';
        preview.textContent = content ? content.slice(0, 50) + (content.length > 50 ? '...' : '') : 'N/A'; // 显示前50个字符
        container.appendChild(preview);

        const full = document.createElement('div');
        full.className = 'content-full';
        full.textContent = content || 'N/A';
        full.style.display = 'none'; // 初始状态下隐藏完整内容
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
            full.style.display = container.classList.contains('expanded') ? 'block' : 'none'; // 根据展开状态显示或隐藏完整内容
        };

        return container;
    }




    function deleteComment(commentId) {
        if (confirm('确定要删除这条评论吗？')) {
            fetch('${pageContext.request.contextPath}/comment/delete/' + commentId, {//修改后的删除路径
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('评论删除成功');
                        fetchComments();//刷新评论列表
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting comment:', error);
                });
        }
    }

    <!-- 搜索框 -->
    function filterComments() {
        const searchQuery = document.getElementById("searchComment").value.trim().toLowerCase();

        const rows = document.querySelectorAll("#commentsTable tr");

        rows.forEach(row => {
            const commentText = row.children[4].textContent.toLowerCase();//评论内容列

            const matchesSearchQuery = searchQuery === "" || commentText.includes(searchQuery);

            row.style.display = matchesSearchQuery ? "" : "none";
        });
    }
</script>
</body>
</html>