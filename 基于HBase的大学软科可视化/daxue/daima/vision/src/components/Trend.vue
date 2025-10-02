<!-- 销量趋势图表 -->
<template>
  <div class="com-container">
    <div class="com-chart" ref="trend_ref"></div>
  </div>
</template>
<script>
import axios from 'axios'

export default {
  data () {
    return {
      chartInstance: null,
      allData: [],
      groupData: [],
      currentPage: 1, // 当前显示的页数
      totalPage: 0, // 一共有多少页，需要计算
      timerId: null, // 定时器标识
      titleFontSize: 0
    }
  },
  mounted () { // 生命周期
    this.initChart()
    this.getData()
    window.addEventListener('resize', this.screenAdapter)
    this.screenAdapter()
  },
  destroyed () {
    window.removeEventListener('resize', this.screenAdapter)
    clearInterval(this.timerId)
  },
  methods: {
    initChart () {
      this.chartInstance = this.$echarts.init(this.$refs.trend_ref, 'chalk')
      const initOption = {
        title: {
          text: '▎ 不同省份的大学类别数量',
          left: 20,
          top: 20
        },
        grid: {
          left: '3%',
          top: '24%',
          rich: '4%',
          bottom: '1%',
          containLabel: true
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'line',
            z: 0
          }
        },
        legend: {
          left: 20,
          top: '12%',
          icon: 'circle'
        },
        xAxis: {
          type: 'category',
          boundaryGap: false
        },
        yAxis: {
          type: 'value'
        },
        series: [{
          type: 'line'
        }]
      }
      this.chartInstance.setOption(initOption)
    },
    async getData () {
      // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      // console.log(res)
      // this.allData = res
      // this.groupData = this.calculateAverageByAddress(this.allData)
      // console.log(this.groupData)
      // this.updateChart()
      // this.startInterval() // 开启动画效果
      try {
        const response = await axios.get('http://localhost:8080/api/scan-all-json')
        console.log(response.data)
        this.allData = response.data // 确保这里的 response.data 是一个数组
        console.log(response)
        this.groupData = this.calculateAverageByAddress(this.allData)
        console.log(this.groupData)
        this.updateChart()
        this.startInterval()
      } catch (error) {
        console.error('Error fetching data:', error)
      }
    },
    calculateAverageByAddress (data) {
      // const groupedData = {}
      // data.forEach(item => {
      //   const address = item.地址
      //   const label = item.标签
      //   if (!groupedData[address]) {
      //     groupedData[address] = {}
      //   }
      //   // if (!groupedData[address][label]) {
      //   //   groupedData[address][label] = 0
      //   // }
      //   // groupedData[address][label]++
      //   groupedData[address][label] = (groupedData[address][label] || 0) + 1
      // })
      // // 将分组数据转换为数组格式，以便于排序和显示
      // const formattedData = Object.keys(groupedData).map(address => {
      //   const labelsArry = Object.keys(groupedData[address])
      //   const labelsCount = labelsArry.length
      //   const labelsWithCount = labelsArry.map(label => ({
      //     标签: label,
      //     数量: groupedData[address][label]
      //   }))
      //   return {
      //     地址: address,
      //     标签个数: labelsCount,
      //     标签详情: labelsWithCount // 包含每个标签及其计数的数组
      //   }
      // })
      // // averageData.slice(0, -1)
      // const totalPage = formattedData.length % 16 === 0 ? parseInt(formattedData.length / 16) : parseInt(formattedData.length / 16) + 1
      // this.totalPage = totalPage
      // return formattedData.slice(0, -1)
      const groupedData = {}

      data.forEach(item => {
        const address = item.address
        const label = item.tags
        // if (!groupedData[label] && !/[\u4e00-\u9fa5]/.test(groupedData[label])) {
        //   groupedData[label] = '双非'
        // }
        if (!groupedData[address]) {
          groupedData[address] = {}
        }
        // 累加标签计数
        groupedData[address][label] = (groupedData[address][label] || 0) + 1
      })

      // 将分组数据转换为数组格式，以便于排序和显示
      const formattedData = Object.keys(groupedData).map(address => {
        const labelsArray = Object.keys(groupedData[address])
        const labelsCount = labelsArray.length
        const labelsWithCount = labelsArray.map(label => ({
          标签: label,
          数量: groupedData[address][label]
        }))
        return {
          地址: address,
          标签个数: labelsCount,
          标签详情: labelsWithCount // 包含每个标签及其计数的数组
        }
      })

      // 计算总页数，假设每页显示16条数据
      const totalPage = formattedData.length % 16 === 0 ? parseInt(formattedData.length / 16) : parseInt(formattedData.length / 16)
      this.totalPage = totalPage

      // 返回除了最后一页之外的所有数据
      return formattedData.slice(0, -2)
    },
    updateChart () {
      const start = (this.currentPage - 1) * 16
      const end = this.currentPage * 16
      const showData = this.groupData.slice(start, end)
      const seriesMap = {}
      showData.forEach(addressData => {
        addressData.标签详情.forEach(tagData => {
          const tagKey = tagData.标签 // 标签作为键
          if (!seriesMap[tagKey]) {
            seriesMap[tagKey] = [] // 初始化数组，用于存储该标签的所有数据点
          }
          seriesMap[tagKey].push({
            name: addressData.地址, // 数据点名称为地址
            value: tagData.数量 // 数据点值为数量
          })
        })
      })
      // 半透明的颜色值
      const colorArr1 = [
        'rgba(11, 168, 44, 0.5)',
        'rgba(44, 110, 255, 0.5)',
        'rgba(22, 242, 217, 0.5)',
        'rgba(254, 33, 30, 0.5)',
        'rgba(250, 105, 0, 0.5)'
      ]
      // 全透明的颜色值
      const colorArr2 = [
        'rgba(11, 168, 44, 0)',
        'rgba(44, 110, 255, 0)',
        'rgba(22, 242, 217, 0)',
        'rgba(254, 33, 30, 0)',
        'rgba(250, 105, 0, 0)'
      ]
      // const seriesData = Object.entries(seriesMap).map(([tag, dataPoints], index) => {
      //   return {
      //     name: tag, // 系列名称为标签
      //     type: 'line',
      //     data: dataPoints.map(point => [point.name, point.value]), // 转换数据格式，ECharts 需要 [x, y] 的格式
      //     stack: 'map',
      //     areaStyle: {
      //       color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
      //         {
      //           offset: 0,
      //           color: colorArr1[index]
      //         },
      //         {
      //           offset: 1,
      //           color: colorArr2[index]
      //         }
      //       ])
      //     }
      //   }
      // })
      const seriesData = Object.entries(seriesMap).map(([tag, dataPoints], index) => {
        const color = colorArr1[index]
        if (typeof color !== 'string' || color.trim() === '') {
          console.error(`Invalid color value for ${tag}:`, color)
          return null // 或者设置一个默认颜色值
        }
        return {
          name: tag,
          type: 'line',
          data: dataPoints.map(point => [point.name, point.value]),
          stack: 'map',
          areaStyle: {
            color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
              {
                offset: 0,
                color: color // 确保这是一个有效的颜色字符串
              },
              {
                offset: 1,
                color: colorArr2[index] || 'rgba(0,0,0,0)' // 提供一个默认颜色
              }
            ])
          }
        }
      }).filter(item => item !== null) // 过滤掉任何无效的系列
      const xAxisData = showData.map((item) => {
        return item.地址
      })
      // 图例的数据
      const legendData = Object.keys(seriesMap)
      // console.log(seriesData)
      console.log(legendData)
      const dataOption = {
        legend: {
          data: legendData
        },
        xAxis: {
          data: xAxisData
        },
        yAxis: {
          type: 'value'
        },
        series: seriesData
      }
      this.chartInstance.setOption(dataOption)
    },
    startInterval () {
      if (this.timerId) {
        clearInterval(this.timerId)
      }
      this.timerId = setInterval(() => {
        this.currentPage++
        if (this.currentPage > this.totalPage) {
          this.currentPage = 1
        }
        this.updateChart()
      }, 3000)
      this.chartInstance.on('mouseout', () => {
        this.startInterval()
      })
    },
    screenAdapter () {
      this.titleFontSize = this.$refs.trend_ref.offsetWidth / 100 * 3.6
      const adapterOption = {
        title: {
          textStyle: {
            fontSize: this.titleFontSize
          }
        },
        legend: {
          itemWidth: this.titleFontSize,
          itemHeight: this.titleFontSize,
          itemGap: this.titleFontSize,
          textStyle: {
            fontSize: this.titleFontSize
          }
        }
      }
      this.chartInstance.setOption(adapterOption)
      this.chartInstance.resize()
    }
  }
}
</script>
<style lang='less' scoped>
</style>

<!--&lt;!&ndash; 商家分布图表 &ndash;&gt;-->
<!--<template>-->
<!--  <div class='com-container'>-->
<!--    <input type="range" min="0" max="50" v-model="threshold" @input="updateChart" />-->
<!--    <div class='com-chart' ref='map_ref'></div>-->
<!--  </div>-->
<!--</template>-->
<!--<script>-->
<!--import axios from 'axios'-->
<!--export default {-->
<!--  data () {-->
<!--    return {-->
<!--      chartInstance: null,-->
<!--      allData: null,-->
<!--      groupData: [],-->
<!--      threshold: 10 // 默认阈值-->
<!--    }-->
<!--  },-->
<!--  mounted () {-->
<!--    this.initChart()-->
<!--    this.getData()-->
<!--    window.addEventListener('resize', this.screenAdapter)-->
<!--    this.screenAdapter()-->
<!--  },-->
<!--  destroyed () {-->
<!--    window.removeEventListener('resize', this.screenAdapter)-->
<!--  },-->
<!--  methods: {-->
<!--    async initChart () {-->
<!--      this.chartInstance = this.$echarts.init(this.$refs.map_ref)-->
<!--      const ret = await axios.get('http://localhost:8899/static/map/china.json')-->
<!--      this.$echarts.registerMap('china', ret.data)-->
<!--      const initOption = {-->
<!--        title: {-->
<!--          text: '▎ 不同省份的大学数量',-->
<!--          left: 20,-->
<!--          top: 20-->
<!--        },-->
<!--        geo: {-->
<!--          type: 'map',-->
<!--          map: 'china'-->
<!--        }-->
<!--        // legend: {-->
<!--        //   left: 20,-->
<!--        //   top: '8%',-->
<!--        //   icon: 'circle'-->
<!--        // }-->
<!--      }-->
<!--      // const ret = await axios.get('http://127.0.0.1:8899/static/map/china.json')-->
<!--      // console.log(ret)-->
<!--      // const initOption = {}-->
<!--      this.chartInstance.setOption(initOption)-->
<!--    },-->
<!--    async getData () {-->
<!--      // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表-->
<!--      const { data: res } = await this.$http.get('2024daxue') // 获取数据-->
<!--      console.log(res)-->
<!--      this.allData = res-->
<!--      this.groupData = this.chulidata(this.allData)-->
<!--      console.log(this.groupData)-->
<!--      this.updateChart()-->
<!--    },-->
<!--    chulidata (data) {-->
<!--      // 使用 reduce 函数来累积每个地址的学校数量-->
<!--      const groupedData = data.reduce((acc, item) => {-->
<!--        const address = item.地址 // 假设每条数据都有一个 '地址' 属性-->
<!--        if (!acc[address]) {-->
<!--          acc[address] = 0 // 初始化计数为 0-->
<!--        }-->
<!--        acc[address]++ // 对该地址的学校数进行计数-->
<!--        return acc-->
<!--      }, {})-->
<!--      // 将累积的结果转换为数组，以便于在图表中显示-->
<!--      const formattedData = Object.entries(groupedData).map(([address, count]) => {-->
<!--        return { 地址: address, 数量: count }-->
<!--      })-->
<!--      return formattedData.slice(0, -1)-->
<!--    },-->
<!--    updateChart () {-->
<!--      const addressCoordMap = {-->
<!--        北京: [116.4074, 39.9042], // 北京-->
<!--        天津: [117.2009, 39.0842], // 天津-->
<!--        上海: [121.4737, 31.2304], // 上海-->
<!--        重庆: [106.5478, 29.5628], // 重庆-->
<!--        河北: [114.5149, 38.0428], // 石家庄-->
<!--        山西: [112.5627, 37.8735], // 太原-->
<!--        辽宁: [123.4315, 41.8055], // 沈阳-->
<!--        吉林: [125.3268, 43.8160], // 长春-->
<!--        黑龙江: [126.6427, 45.7732], // 哈尔滨-->
<!--        江苏: [118.7674, 32.0415], // 南京-->
<!--        浙江: [120.1536, 30.2400], // 杭州-->
<!--        安徽: [117.2830, 31.8615], // 合肥-->
<!--        福建: [119.2965, 26.0745], // 福州-->
<!--        江西: [115.8926, 28.6635], // 南昌-->
<!--        山东: [117.0009, 36.6512], // 济南-->
<!--        河南: [113.6254, 34.7466], // 郑州-->
<!--        湖北: [114.3162, 30.5750], // 武汉-->
<!--        湖南: [112.9335, 28.2282], // 长沙-->
<!--        广东: [113.2644, 23.1291], // 广州-->
<!--        海南: [110.3407, 20.0242], // 海口-->
<!--        四川: [104.0668, 30.5728], // 成都-->
<!--        贵州: [106.7142, 26.5783], // 贵阳-->
<!--        云南: [102.7044, 25.0428], // 昆明-->
<!--        陕西: [108.9315, 34.3416], // 西安-->
<!--        甘肃: [103.8252, 36.0611], // 兰州-->
<!--        青海: [101.7841, 36.6170], // 西宁-->
<!--        台湾: [121.4618, 25.0344], // 台北-->
<!--        内蒙古: [111.6549, 40.8207], // 呼和浩特-->
<!--        广西: [108.3333, 22.8240], // 南宁-->
<!--        宁夏: [106.2592, 38.4738], // 银川-->
<!--        新疆: [87.6168, 43.8256], // 乌鲁木齐-->
<!--        西藏: [91.1409, 29.6469] // 拉萨-->
<!--      }-->
<!--      const legendData = [-->
<!--        { name: '>30', textStyle: { color: '#FF0000' } }, // 红色-->
<!--        { name: '20-30', textStyle: { color: '#FFA500' } }, // 橙色-->
<!--        { name: '10-20', textStyle: { color: '#FFFF00' } }, // 黄色-->
<!--        { name: '<10', textStyle: { color: '#0000FF' } } // 蓝色-->
<!--      ]-->
<!--      function convertAddressToCoord (address) {-->
<!--        const coord = addressCoordMap[address]-->
<!--        if (coord) {-->
<!--          return coord // 如果找到地址，返回对应的经纬度-->
<!--        } else {-->
<!--          // console.warn(`未找到地址匹配: ${address}, 使用默认坐标.`)-->
<!--          // 如果没有找到地址，返回null或者默认坐标-->
<!--          return [120, 30] // 返回默认坐标，例如中国某个参考点的经纬度-->
<!--        }-->
<!--      }-->
<!--      // 选出学校数量大于某个阈值的地址-->
<!--      const filteredData = this.groupData.filter(item => item.数量 > this.threshold)-->
<!--      // 散点数据-->
<!--      function getColorByCount (count) {-->
<!--        if (count > 30) return '#FF0000' // 红色-->
<!--        if (count > 20) return '#FFA500' // 橙色-->
<!--        if (count > 10) return '#FFFF00' // 黄色-->
<!--        return '#0000FF' // 默认蓝色-->
<!--      }-->
<!--      const seriesArr = filteredData.map(item => {-->
<!--        const coord = convertAddressToCoord(item.地址)-->
<!--        const color = getColorByCount(item.数量)-->
<!--        console.log(legendData.map(item => item.name))-->
<!--        return {-->
<!--          // name: item.地址,-->
<!--          name: legendData.map(item => item.name),-->
<!--          value: coord,-->
<!--          symbolSize: Math.max(10, item.数量 * 0.3),-->
<!--          itemStyle: {-->
<!--            normal: {-->
<!--              color: color // 设置散点颜色-->
<!--            }-->
<!--          }-->
<!--        }-->
<!--      })-->
<!--      // const legendData = Object.keys(seriesArr)-->
<!--      console.log(legendData)-->
<!--      const dataOption = {-->
<!--        legend: {-->
<!--          data: legendData, // 转换为字符串数组-->
<!--          left: 'right'-->
<!--        },-->
<!--        series: [{-->
<!--          type: 'effectScatter',-->
<!--          coordinateSystem: 'geo',-->
<!--          data: seriesArr-->
<!--        }]-->
<!--      }-->
<!--      this.chartInstance.setOption(dataOption)-->
<!--    },-->
<!--    screenAdapter () {-->
<!--      const adapterOption = {}-->
<!--      this.chartInstance.setOption(adapterOption)-->
<!--      this.chartInstance.resize()-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->
<!--<style lang='less' scoped>-->
<!--</style>-->

<!--function convertAddressToCoord (address) {-->
<!--const coord = addressCoordMap[address]-->
<!--if (coord) {-->
<!--return coord // 如果找到地址，返回对应的经纬度-->
<!--} else {-->
<!--// console.warn(`未找到地址匹配: ${address}, 使用默认坐标.`)-->
<!--// 如果没有找到地址，返回null或者默认坐标-->
<!--return [120, 30] // 返回默认坐标，例如中国某个参考点的经纬度-->
<!--}-->
<!--}-->
<!--// 选出学校数量大于某个阈值的地址-->
<!--const filteredData = this.groupData.filter(item => item.数量 > this.threshold)-->
<!--// 散点数据-->
<!--function getColorByCount (count) {-->
<!--if (count > 30) return '#FF0000' // 红色-->
<!--if (count > 20) return '#FFA500' // 橙色-->
<!--if (count > 10) return '#FFFF00' // 黄色-->
<!--return '#0000FF' // 默认蓝色-->
<!--}-->
<!--const seriesArr = filteredData.map(item => {-->
<!--const coord = convertAddressToCoord(item.地址)-->
<!--const color = getColorByCount(item.数量)-->
<!--return {-->
<!--name: item.地址,-->
<!--value: coord,-->
<!--symbolSize: Math.max(10, item.数量 * 0.3),-->
<!--itemStyle: {-->
<!--normal: {-->
<!--color: color // 设置散点颜色-->
<!--}-->
<!--}-->
<!--}-->
<!--})-->
<!--const legendData = [-->
<!--{ name: '>30', textStyle: { color: '#FF0000' } }, // 红色-->
<!--{ name: '20-30', textStyle: { color: '#FFA500' } }, // 橙色-->
<!--{ name: '10-20', textStyle: { color: '#FFFF00' } }, // 黄色-->
<!--{ name: '<10', textStyle: { color: '#0000FF' } } // 蓝色-->
<!--]-->
<!--console.log(legendData)-->
<!--const dataOption = {-->
<!--legend: {-->
<!--data: legendData-->
<!--},-->
<!--series: [{-->
<!--type: 'effectScatter',-->
<!--coordinateSystem: 'geo',-->
<!--data: seriesArr-->
<!--}]-->
<!--}-->
<!--this.chartInstance.setOption(dataOption)-->
<!--},-->
