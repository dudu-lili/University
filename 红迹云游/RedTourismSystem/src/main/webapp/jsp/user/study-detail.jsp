<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<html>
<head>
    <title>研学详情 - 红色旅游系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/footer.css">
    <link rel="stylesheet" href="../../css/navbar.css">
    <style>
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }

        .study-title {
            color: #080808;
            text-align: center;
            margin-bottom: 1rem;
        }
        .section-title {
            color: #dc3545;
            margin: 2rem 0 1rem;
            font-weight: bold;
            /*border-left: 5px solid #dc3545;*/
            padding-left: 15px;
        }
        .locat {
            width: 80%;
            margin: 0 auto;
        }
        .info-label {
            display: inline-block;
            /*font-weight: bold;*/
            color: #6c757d;
            margin-bottom: 0.5rem;
            text-align: center;
            white-space: nowrap;
        }
        .info-value {
            display: inline;
            margin-bottom: 1rem;
        }
        .d-flex {
            display: flex;
            flex-wrap: wrap;
            /*align-items: center;*/
            /*justify-content: center;*/
        }
        /*.me-3 {*/
            /*margin-right: 1rem;*/
        /*}*/

        .breadcrumb {
            background-color: transparent;
            margin-top: 2rem;
            margin-bottom: 2rem;
            margin-left: 1rem;
        }
        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            color: #6c757d;
            font-weight: bold;
        }
        .breadcrumb-item a {
            color: inherit;
            text-decoration: none;
        }
        .breadcrumb-item a:hover {
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: #080808;
        }

        .study-article {
            background-color: #fff;
            width: 100%;
            margin: 0 auto;
            border-radius: 8px;
            padding: 2.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            font-size: 1.1rem;
            line-height: 1.8;
            white-space: pre-wrap;
            word-wrap: break-word;
            text-indent: 2em;
            text-align: justify;
            hyphens: auto;
            overflow-wrap: break-word;
        }
        /* 段落间距优化 */
        .study-article p {
            margin-bottom: 1.2rem;
            line-height: 1.8;
        }
        .studys-separator {
            border-bottom: 1px solid #000; /* 添加黑色横线 */
            margin-bottom: 1rem;
            width: 100%; /* 调整横线宽度 */
            margin-left: auto;
            margin-right: auto; /* 横线居中 */
        }
        .studys-meta {
            display: flex;
            justify-content: center; /* 内容居中 */
            align-items: center;
            margin-bottom: 2rem;
        }
        .studys-meta p {
            margin: 0 10px; /* 元素之间的间距 */
        }
        .back-btn {
            margin-top: 1rem;

        }
        @media (max-width: 768px) {
            .study-article {
                padding: 1.5rem;
                font-size: 1rem;
                text-indent: 1.5em;
            }
        }


        /* ------------------------ 评论区域样式 ------------------------ */
        .comment-item {
            background-color: #f8f9fa !important;
            border: 1px solid #e9ecef !important;
            border-radius: 8px !important;
            margin-bottom: 12px !important;
            padding: 12px 15px !important;
        }
        .username {
            color: #0d6efd !important;
            font-weight: 600 !important;
            margin-right: 8px;
        }
        .timestamp {
            color: #6c757d !important;
            font-size: 0.875em !important;
            white-space: nowrap;
        }
        .comment-content {
            color: #212529 !important;
            line-height: 1.6;
            margin-top: 8px !important;
        }
        @media (max-width: 768px) {
            .comment-header {
                flex-direction: column;
                align-items: flex-start !important;
            }
            .timestamp {
                margin-top: 4px;
                align-self: flex-end !important;
            }
        }
        .row{
            margin-top: 20px;
        }

    </style>
</head>
<body>
<!-- 导航栏 -->
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
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-avatar.png'"
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
<div class="container">
    <div class="row">
            <div class="col-md-12">
                <div class="text-end back-btn">
                    <button class="btn btn-warning" onclick="window.history.back()">
                        <i class="bi bi-arrow-left"></i> 返回研学列表
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">

        <div class="col-md-6 locat"> <!-- 修改为12列，确保内容区域居中 -->
            <div class="locat">
                <h1 class="study-title" id="studyTitle">标题</h1>
                <div class="studys-separator"></div> <!-- 添加内容分隔线 -->
                <div class="studys-meta"> <!-- 使用第一个页面的元数据布局类 -->
                    <p><span class="info-label">作者：</span> <span id="studyAuthor"></span></p>
                    <p><span class="info-label">来源：</span> <span id="studySource"></span></p>
                    <p><span class="info-label">浏览：</span> <span id="viewCount"></span></p>
                    <p><span class="info-label">时间：</span> <span id="studyTime"></span></p>
                </div>
                <!-- 内容区域使用study-article类，移除原有id样式 -->
                <div class="study-article" id="studyContent">
                </div>
            </div>
        </div>
    </div>

<!-- 评论区域 -->
<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="section-title">评论列表</h3>
                <button class="btn btn-sm btn-primary btn-action" onclick="showCommentBox()">
                    <i class="bi bi-chat"></i> 评论
                </button>
            </div>
            <div id="commentsBody">
                <!-- 评论内容将在这里动态加载 -->
            </div>
        </div>
    </div>
</div>

<!-- 页脚 -->
<footer class="text-center" style="background-color: #8b1515; color: white; padding: 20px 0 10px;">
    <div class="container">
        <!-- 原 mt-5（margin-top:20px）改为 mt-1（margin-top:4px）或 mt-2（margin-top:8px），按需选择 -->
        <div class="row mt-2">
            <div class="col-12">
                <div class="footer-nav" style="margin-top: 10px; gap: 10px;">
                    <a href="about.jsp#intro" class="footer-nav-link">关于我们</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#feedback" class="footer-nav-link">意见反馈</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#copyright" class="footer-nav-link">版权声明</a>
                    <span class="mx-2">|</span>
                    <a href="about.jsp#privacy" class="footer-nav-link">隐私声明</a>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-12">
                <p class="mb-0" style="font-size: 0.9em; color: rgba(255,255,255,0.7);">
                    2025 红色旅游系统 版权所有
                </p>
            </div>
        </div>
    </div>
</footer>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const studyId = urlParams.get('id');
    let studyData = null;




    $(document).ready(function() {
        if (studyId) {
            loadStudyDetail(studyId);
            loadComments(studyId); // 自动加载评论

        } else {
            alert('无效的内容ID');
            window.location.href = 'study-list.jsp';
        }
    });


    function loadStudyDetail(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/study/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    studyData = response.data;
                    renderStudyDetail(studyData);
                } else {
                    alert('获取景点详情失败: ' + response.msg);
                    window.location.href = 'study-list.jsp';
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
                window.location.href = 'study-list.jsp';
            }
        });
    }
    function renderStudyDetail(study) {
        $('#studyTitle').text(study.title);
        $('#studyAuthor').text(study.author || '暂无作者');
        $('#studyCoverImage').attr('src', `${pageContext.request.contextPath}/` + study.coverImage);
        $('#studySource').text(study.source || '暂无来源');
        $('#studyTime').text(study.time || '暂无时间');
        // $('#studyContent').html(study.content || '暂无内容');
        $('#studyContent').html(
            study.content
                .replace(/\n/g, '<br>')    // 保留换行符
                .replace(/ {2}/g, '&nbsp;&nbsp;') // 保留空格
            || '暂无内容'
        );
        $('#viewCount').text(study.viewCount || 0);

    }


    function loadComments(studyId) {
        // 显示加载中提示
        $('#commentsBody').html(`
        <div class="text-center py-4">
            <div class="spinner-border text-primary"></div>
            <p class="mt-2">加载评论中...</p>
        </div>
    `);

        // 发起 AJAX 请求获取评论列表
        $.ajax({
            url: '${pageContext.request.contextPath}/comment/study/formattedList/' + studyId, // 后端接口地址
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    // 如果返回的 code 是 200，表示成功获取评论列表
                    // 将返回的 HTML 内容（response.msg）渲染到 #commentsBody 中
                    $('#commentsBody').html(response.msg);

                } else {
                    // 如果返回的 code 不是 200，表示获取评论失败
                    // 显示错误信息
                    $('#commentsBody').html(`
                    <div class="alert alert-danger">
                        ${response.msg || '加载评论失败'}
                    </div>
                `);
                }
            },
            error: function(xhr) {
                // 如果 AJAX 请求本身失败（如网络问题、服务器错误等）
                // 显示错误提示
                $('#commentsBody').html(`
                <div class="alert alert-danger">
                    请求失败: ${xhr.statusText}
                </div>
            `);
            }
        });
    }

    // 显示评论输入框
    function showCommentBox() {
        const modalHtml = `
        <div class="modal fade" id="commentModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">评论研学</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" id="commentContent" rows="3" placeholder="请输入您的评论..."></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="submitComment()">提交</button>
                    </div>
                </div>
            </div>
        </div>`;

        $('body').append(modalHtml);
        $('#commentModal').modal('show');

        $('#commentModal').on('hidden.bs.modal', function() {
            $(this).remove();
        });
    }
    function submitComment() {
        const content = $('#commentContent').val().trim();

        if (!content) {
            alert('评论内容不能为空');
            return;
        }

        // 使用从URL获取的studyId，而不是从隐藏字段获取
        $.ajax({
            url: '${pageContext.request.contextPath}/comment/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                studyId: studyId,
                content: content
            }),
            success: function(response) {
                if (response.code === 200) {
                    alert('评论发表成功');
                    $('#commentModal').modal('hide');
                    loadComments(studyId); // 刷新评论列表
                } else {
                    alert(response.msg || '评论发表失败');
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            }
        });
    }

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

    function loadUserCenterData(event) {
        event.preventDefault(); // 阻止默认的链接跳转行为

        // 发送AJAX请求到后端
        fetch('${pageContext.request.contextPath}/user/refreshSessionData', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'same-origin' // 确保携带cookie/session
        })
            .then(response => {
                if (response.ok) {
                // 请求成功后跳转到个人中心页面
                window.location.href = 'user-center.jsp';
                } else {
                    // 处理错误情况
                    alert('加载用户数据失败，请重试');
                }
            })
            .catch(error => {
                    console.error('请求失败:', error);
                alert('网络错误，请检查连接');
            });
    }

</script>
</body>
</html>