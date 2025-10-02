// coze-init.js
document.addEventListener('DOMContentLoaded', function() {
    // 使用传递的 contextPath
    const contextPath = window.contextPath;

    // 获取用户信息
    fetch(contextPath + '/user/info', {
        method: 'GET',
        credentials: 'same-origin' // 确保携带cookie/session
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if (data.code === 200) {
                const user = data.data;
                console.log("sss", user.avatar);
                // 将用户信息注入到页面中
                var userInfo = {
                    id: user.id, // 假设用户ID是固定的，或者从后端获取
                    nickname: user.nickname,
                    url: 'http://localhost:8080/RedTourismSystem/' + user.avatar
                };
                // 初始化 coze 智能体
                initCoze(userInfo);
            } else {
                console.error('获取用户信息失败:', data.message);
            }
        })
        .catch(error => {
            console.error('请求失败:', error);
        });
});

function initCoze(userInfo) {
    // 创建外部脚本元素
    const externalScript = document.createElement('script');
    externalScript.src = 'https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.0.0-beta.2/libs/cn/index.js';
    externalScript.type = 'text/javascript';

    // 外部脚本加载完成后，初始化WebChatClient
    externalScript.onload = function() {
        new CozeWebSDK.WebChatClient({
            config: {
                bot_id: window.botId, // 使用动态注入的botId
            },
            componentProps: {
                title: '红迹云游小助手',
            },
            auth: {
                type: 'token',
                token: window.token, // 使用动态注入的token
                onRefreshToken: function () {
                    return window.token; // 返回相同的token
                }
            },
            userInfo: userInfo, // 使用从服务器获取的用户信息
            ui: {
                base: {
                    icon: 'http://localhost:8080/RedTourismSystem/assets/images/r_ai.png',
                    layout: 'pc',
                    lang: 'zh-CN',
                    zIndex: 1000,
                },
                asstBtn: {
                    isNeed: true,
                },
                footer: {
                    isShow: true,
                    expressionText: '红迹云游',
                },
                chatBot: {
                    title: '红迹云游小助手',
                    el: document.getElementById('id1') // 确保页面中有id为id1的元素
                }
            }
        });
    };

    // 将外部脚本添加到页面中
    document.body.appendChild(externalScript);
}
