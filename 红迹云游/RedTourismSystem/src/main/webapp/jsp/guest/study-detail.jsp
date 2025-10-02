<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<html>
<head>
    <title>红色旅游系统-研学</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 导航栏样式------------------------- */
        .navbar {
            background-color: #90201f;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 0px;
        }
        .navbar-brand, .nav-link {
            color: white!important;
            font-weight: bold;
        }
        .nav-link:hover {
            color: #ffc107!important;
        }
        /* 可选：如果需要保持响应式折叠功能 */
        .navbar-toggler {
            border: none;
            padding: 0.25rem 0.75rem;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255,255,255,1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
        }

        /* 其他样式 ------------------------------*/
        body {
            padding-top: 56px;
            background-color: #f8f9fa;
        }
        html, body {
            height: 100%;
        }

        body {
            display: flex;
            flex-direction: column;
            padding-top: 56px;
        }

        .container {
            flex: 1;
        }

        .study-title {
            color: #080808;
            /*border-bottom: 1px solid #080808;*/
            text-align: center;
            margin-bottom: 1rem;
        }
        .section-title {
            color: #B3100f;
            margin: 2rem 0 1rem;
            font-weight: bold;
            /*border-left: 5px solid #dc3545;*/
            padding-left: 15px;
        }
        .locat{
            width: 80%;
            margin: 0 auto;
        }
        .info-label {
            display: inline-block; /* 使宽度根据内容自动调整 */
            /*font-weight: bold;*/
            color: #6c757d;
            margin-bottom: 0.5rem;
            text-align: center;
            white-space: nowrap; /* 防止内容换行 */
        }
        .info-value {
            display: inline; /* 确保内容在同一行显示 */
            margin-bottom: 1rem;

        }
        .d-flex {
            display: flex; /* 使用Flexbox布局 */
            flex-wrap: wrap; /* 允许内容换行 */
            align-items: center; /* 垂直居中对齐 */
            justify-content: center; /* 水平居中对齐 */
        }
        /*.me-3 {*/
        /*margin-right: 1rem; !* 添加右侧间距 *!*/
        /*}*/
        .study-article {
            background-color: #fff;
            width: 100%;
            margin: 0 auto;
            border-radius: 8px;
            padding: 2.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            font-size: 1.1rem; /* 加大字体 */
            line-height: 1.8; /* 增加行高 */
            white-space: pre-wrap; /* 保留空格和换行 */
            word-wrap: break-word; /* 自动换行 */

            /* 新增样式 */
            text-indent: 2em;       /* 首行缩进2个字符 */
            text-align: justify;    /* 文本两端对齐 */
            hyphens: auto;          /* 连字符自动换行（需浏览器支持） */
            overflow-wrap: break-word; /* 强制长单词换行 */
        }
        /* 段落间距优化 */
        .study-article p {
            margin-bottom: 1.2rem;
            line-height: 1.8;
        }

        /* 移动端适配 */
        @media (max-width: 768px) {
            .study-article {
                padding: 1.5rem;
                font-size: 1rem;
                text-indent: 1.5em; /* 移动端适当减小缩进 */
            }
        }


        .breadcrumb {
            background-color: transparent;
            margin-top: 2rem;
            margin-bottom: 2rem;
            margin-left: 1rem; /* 向右靠一点 */
        }
        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            color: #6c757d;
            font-weight: bold;
            /*margin: 0 0.5rem; !* 增加分隔符的间距 *!*/
        }
        .breadcrumb-item a {
            color: inherit; /* 继承父元素的颜色 */
            text-decoration: none; /* 去掉下划线 */
        }
        .breadcrumb-item a:hover {
            text-decoration: none; /* 鼠标悬停时也不显示下划线 */
        }
        .info-label {
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 0.5rem;
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
        /* 评论容器样式 -------------------------------*/
        .comment-item {
            background-color: #f8f9fa !important; /* 浅灰背景 */
            border: 1px solid #e9ecef !important;  /* 边框颜色 */
            border-radius: 8px !important;         /* 圆角 */
            margin-bottom: 12px !important;        /* 间距 */
            padding: 12px 15px !important;         /* 内边距 */
        }

        /* 用户名样式 */
        .username {
            color: #0d6efd !important; /* 蓝色 */
            font-weight: 600 !important;
            margin-right: 8px;
        }

        /* 时间戳样式 */
        .timestamp {
            color: #6c757d !important; /* 灰色 */
            font-size: 0.875em !important;
            white-space: nowrap;
        }

        /* 评论内容样式 */
        .comment-content {
            color: #212529 !important; /* 深灰色 */
            line-height: 1.6;
            margin-top: 8px !important;
        }

        /* 响应式布局优化 */
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
        /* 页脚样式 ----------------------------------------------*/
        .footer-link {
            color: rgba(255,255,255,0.8) !important;
            font-size: 0.95em;
            line-height: 2.2;
            transition: color 0.3s;
            text-decoration: none; /* 添加这行代码去除下划线 */
        }

        .footer-link:hover {
            color: white !important;
            text-decoration: none;
            text-decoration: none; /* 悬停时也保持无下划线 */
        }

        .footer-nav {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
        }

        .footer-nav-link {
            color: rgba(255,255,255,0.8) !important;
            font-size: 0.9em;
            transition: color 0.3s;
            text-decoration: none;
        }

        .footer-nav-link:hover {
            color: white !important;
        }

        /* 调整原有页脚样式 */
        footer {
            background-color: #8b1515 !important; /* 改为红色主题 */
            margin-top: 100px;
            position: relative;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg,
            rgba(255,255,255,0.1) 0%,
            rgba(255,255,255,0.3) 50%,
            rgba(255,255,255,0.1) 100%
            );
        }

        /* 统一所有锚点链接样式 */
        a[href^="#"] {
            cursor: pointer;
            text-decoration: none !important;
            transition: all 0.3s;
        }

        a[href^="#"]:hover {
            color: #B3100f !important;
            transform: translateX(3px);
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <img src="${pageContext.request.contextPath}/assets/images/banners/logo2.png" alt="红色旅游" height="56">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="scenic-list.jsp">景点信息</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="route-list.jsp">旅游路线</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="red-Geocoding.jsp">地图展示</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="study-list.jsp">红色研学</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="news-list.jsp">新闻公告</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.jsp">关于我们</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../user/login.jsp">注册/登录</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <%--<div class="row">--%>
        <%--<div class="col-md-12">--%>
            <%--<nav aria-label="breadcrumb">--%>
                <%--<ol class="breadcrumb">--%>
                    <%--<li class="breadcrumb-item"><a href="index.jsp">您的位置：首页</a></li>--%>
                    <%--<li class="breadcrumb-item"><a href="study-list.jsp">红色研学</a></li>--%>
                    <%--&lt;%&ndash;<li class="breadcrumb-item active" aria-current="page">景点详情</li>&ndash;%&gt;--%>
                <%--</ol>--%>
            <%--</nav>--%>
        <%--</div>--%>
    <%--</div>--%>
        <div class="row">
            <div class="col-md-12">
                <div class="text-end back-btn">
                    <button class="btn btn-warning" onclick="window.history.back()">
                        <i class="bi bi-arrow-left"></i> 返回研学列表
                    </button>
                </div>
            </div>
        </div>
    <div class="row">

            <div class="col-md-6 locat">
                <h1 class="study-title" id="studyTitle">标题</h1>
                <div class="studys-separator"></div>
                <div class="studys-meta">
                   <p><span class="info-label">作者：</span> <span id="studyAuthor"></span></p>
                    <p><span class="info-label">来源：</span> <span id="studySource"></span></p>
                    <p><span class="info-label">浏览：</span> <span id="viewCount"></span></p>
                    <p><span class="info-label">时间：</span> <span id="studyTime"></span></p>

                </div>
                <div class="study-article" id="studyContent">
                </div>
            </div>
    </div>

<!-- 评论区域 -->
<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="section-title">评论列表</h3>
                <button class="btn btn-sm btn-primary btn-action" onclick="alert('请先登录!')">
                    <i class="bi bi-chat"></i> 评论
                </button>
            </div>
            <div id="commentsBody">
                <!-- 评论内容将在这里动态加载 -->
            </div>
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
                    © 2025 红色旅游系统 版权所有
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
            url: '${pageContext.request.contextPath}/guest/study/' + id,
            type: 'GET',
            success: function(response) {
                if (response.code === 200) {
                    studyData = response.data;
                    renderStudyDetail(studyData);
                } else {
                    alert('获取研学详情失败: ' + response.msg);
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
            url: '${pageContext.request.contextPath}/guest/study/formattedList/' + studyId, // 后端接口地址
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