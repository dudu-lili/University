// 处理业务逻辑的中间件,读取某个csv文件的数据
const Papa = require('papaparse')
const path = require('path')
const fileUtils = require('../utils/file_utils')
module.exports = async (ctx, next) => {
  // 根据url
  const url = ctx.request.url // /api/seller   ../data/seller.json
  let filePath = url.replace('/api', '') //  /seller
  filePath = '../data' + filePath + '.csv'  // ../data/seller.json
  filePath = path.join(__dirname, filePath)
  try {
    //读取文件内容
    const fileContent = await fileUtils.getFileJsonData(filePath)
    // 使用PapaParse解析CSV内容
    const ret = Papa.parse(fileContent, { header: true });
    // 将解析后的数据设置为响应体
    ctx.response.body = ret.data
  } catch (error) {
    const errorMsg = {
      message: '读取文件内容失败, 文件资源不存在',
      status: 404
    }
    ctx.response.body = JSON.stringify(errorMsg)
    ctx.response.status = errorMsg.status
  }

  console.log(filePath)
  await next()
}
// 处理业务逻辑的中间件,读取某个json文件的数据
// const path = require('path')
// const fileUtils = require('../utils/file_utils')
// module.exports = async (ctx, next) => {
//   // 根据url
//   const url = ctx.request.url // /api/seller   ../data/seller.json
//   let filePath = url.replace('/api', '') //  /seller
//   filePath = '../data' + filePath + '.csv'  // ../data/seller.json
//   filePath = path.join(__dirname, filePath)
//   try {
//     const ret = await fileUtils.getFileJsonData(filePath)
//     ctx.response.body = ret
//   } catch (error) {
//     const errorMsg = {
//       message: '读取文件内容失败, 文件资源不存在',
//       status: 404
//     }
//     ctx.response.body = JSON.stringify(errorMsg)
//   }
//
//   console.log(filePath)
//   await next()
// }