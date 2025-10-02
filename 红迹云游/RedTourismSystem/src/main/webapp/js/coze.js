document.addEventListener('DOMContentLoaded', function() {
// 检查是否已经定义了必要的变量
    if (typeof botId === 'undefined' || typeof token === 'undefined') {
        console.error('Bot ID or Token is not defined.');
        return;
    }

// 创建外部脚本元素
    const externalScript = document.createElement('script');
    externalScript.src = 'https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.0.0-beta.2/libs/cn/index.js';
    externalScript.type = 'text/javascript';

// 外部脚本加载完成后，初始化WebChatClient
    externalScript.onload = function() {
        new CozeWebSDK.WebChatClient({
            config: {
                bot_id: botId, // 使用动态注入的botId
            },
            componentProps: {
                title: '红迹云游小助手',
            },
            auth: {
                type: 'token',
                token: token, // 使用动态注入的token
                onRefreshToken: function () {
                    return token; // 返回相同的token
                }
            },
            userInfo: {
                id: '123456',
                nickname: 'red_tourism',
                url: 'http://localhost:8080/RedTourismSystem/assets/images/default-avatar1.png',
            },
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
});