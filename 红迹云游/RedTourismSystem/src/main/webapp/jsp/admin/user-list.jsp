<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理 - 红色旅游系统</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<%--    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.1/dist/echarts.min.js"></script>--%>
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
        .user-checkbox {
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
                <a class="nav-link active" href="user-list.jsp">
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
<!-- 搜索框 -->

<!-- 主内容区 -->
<div class="main-content">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>用户管理</h3>
        <div class="ms-auto">
            <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#addUserModal">
                <i class="bi bi-plus"></i> 添加用户
            </button>
            <button class="btn btn-danger" id="batchDeleteUserBtn" disabled onclick="batchDeleteUsers()">
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
    </div>
    <!-- 搜索框 -->
    <!-- 搜索框 -->
    <div class="card mb-3">
        <div class="card-body">
            <form id="searchForm" class="row g-3 justify-content-center" style="max-width: 1200px; margin: 0 auto;">
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchEamil" placeholder="账号">
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="searchNickname" placeholder="昵称">
                </div>
<%--                <div class="col-md-2">--%>
<%--                    <input type="text" class="form-control" id="searchPhone" placeholder="手机号">--%>
<%--                </div>--%>
                <div class="col-md-2">
                    <select class="form-select" id="searchStatus">
                        <option value="">全部状态</option>
                        <option value="1">正常</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger w-100" onclick="filterUsers()"><i class="bi bi-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;搜索</button>

<%--                    <button type="button" class="btn btn-danger w-100" onclick="filterRoutes()">搜索</button>--%>
                </div>
            </form>
        </div>
    </div>
<%--    <div class="card mb-3">--%>
    <!-- 用户表格 -->
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between">
                <h5 class="mb-0">用户列表</h5>

            </div>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>账号</th>
                    <th>昵称</th>
                    <th>状态</th>
                    <th>注册时间</th>
                    <th>操作</th>
                    <th>
                        全选  <input type="checkbox" id="selectAll" onclick="selectAllUsers(this)">
                    </th>
                </tr>
                </thead>
                <tbody id="usersTable">
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.email}</td>
                        <td>${user.nickname}</td>
                        <td>${user.status == 1 ? '正常' : '禁用'}</td>
                        <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteUser(${user.id})">删除</button>
                        </td>
                        <td>
                            <input type="checkbox" name="userId" value="${user.id}">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>
    </div>


<!-- 添加用户模态框 -->
<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加用户</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addUserForm">
                    <div class="mb-3">
                        <label class="form-label">账号</label>
                        <input type="text" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">密码</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">昵称</label>
                        <input type="text" class="form-control" name="nickname">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="addUser()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户模态框 -->
<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改用户</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" name="id">
                    <div class="mb-3">
                        <label class="form-label">账号</label>
                        <input type="text" class="form-control" name="email" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">密码</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">昵称</label>
                        <input type="text" class="form-control" name="nickname">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="submitEditForm()">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        fetchUsers();
    });
    function fetchUsers() {
        fetch('${pageContext.request.contextPath}/user/getAll')
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    const usersTable = document.getElementById('usersTable');
                    usersTable.innerHTML = '';
                    data.data.forEach(function(user) {
                        console.log("数据",user);
                        var row = document.createElement('tr');

                        // ID列
                        var cell1 = document.createElement('td');
                        cell1.textContent = user.id;
                        row.appendChild(cell1);

                        // 用户名列
                        var cell2 = document.createElement('td');
                        cell2.textContent = user.email;
                        row.appendChild(cell2);

                        // 昵称列
                        var cell3 = document.createElement('td');
                        cell3.textContent = user.nickname || 'N/A';
                        row.appendChild(cell3);

                        // // 手机号列
                        // var cell4 = document.createElement('td');
                        // cell4.textContent = user.phone || 'N/A';
                        // row.appendChild(cell4);

                        // 状态列
                        var cell4 = document.createElement('td');
                        var statusBadge = document.createElement('span');
                        statusBadge.className = user.status === 1 ? 'badge bg-success' : 'badge bg-danger';
                        statusBadge.textContent = user.status === 1 ? '正常' : '禁用';
                        cell4.appendChild(statusBadge);
                        row.appendChild(cell4);

                        // 注册时间列
                        var cell5 = document.createElement('td');
                        cell5.textContent = new Date(user.createTime).toLocaleString();
                        row.appendChild(cell5);

                        // 操作列
                        var cell6 = document.createElement('td');
                        var btnGroup = document.createElement('div');
                        btnGroup.className = 'btn-group btn-group-sm';

                        // 编辑按钮
                        var editButton = document.createElement('button');
                        editButton.className = 'btn btn-primary';
                        editButton.innerHTML = '<i class="bi bi-pencil"></i> 修改';
                        editButton.onclick = function() { showEditUserModal(user.id); };
                        btnGroup.appendChild(editButton);

                        // 状态切换按钮
                        var statusButton = document.createElement('button');
                        statusButton.className = user.status === 1 ? 'btn btn-warning' : 'btn btn-success';
                        statusButton.innerHTML = user.status === 1 ? '<i class="bi bi-lock"></i> 禁止' : '<i class="bi bi-unlock"></i> 启动';
                        statusButton.onclick = function() { toggleUserStatus(user.id, user.status); };
                        btnGroup.appendChild(statusButton);

                        // 删除按钮
                        var deleteButton = document.createElement('button');
                        deleteButton.className = 'btn btn-danger';
                        deleteButton.innerHTML = '<i class="bi bi-trash"></i> 删除';
                        deleteButton.onclick = function() { deleteUser(user.id); };
                        btnGroup.appendChild(deleteButton);

                        cell6.appendChild(btnGroup);
                        row.appendChild(cell6);
                        // 复选框列
                        var cell7 = document.createElement('td');
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'userId';
                        checkbox.value = user.id;
                        checkbox.className = 'user-checkbox';
                        cell7.appendChild(checkbox);
                        row.appendChild(cell7);

                        usersTable.appendChild(row);
                    });
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error fetching users:', error);
            });
    }

    function toggleUserStatus(userId, currentStatus) {
        const newStatus = currentStatus == 1 ? 0 : 1;
        const statusText = newStatus == 1 ? '启用' : '禁用';  // 获取状态文本

        // 修复确认提示
        if (confirm('确定要' + statusText + '该用户吗？')) {
            fetch(`${pageContext.request.contextPath}/user/updateStatus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    id: userId,
                    status: newStatus
                })
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('网络响应不正常');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.code == 200) {
                        // 修复成功提示
                        alert('用户已' + statusText);
                        fetchUsers();
                    } else {
                        throw new Error(data.message || '操作失败');
                    }
                })
                .catch(error => {
                    console.error('更新用户状态错误:', error);
                    alert('状态更新失败: ' + error.message);
                });
        }
    }

    function addUser() {
        var form = document.getElementById('addUserForm');
        var formData = new FormData(form);
        var data = {};
        formData.forEach(function(value, key) {
            data[key] = value;
        });

        fetch('${pageContext.request.contextPath}/user/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('用户添加成功');
                    fetchUsers();
                    var modal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
                    modal.hide();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error adding user:', error);
            });
    }

    function showEditUserModal(userId) {
        fetch('${pageContext.request.contextPath}/user/' + userId)
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    var user = data.data;
                    document.querySelector('#editUserForm [name="id"]').value = user.id;
                    document.querySelector('#editUserForm [name="email"]').value = user.email;
                    // document.querySelector('#editUserForm [name="password"]').value = user.password;
                    document.querySelector('#editUserForm [name="nickname"]').value = user.nickname;

                    // 使用Bootstrap的Modal API显示模态框
                    var editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
                    editModal.show();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error fetching user:', error);
            });
    }

    function submitEditForm() {
        var form = document.getElementById('editUserForm');
        var formData = new FormData(form);
        var data = {};
        formData.forEach(function(value, key) {
            data[key] = value;
        });

        fetch('${pageContext.request.contextPath}/user/edit', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('用户修改成功');
                    fetchUsers();
                    var modal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
                    modal.hide();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error editing user:', error);
            });
    }

    function deleteUser(userId) {
        if (confirm('确定要删除这个用户吗？')) {
            fetch('${pageContext.request.contextPath}/user/delete/' + userId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('用户删除成功');
                        fetchUsers();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error deleting user:', error);
                });
        }
    }
    // 全选/取消全选用户4.29
    function selectAllUsers(checkbox) {
        const checkboxes = document.querySelectorAll('input[name="userId"]');
        checkboxes.forEach(cb => cb.checked = checkbox.checked);
        updateBatchDeleteUserBtn();
    }

    // 更新批量删除按钮状态
    function updateBatchDeleteUserBtn() {
        const checkedCount = document.querySelectorAll('input[name="userId"]:checked').length;
        document.getElementById('batchDeleteUserBtn').disabled = checkedCount === 0;
    }


    // 批量删除用户
    function batchDeleteUsers() {
        const checkboxes = document.querySelectorAll('input[name="userId"]:checked');
        if (checkboxes.length === 0) {
            alert('请至少选择一条记录');
            return;
        }

        if (!confirm(`确定要删除选中的${checkboxes.length}条记录吗？`)) {
            return;
        }

        const userIds = Array.from(checkboxes).map(cb => cb.value);

        fetch('${pageContext.request.contextPath}/admin/user/batch-delete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({userIds: userIds})
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('删除成功');
                    window.location.reload();
                } else {
                    alert('删除失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('删除失败，请稍后再试');
            });
    }

    // 单个复选框变化时更新按钮状态
    document.addEventListener('change', function(event) {
        if (event.target.name === 'userId') {
            updateBatchDeleteUserBtn();
            // 如果取消某个复选框，取消全选状态
            if (!event.target.checked) {
                document.getElementById('selectAll').checked = false;
            }
        }
    });


    function logout() {
        fetch('../logout', {
            method: 'POST',
            credentials: 'same-origin' // 确保携带cookie/session
        })
            .then(response => {
                // 无论后端返回什么，都跳转到登录页
                window.location.href = '../user/login.jsp';
            })
            .catch(error => {
                console.error('退出登录失败:', error);
                window.location.href = '../login-admin.jsp';
            });
    }

    // ... 原有代码 ...

    function filterUsers() {
        const email = document.getElementById("searchEamil").value.trim().toLowerCase();
        const nickname = document.getElementById("searchNickname").value.trim().toLowerCase();
        const phone = document.getElementById("searchPhone").value.trim();
        const status = document.getElementById("searchStatus").value;

        const rows = document.querySelectorAll("#usersTable tr");

        rows.forEach(row => {
            const emailText = row.children[1].textContent.toLowerCase(); // 用户名列
            const nicknameText = row.children[2].textContent.toLowerCase(); // 昵称列
            const phoneText = row.children[3].textContent; // 手机号列
            const statusBadge = row.children[4].querySelector('.badge'); // 状态列中的badge元素

            // 获取状态值（1或0）
            const statusValue = statusBadge.textContent === '正常' ? '1' : '0';

            const matchesEmail = email === "" || emailText.includes(email);
            const matchesNickname = nickname === "" || nicknameText.includes(nickname);
            const matchesPhone = phone === "" || phoneText.includes(phone);
            const matchesStatus = status === "" || statusValue === status;

            row.style.display = (matchesEmail && matchesNickname && matchesPhone && matchesStatus) ? "" : "none";
        });
    }


</script>
</body>
</html>