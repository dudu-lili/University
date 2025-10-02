<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>红色旅游系统 - 个人中心</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        .section-title {
            color: #dc3545;
            margin: 30px 0 20px;
            font-weight: bold;
            border-left: 5px solid #dc3545;
            padding-left: 15px;
        }
        .card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-img-top {
            height: 180px;
            object-fit: cover;
        }
        .card-title {
            font-weight: bold;
            color: #333;
        }

        .nav-pills-button {
            background-color: #dc3545; /* 设置按钮底色 */
            color: white;
        }
        .nav-pills-button:hover {
            background-color: #ffc107; /* 鼠标悬停时的底色 */
            color: black;
        }
        .avatar-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .avatar-preview{
            width: 250px;
            height: 250px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }
        .carousel-inner {
            padding-top: 20px;
            position: relative;
            width: 100%;
            overflow: hidden;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <!-- 将文字替换为Logo图片 -->
        <a class="navbar-brand" href="index.jsp">
            <img src="${pageContext.request.contextPath}/assets/images/banners/logo2.png" alt="红色旅游" height="56">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">首页</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="scenicDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        景点信息
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="scenicDropdown">
                        <li><a class="dropdown-item" href="scenic-list.jsp">景点智选</a></li>
                        <li><a class="dropdown-item" href="scenic-list-recommend.jsp">景点智荐</a></li>
                        <li><a class="dropdown-item" href="red-Geocoding.jsp">全国景点地图展示</a></li>
                    </ul>
                </li>


                <li class="nav-item">
                    <a class="nav-link" href="route-list-recommend.jsp">路线智荐</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="studyDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        红色研学
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="routeDropdown">
                        <li><a class="dropdown-item" href="study-list.jsp">研学活动</a></li>
                        <li><a class="dropdown-item" href="video-list.jsp">影像课堂</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="travelnotes-list.jsp">游记论坛</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="news-list.jsp">新闻公告</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <img src="${pageContext.request.contextPath}/user/avatar/${user.id}?t=<%=System.currentTimeMillis()%>"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar1.png'"
                             class="avatar-circle"
                             alt="用户头像">
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="loadUserCenterData(event)">个人中心</a></li>
                        <li><a class="dropdown-item" href="#" onclick="logout()">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="section-title">个人中心</h3>
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="nav-link nav-pills-button" href="user-center.jsp">个人信息</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link nav-pills-button" href="user-center-scenic.jsp">我的景点收藏</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link nav-pills-button" href="user-center-route.jsp">我的路线收藏</a>
        </li>
        <li class="nav-item" role="presentation">

            <button class="nav-link active nav-pills-button" id="pills-travelnotes-favorites-tab" data-bs-toggle="pill" data-bs-target="#pills-travelnotes-favorites" type="button" role="tab" aria-controls="pills-travelnotes-favorites" aria-selected="true">我的游记收藏</button>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link nav-pills-button" href="user-center-comment.jsp">我的评论</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link nav-pills-button" href="user-center-mytravelnotes.jsp">我的游记</a>
        </li>
    </ul>
    <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade" id="pills-scenic-favorites" role="tabpanel">
            <h5 class="mb-4">我的景点收藏</h5>
            <div class="row">
                <c:forEach var="scenic" items="${favoriteScenics}">
                    <div class="col-md-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/${scenic.coverImage}" class="card-img-top" alt="${scenic.name}">
                            <div class="card-body">
                                <h6 class="card-title">${scenic.name}</h6>
                                <p class="card-text">ID: ${scenic.id}</p>
                                <div class="d-flex justify-content-between">
                                    <button class="btn btn-sm btn-outline-danger" onclick="unfavoriteScenic(${scenic.id})">取消收藏</button>
                                    <a href="scenic-list.jsp" class="btn btn-sm btn-outline-primary">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="tab-pane fade" id="pills-route-favorites" role="tabpanel">
            <h5 class="mb-4">我的路线收藏</h5>
            <div class="row">
                <c:forEach var="route" items="${favoriteRoutes}">
                    <div class="col-md-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/${route.coverImage}" class="card-img-top" alt="${route.name}">
                            <div class="card-body">
                                <h6 class="card-title">${route.name}</h6>
                                <p class="card-text">ID: ${route.id}</p>
                                <div class="d-flex justify-content-between">
                                    <button class="btn btn-sm btn-outline-danger" onclick="unfavoriteRoute(${route.id})">取消收藏</button>
                                    <a href="route-list.jsp" class="btn btn-sm btn-outline-primary">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="tab-pane fade  show active" id="pills-travelnotes-favorites" role="tabpanel">
            <h5 class="mb-4">我的游记收藏</h5>
            <div class="row">
                <c:forEach var="TravelNotes" items="${favoriteTravelNotes}">
                    <div class="col-md-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/${TravelNotes.banImage}" class="card-img-top" alt="${TravelNotes.title}">
                            <div class="card-body">
                                <h6 class="card-title">${TravelNotes.title}</h6>
                                <p class="card-text">ID: ${TravelNotes.id}</p>
                                <div class="d-flex justify-content-between">
                                    <button class="btn btn-sm btn-outline-danger" onclick="unfavoriteTravelNotes(${TravelNotes.id})">取消收藏</button>
                                    <a href="travelnotes-list.jsp" class="btn btn-sm btn-outline-primary">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="tab-pane fade" id="pills-comments" role="tabpanel">
            <h5 class="mb-4">我的评论</h5>
            <c:forEach var="comment" items="${commentList}">
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <h6>${comment.scenicId}</h6>
                            <small class="text-muted">${comment.createTime}</small>
                        </div>
                        <p class="card-text">${comment.content}</p>
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-sm btn-outline-danger me-2" onclick="deleteComment(${comment.id})">删除</button>
                            <a href="scenic-list.jsp" class="btn btn-sm btn-outline-primary">查看景点</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="tab-pane fade" id="pills-profile" role="tabpanel">
            <h5 class="mb-4">个人信息</h5>
            <div class="row">
                <div class="col-md-3 text-center">
                    <div class="avatar-container">
                        <img id="avatarPreview"
                             src="${pageContext.request.contextPath}/api/image/avatar/${user.id}"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar1.png'"
                             class="avatar-preview"
                        >
                        <button class="btn btn-sm btn-outline-danger avatar-upload-btn"
                                onclick="document.getElementById('avatarFile').click()">
                            <i class="bi bi-camera"></i> 修改头像
                        </button>
                        <input type="file" id="avatarFile" style="display:none" accept="image/*" onchange="uploadAvatar()">
                    </div>
                </div>
                <div class="col-md-9">
                    <form id="userInfoForm">
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">用户名</label>
                            <div class="col-sm-9">
                                <input type="text" readonly class="form-control-plaintext" value="${user.email}">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">昵称</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="nickname" value="${user.nickname}">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">性别</label>
                            <div class="col-sm-9">
                                <select class="form-select" name="gender">
                                    <option value="0" ${user.gender == 0 ? 'selected' : ''}>未知</option>
                                    <option value="1" ${user.gender == 1 ? 'selected' : ''}>男</option>
                                    <option value="2" ${user.gender == 2 ? 'selected' : ''}>女</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">生日</label>
                            <div class="col-sm-9">
                                <input type="date" class="form-control" name="birthday"
                                       value="${user.formattedBirthday}">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">手机号</label>
                            <div class="col-sm-9">
                                <input type="tel" class="form-control" name="phone" value="${user.phone}">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">地址</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="address" value="${user.address}">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">个性签名</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="signature" rows="3">${user.signature}</textarea>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">修改密码</label>
                            <div class="col-sm-9">
                                <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal"
                                        data-bs-target="#changePasswordModal">
                                    修改密码
                                </button>
                            </div>
                        </div>
                        <div class="text-center mt-4">
                            <button type="button" class="btn btn-danger me-2" onclick="updateUserInfo()">保存修改</button>
                            <button type="reset" class="btn btn-outline-secondary">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码模态框 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改密码</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="changePasswordForm">
                    <div class="mb-3">
                        <label class="form-label">原密码</label>
                        <input type="password" class="form-control" name="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新密码</label>
                        <input type="password" class="form-control" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">确认新密码</label>
                        <input type="password" class="form-control" name="confirmPassword" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="changePassword()">确认修改</button>
            </div>
        </div>
    </div>
</div>

<footer class="text-center">
    <div class="container">
        <p class="mb-0">© 2025 红色旅游系统 版权所有</p>
    </div>
</footer>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    // 在操作函数中记录当前激活的标签页
    function unfavoriteScenic(scenicId) {
        if (confirm('确定要取消收藏这个景点吗？')) {
            const userId = ${user.id};
            const activeTab = document.querySelector('.nav-pills .nav-link.active').getAttribute('id');
            localStorage.setItem('activeTab', activeTab);

            fetch('${pageContext.request.contextPath}/scenic/unfavorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ userId, scenicId })
            })
                .then(response => response.json())
        .then(data => {
                if (data.code === 200) {
                alert('取消收藏成功');
                window.location.reload();
            } else {
                alert('取消收藏失败：' + data.message);
            }
        })
        .catch(error => {
                console.error('Error:', error);
            alert('取消收藏失败，请稍后再试');
        });
        }
    }

    function unfavoriteRoute(routeId) {
        if (confirm('确定要取消收藏这个路线吗？')) {
            const userId = ${user.id};
            const activeTab = document.querySelector('.nav-pills .nav-link.active').getAttribute('id');
            localStorage.setItem('activeTab', activeTab);

            fetch('${pageContext.request.contextPath}/route/unfavorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ userId, routeId })
            })
                .then(response => response.json())
        .then(data => {
                if (data.code === 200) {
                alert('取消收藏成功');
                window.location.reload();
            } else {
                alert('取消收藏失败：' + data.message);
            }
        })
        .catch(error => {
                console.error('Error:', error);
            alert('取消收藏失败，请稍后再试');
        });
        }
    }

    function unfavoriteTravelNotes(travelNotesId) {
        if (confirm('确定要取消收藏这个游记吗？')) {
            const userId = ${user.id};
            const activeTab = document.querySelector('.nav-pills .nav-link.active').getAttribute('id');
            localStorage.setItem('activeTab', activeTab);

            fetch('${pageContext.request.contextPath}/travelNotes/unfavorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ userId, travelNotesId })
            })
                .then(response => response.json())
        .then(data => {
                if (data.code === 200) {
                alert('取消收藏成功');
                window.location.reload();
            } else {
                alert('取消收藏失败：' + data.message);
            }
        })
        .catch(error => {
                console.error('Error:', error);
            alert('取消收藏失败，请稍后再试');
        });
        }
    }

    function deleteComment(commentId) {
        if (confirm('确定要删除这条评论吗？')) {
            const activeTab = document.querySelector('.nav-pills .nav-link.active').getAttribute('id');
            localStorage.setItem('activeTab', activeTab);

            fetch('${pageContext.request.contextPath}/comment/' + commentId, { method: 'DELETE' })
                .then(response => response.json())
        .then(data => {
                if (data.code === 200) {
                alert('删除成功');
                window.location.reload();
            } else {
                alert('删除失败：' + data.message);
            }
        })
        .catch(error => {
                console.error('Error:', error);
            alert('删除失败，请稍后再试');
        });
        }
    }

    // 在页面加载时激活对应的标签页
    document.addEventListener('DOMContentLoaded', function() {
        const activeTab = localStorage.getItem('activeTab');
        if (activeTab) {
            const tabLink = document.getElementById(activeTab);
            if (tabLink) {
                const tabContent = document.querySelector(`#${tabLink.getAttribute('data-bs-target')}`);
                tabLink.classList.add('active');
                tabContent.classList.add('show', 'active');
            }
            localStorage.removeItem('activeTab');
        }
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

    function uploadAvatar() {
        const fileInput = document.getElementById('avatarFile');
        const file = fileInput.files[0];
        if (!file) {
            alert('请选择图片文件');
            return;
        }

        const formData = new FormData();
        formData.append('file', file);
        formData.append('userId', ${user.id});

        fetch('${pageContext.request.contextPath}/user/uploadAvatar', {
            method: 'POST',
            body: formData
        })
            .then(response => {
            if (response.ok) {
            return response.json();
        } else {
            throw new Error('上传失败');
        }
    })
    .then(data => {
            if (data.code === 200) {
            alert('上传成功');
            const avatarPreview = document.getElementById('avatarPreview');
            avatarPreview.src = '${pageContext.request.contextPath}/api/image/avatar/${user.id}?t=' + new Date().getTime();

            const navbarAvatar = document.querySelector('.navbar .avatar-circle');
            if (navbarAvatar) {
                navbarAvatar.src = '${pageContext.request.contextPath}/api/image/avatar/${user.id}?t=' + new Date().getTime();
            }
        } else {
            throw new Error(data.message || '上传失败');
        }
    })
    .catch(error => {
            console.error('上传错误:', error);
        alert('上传失败: ' + error.message);
    });
    }

    function changePassword() {
        const form = document.getElementById('changePasswordForm');
        const oldPassword = form.oldPassword.value;
        const newPassword = form.newPassword.value;
        const confirmPassword = form.confirmPassword.value;

        if (!oldPassword || !newPassword || !confirmPassword) {
            alert('请填写所有密码字段');
            return;
        }

        if (newPassword !== confirmPassword) {
            alert('两次输入的新密码不一致');
            return;
        }

        if (newPassword.length < 6) {
            alert('密码长度不能少于6位');
            return;
        }

        fetch('${pageContext.request.contextPath}/user/changePassword', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                oldPassword: oldPassword,
                newPassword: newPassword
            })
        })
            .then(response => response.json())
    .then(data => {
            if (data.code === 200) {
            alert('密码修改成功');
            $('#changePasswordModal').modal('hide');
            form.reset();
        } else {
            alert('密码修改失败: ' + data.message);
        }
    })
    .catch(error => {
            console.error('Error:', error);
        alert('密码修改失败');
    });
    }

    function updateUserInfo() {
        const form = document.getElementById('userInfoForm');
        const formData = new FormData(form);
        const userData = {};
        formData.forEach((value, key) => userData[key] = value);
        userData.id = ${user.id};

        if (userData.phone && !/^1[3-9]\d{9}$/.test(userData.phone)) {
            alert('请输入正确的手机号码');
            return;
        }

        fetch('${pageContext.request.contextPath}/user/update', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(userData)
        })
            .then(response => response.json())
    .then(data => {
            if (data.code === 200) {
            alert('信息更新成功');
            window.location.reload();
        } else {
            alert('信息更新失败: ' + data.message);
        }
    })
    .catch(error => {
            console.error('Error:', error);
        alert('信息更新失败');
    });
    }
</script>
</body>
</html>
