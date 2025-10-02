// <%--&lt;%&ndash;--%>
// <%--  Created by IntelliJ IDEA.--%>
// <%--  User: 李树君--%>
// <%--  Date: 2025/4/24--%>
// <%--  Time: 21:13--%>
// <%--  To change this template use File | Settings | File Templates.--%>
// <%--&ndash;%&gt;--%>
// <%--&lt;%&ndash;<%@ page contentType="text/html;charset=UTF-8" language="java" %>&ndash;%&gt;--%>
// <%--<html>--%>
// <%--<head>--%>
// <%--    <title>Title</title>--%>
//
// <%--    <meta charset="utf-8">--%>
// <%--    <style>--%>
// <%--        #position_demo {--%>
// <%--            position: absolute;--%>
// <%--            right: 100px;--%>
// <%--            bottom: 100px;--%>
// <%--        }--%>
// <%--        html, body, #root {--%>
// <%--            height: 50%;--%>
// <%--            padding: 0;--%>
// <%--            margin: 0;--%>
// <%--        }--%>
// <%--        .ab1ac9d9bab12da47298 {--%>
// <%--            position: fixed;--%>
// <%--            bottom: 30px;--%>
// <%--            right: 30px;--%>
// <%--            display: flex;--%>
// <%--            justify-content: center;--%>
// <%--            align-items: center;--%>
// <%--            height: 86px;--%>
// <%--            width: 86px;--%>
// <%--            cursor: pointer;--%>
// <%--            transition: transform 0.3s ease;--%>
// <%--        }--%>
//
// <%--    </style>--%>
// <%--</head>--%>
// <%--<body>--%>
// <%--&lt;%&ndash;<div id="position_demo"></div>&ndash;%&gt;--%>
// <%--<div class="ab1ac9d9bab12da47298" style="position: fixed; --coze-z-index-iframe: 1000;"><img alt="logo" src="../../assets/images/r_ai.png"></div>--%>
// <%--<div id="id1" style="position: absolute; top: 200px; right: 20px;width: 600px; height: 800px"></div>--%>
//
// <%--<script src="https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.2.0-beta.6/libs/cn/index.js"></script>--%>
// <%--    <script>--%>
// <%--        console.log('Testing Chinese characters: 测试中文显示');--%>
// <%--        const bot_id ='7496828922253525032';--%>
// <%--        const title = '红迹云游小助手';--%>
// <%--        const icon ='../../assets/images/r_ai.png'--%>
// <%--        const lang = 'zh-CN';--%>
// <%--        const layout = 'pc';--%>
//
// <%--        new CozeWebSDK.WebChatClient({--%>
// <%--            config: {--%>
// <%--                bot_id,--%>
// <%--            },--%>
// <%--            componentProps: {--%>
// <%--                title,--%>
// <%--                icon,--%>
// <%--            },--%>
// <%--            // el:document.getElementById('position_demo'),--%>
// <%--            auth: {--%>
// <%--                type: 'token',--%>
// <%--                token: 'pat_tYDwpMB5TxSYzKvaGGfpxzBR5CCA05XfxjZFnkqcX9niFjHF0bZgGDKQfHcwxyOo',--%>
// <%--                onRefreshToken: function () {--%>
// <%--                    return 'pat_tYDwpMB5TxSYzKvaGGfpxzBR5CCA05XfxjZFnkqcX9niFjHF0bZgGDKQfHcwxyOo'--%>
// <%--                }--%>
// <%--            },--%>
// <%--            //用户信息--%>
// <%--            userInfo:{--%>
// <%--                id:'123456',--%>
// <%--                nickname:'red_tourism',--%>
// <%--                url:'http://localhost:8080/RedTourismSystem/assets/images/default-avatar1.png',--%>
// <%--            }--%>
// <%--        //     ui:{--%>
// <%--        //         base:{--%>
// <%--        //             icon:'http://localhost:8080/RedTourismSystem/assets/images/r_ai.png',--%>
// <%--        //             layout:'pc',--%>
// <%--        //             lang:'zh-CN',--%>
// <%--        //             zIndex:100000,--%>
// <%--        //         },--%>
// <%--        //         asstBtn:{--%>
// <%--        //             isNeed:true,--%>
// <%--        //         },--%>
// <%--        //         footer:{--%>
// <%--        //             isShow:true,--%>
// <%--        //             expressionText:'红迹云游小助手',--%>
// <%--        //         },--%>
// <%--        //         chatBot:{--%>
// <%--        //             title:'红迹云游小助手',--%>
// <%--        //             // width:600,--%>
// <%--        //             el:document.getElementById('id1')--%>
// <%--        //         }--%>
// <%--        //     }--%>
// <%--        });--%>
// <%--    </script>--%>
// <%--</body>--%>
// <%--</html>--%>
// <div id="id1" style="position: fixed; top: 200px; right: 20px;width: 600px; height: 800px;"></div>
// 确保外部脚本加载完成后执行初始化逻辑
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
// document.addEventListener('DOMContentLoaded', function() {
//     // 检查是否已经定义了必要的变量
//     if (typeof botId === 'undefined' || typeof token === 'undefined') {
//         console.error('Bot ID or Token is not defined.');
//         return;
//     }
//
//     // 获取用户信息
//     fetchUserInfo().then(userInfo => {
//         if (!userInfo) {
//             console.error('User info is not available.');
//             return;
//         }
//
//         // 创建外部脚本元素
//         const externalScript = document.createElement('script');
//         externalScript.src = 'https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.0.0-beta.2/libs/cn/index.js';
//         externalScript.type = 'text/javascript';
//
//         // 外部脚本加载完成后，初始化WebChatClient
//         externalScript.onload = function() {
//             new CozeWebSDK.WebChatClient({
//                 config: {
//                     bot_id: botId, // 使用动态注入的botId
//                 },
//                 componentProps: {
//                     title: '红迹云游小助手',
//                 },
//                 auth: {
//                     type: 'token',
//                     token: token, // 使用动态注入的token
//                     onRefreshToken: function () {
//                         return token; // 返回相同的token
//                     }
//                 },
//                 userInfo: {
//                     id: userInfo.id, // 使用从服务器获取的用户ID
//                     nickname: '我',
//                     url: userInfo.avatarUrl, // 使用从服务器获取的用户头像URL
//                 },
//                 ui: {
//                     base: {
//                         icon: 'http://localhost:8080/RedTourismSystem/assets/images/r_ai.png',
//                         layout: 'pc',
//                         lang: 'zh-CN',
//                         zIndex: 1000,
//                     },
//                     asstBtn: {
//                         isNeed: true,
//                     },
//                     footer: {
//                         isShow: true,
//                         expressionText: '红迹云游',
//                     },
//                     chatBot: {
//                         title: '红迹云游小助手',
//                         el: document.getElementById('id1') // 确保页面中有id为id1的元素
//                     }
//                 }
//             });
//         };
//
//         // 将外部脚本添加到页面中
//         document.body.appendChild(externalScript);
//     });
// });
