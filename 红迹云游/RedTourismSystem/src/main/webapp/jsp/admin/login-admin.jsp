<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>红色旅游系统 - 管理员登录</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            background: url('../../assets/images/banners/bg.png') no-repeat center center;
            background-size: cover;
        }
        .login-container {
            max-width: 400px;
            margin: 0 60px 20px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
            color: #dc3545;
            font-weight: bold;
        }
        .btn-login {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
            height: 45px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <h2 class="login-header mb-4">管理员登录</h2>
        <form id="adminLoginForm">
            <div class="mb-3">
                <input type="text" class="form-control" id="adminUsername" placeholder="管理员账号" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="adminPassword" placeholder="密码" required>
            </div>
            <button type="submit" class="btn btn-login w-100 mb-3">登录</button>
        </form>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('adminLoginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const adminUsername = document.getElementById('adminUsername').value;
        const adminPassword = document.getElementById('adminPassword').value;

        fetch('${pageContext.request.contextPath}/admin/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username: adminUsername,
                password: adminPassword
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    // alert('登录成功！');
                    window.location.href = 'total.jsp'; //
                } else {
                    alert('登录失败：' + data.msg);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('登录失败，请稍后再试');
            });
    });
</script>
</body>
</html>