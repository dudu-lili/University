<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>红色旅游系统 - 注册</title>
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
        .register-container {
            max-width: 500px;
            margin: 0 0 0 auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
            color: #dc3545;
            font-weight: bold;
        }
        .form-control {
            height: 45px;
            margin-bottom: 15px;
        }
        .btn-register {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
            height: 45px;
        }
        .btn-login {
            color: #dc3545;
            font-weight: bold;
        }
        .avatar-preview img {
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .avatar-preview img:hover {
            transform: scale(1.05);
        }
        .input-group {
            display: flex;
            align-items: center;
        }

        .input-group .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        .input-group .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            height: 45px; /* 确保按钮高度与输入框一致 */
            margin-bottom: 15px;
        }
        .btn-register {
            background-color: #dc3545; /* 红色背景 */
            color: white;
            font-weight: bold;
            height: 45px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-register:hover {
            background-color: #c82333; /* 悬停时的红色背景 */
        }


    </style>
</head>
<body>
<div class="container">
    <div class="register-container">
        <h2 class="register-header mb-4">用户注册</h2>
        <form id="registerForm">
            <div class="d-flex justify-content-center mb-4">
<%--                <label class="form-label">选择头像</label>--%>
                <div class="avatar-preview">
                    <label for="avatarUpload">
                        <img id="avatarPreview" src="../../assets/images/OIP-C.png" class="rounded-circle" width="100" height="100" style="cursor: pointer;">
                    </label>
                </div>
                <input type="file" id="avatarUpload" name="avatar" accept="image/*" class="form-control" style="display: none;">
            </div>

            <!-- 基础信息 -->
            <div class="mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="邮箱*" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码*" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="确认密码*" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" id="nickname" name="nickname" placeholder="昵称*" required>
            </div>
            <div class="mb-3 input-group">
                <input type="text" class="form-control" id="verificationCode" name="verificationCode" placeholder="验证码*" required>
                <button type="button" id="sendVerificationCode" class="btn btn-outline-secondary">发送验证码</button>
            </div>
            <button type="submit" class="btn btn-register w-100">注册</button>
        </form>
    </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script>
    // 头像预览功能
    document.getElementById('avatarUpload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });

    // 发送验证码
    document.getElementById('sendVerificationCode').addEventListener('click', function() {
        const email = document.getElementById('email').value;
        if (!email) {
            alert('请输入邮箱地址');
            return;
        }
        fetch('${pageContext.request.contextPath}/user/send-email-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'email=' + encodeURIComponent(email)
         })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('验证码已发送，请查收邮箱');
                } else {
                    alert('验证码发送失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('验证码发送失败，请稍后再试');
            });
    });


    // 修改注册提交逻辑
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // 获取表单元素
        const form = e.target;
        const avatarFile = document.getElementById('avatarUpload').files[0];

        // 密码验证
        if (form.password.value !== form.confirmPassword.value) {
            alert('两次输入的密码不一致');
            return;
        }

        // 创建FormData对象
        const formData = new FormData();

        // 添加必填字段
        formData.append('email', form.email.value);
        formData.append('password', form.password.value);
        formData.append('nickname', form.nickname.value);
        formData.append('verificationCode', form.verificationCode.value);


        // 添加头像文件
        if (avatarFile) {
            formData.append('avatar', avatarFile);
        }

        // 设置默认状态
        formData.append('status', '1');

        // 提交注册请求
        fetch('${pageContext.request.contextPath}/user/register', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok){
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    alert('注册成功');
                    window.location.href = 'login.jsp';
                } else {
                    throw new Error(data.msg || '注册失败');
                }
            })
            .catch(error => {
                // console.error('注册错误:', error);
                // alert(error.message);
                console.error('注册错误:', error);
                // 打印详细的错误信息
                fetch('${pageContext.request.contextPath}/user/register', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        console.error('后端返回的详细错误信息:', data);
                        alert('注册失败: ' + data.msg);
                    })
                    .catch(err => {
                        console.error('获取详细错误信息失败:', err);
                        alert('注册失败，请稍后再试');
                    });
            });
    });
</script>
</body>
</html>
