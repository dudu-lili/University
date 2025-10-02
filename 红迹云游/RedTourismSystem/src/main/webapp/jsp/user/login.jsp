<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>红迹云游 - 登录</title>
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
        .form-control {
            height: 45px;
            margin-bottom: 15px;
        }
        .btn-login {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
            height: 45px;
        }
        .btn-register {
            color: #dc3545;
            font-weight: bold;
        }
        .btn-sms {
            width: 120px;
            height: 45px;
            border-radius: 5px;
        }
        .btn-register {
            color: #dc3545;
            font-weight: bold;
            text-decoration: none;
        }

        .text-muted {
            color: #6c757d;
            font-weight: bold;
            text-decoration: none;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <h2 class="login-header mb-4">红迹云游</h2>
        <form id="loginForm">
            <div class="mb-3">
                <input type="text" class="form-control" id="email" placeholder="用户名" required>
            </div>
<%--            <div class="mb-3">--%>
<%--                <input type="password" class="form-control" id="password" placeholder="密码" required>--%>
<%--            </div>--%>
            <div class="mb-3" >
                <div class="password-wrapper position-relative">
                    <input type="password" class="form-control" id="password" placeholder="密码" required>
                    <span class="toggle-password position-absolute top-50 end-0 translate-middle-y me-3"
                          onclick="togglePassword('password', this)"></span>
                </div>
            </div>
            <button type="submit" class="btn btn-login w-100 mb-3">登录</button>
            <div class="d-flex justify-content-between align-items-center mt-3">
                <a href="register.jsp" class="btn-register">没有账号？注册</a>
                <a href="javascript:void(0)" onclick="showForgotPasswordModal()" class="text-muted">忘记密码？</a>
            </div>
            <!-- 在登录表单后添加管理员登录按钮 -->
            <div class="text-center mt-3">
                <button class="btn btn-admin-login w-100" onclick="window.location.href='/RedTourismSystem/jsp/admin/login-admin.jsp'">管理员登录</button>
            </div>
        </form>
    </div>
</div>

<!-- 忘记密码模态框 -->
<div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">找回密码</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="forgotPasswordForm">
                    <div class="mb-3">
                        <input type="email" class="form-control" id="forgotEmail" name="email" placeholder="请输入注册邮箱" required>
                    </div>
                    <div class="mb-3 input-group">
                        <input type="text" class="form-control" id="emailCode" name="emailCode" placeholder="邮箱验证码" required>
                        <button type="button" class="btn btn-outline-secondary btn-sms" id="emailBtn" onclick="sendEmailCode()">获取验证码</button>
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="新密码" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">重置密码</button>
                </form>
            </div>
        </div>
    </div>
</div>



<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    // 登录表单提交
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        fetch('${pageContext.request.contextPath}/user/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: email, password: password })
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    // alert('登录成功！');
                    window.location.href = 'index.jsp';
                } else {
                    alert('登录失败：' + data.msg);
                }
            });
    });

    // 显示忘记密码模态框
    function showForgotPasswordModal() {
        const modal = new bootstrap.Modal(document.getElementById('forgotPasswordModal'));
        modal.show();
    }
    function togglePassword(inputId, icon) {
        const input = document.getElementById(inputId);
        input.type = input.type === 'password' ? 'text' : 'password';
        icon.textContent = input.type === 'password' ? '' : '';
    }


    // 发送邮箱验证码
    function sendEmailCode() {
        const email = document.getElementById('forgotEmail').value;
        if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            alert('请输入正确的邮箱地址');
            return;
        }

        fetch('${pageContext.request.contextPath}/user/send-email-code', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'email=' + encodeURIComponent(email)
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text) });
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('验证码已发送到邮箱');
                    startCountdown('emailBtn');
                } else {
                    alert('发送失败: ' + data.msg);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('发送验证码失败: ' + error.message);
            });
    }

    // 60秒倒计时（修改为通用函数）
    function startCountdown(btnId) {
        let seconds = 60;
        const btn = document.getElementById(btnId);
        const originalText = btn.textContent;

        const timer = setInterval(() => {
            btn.textContent = `${seconds}秒后重试`;
            btn.disabled = true;

            if (seconds <= 0) {
                clearInterval(timer);
                btn.textContent = originalText;
                btn.disabled = false;
            }
            seconds--;
        }, 1000);
    }

    // 提交重置密码请求
    // 修改提交逻辑
    document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData();
        formData.append('email', document.getElementById('forgotEmail').value);
        formData.append('emailCode', document.getElementById('emailCode').value);
        formData.append('newPassword', document.getElementById('newPassword').value);

        console.log("提交的验证码:", document.getElementById('emailCode').value);

        fetch('${pageContext.request.contextPath}/user/reset-password-by-email', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                console.log("服务器响应:", data);
                if(data.code === 200) {
                    alert('密码重置成功');
                    bootstrap.Modal.getInstance(document.getElementById('forgotPasswordModal')).hide();
                } else {
                    alert(data.msg || '密码重置失败，请稍后再试');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('请求失败，请检查网络连接');
            });
    });

</script>
</body>
</html>