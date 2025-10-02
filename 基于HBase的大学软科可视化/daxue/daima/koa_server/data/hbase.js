const axios = require('axios') // 确保已经安装了 axios

// HBase REST 服务的基础 URL
const baseURL = 'http://your-hbase-rest-server:port'

// 表名和行键
const tableName = 'your_table_name'
const rowKey = 'your_row_key'

// 构造获取数据的 URL
const url = `${baseURL}/table/${tableName}/row/${rowKey}`

// 使用 axios 发送 GET 请求
axios.get(url)
    .then(response => {
        // 请求成功，处理响应数据
        console.log('HBase Data:', response.data)
    })
    .catch(error => {
        // 请求失败，处理错误
        console.error('Error fetching data from HBase:', error)
    });