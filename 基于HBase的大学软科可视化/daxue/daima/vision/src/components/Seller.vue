<!-- 商家销量统计的横向柱状图 -->
<template>
  <div class="com-container">
    <div class="com-chart" ref="seller_ref"></div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      chartInstance: null, // echarts实例对象
      allData: [], // 服务器获取的所有数据
      groupData: [],
      currentPage: 1, // 当前显示的页数
      totalPage: 0, // 一共有多少页，需要计算
      timerId: null // 定时器标识
    }
  },
  mounted () {
    // 由于初始化echarts实例对象需要使用到dom元素,因此必须要放到mounted中, 而不是created
    this.initChart()
    this.getData()
    window.addEventListener('resize', this.screenAdapter)
    // 在页面加载完成的时候，主动进行屏幕的适配
    this.screenAdapter()
  },
  destroyed () {
    clearInterval(this.timerId)
    // 在组件销毁的时候, 需要将监听器取消掉
    window.removeEventListener('resize', this.screenAdapter)
  },
  methods: {
    initChart () {
      this.chartInstance = this.$echarts.init(this.$refs.seller_ref, 'chalk') // 初始化echarts实例对象
      // 对图表初始化配置的控制
      const initOption = {
        title: {
          text: '▎ 不同省份的大学软科平均总分',
          left: 20,
          top: 20
        },
        grid: {
          top: '20%',
          left: '3%',
          right: '11%',
          bottom: '3%',
          containLabel: true// 坐标轴设置的距离是包含文字的
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'line',
            z: 0
          }
        },
        xAxis: {
          type: 'value'
        },
        yAxis: {
          type: 'category'
        },
        tooltipOption: {
          trigger: 'axis',
          axisPointer: {
            type: 'line',
            z: 0,
            lineStyle: {
              width: 66,
              color: '#2D3443'
            }
          }
        },
        series: [
          {
            type: 'bar',
            itemStyle: {
              color: new this.$echarts.graphic.LinearGradient(0, 0, 1, 0, [
                {
                  offset: 0,
                  color: '#5052EE'
                },
                {
                  offset: 1,
                  color: '#AB6EE5'
                }
              ])
            },
            label: {
              show: true,
              position: 'right',
              textStyle: {
                color: '#fff'
              }
            }
          }
        ]
      }
      this.chartInstance.setOption(initOption)
      this.chartInstance.on('mouseover', () => {
        clearInterval(this.timerId)
      })
      this.chartInstance.on('mouseout', () => {
        this.startInterval()
      })
    },
    async getData () {
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      // console.log(res)
      // this.allData = res
      // // 对allData进行从大到小的排序
      // // this.allData.sort((a, b) => {
      // //   return a.value - b.value
      // // })
      // // 处理数据
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
      // // 按地址分类并累加分数
      // data.forEach(item => {
      //   if (groupedData[item.地址]) {
      //     groupedData[item.地址].push(parseFloat(item.分数))
      //   } else {
      //     groupedData[item.地址] = [parseFloat(item.分数)]
      //   }
      // })
      // // 计算每个地址的平均分
      // const averageData = Object.keys(groupedData).map(address => {
      //   const sum = groupedData[address].reduce((acc, score) => acc + score, 0)
      //   const average = sum / groupedData[address].length
      //   return { 地址: address, 平均分: average }
      // })
      // // 对groupData进行从大到小的排序
      // averageData.sort((a, b) => {
      //   return a.平均分 - b.平均分
      // })
      // // averageData.slice(0, -1)
      // this.totalPage = averageData.length % 4 === 0 ? parseInt(averageData.length / 4) : parseInt(averageData.length / 4) + 1
      // return averageData.slice(0, -1)
      // 初始化用于存储地址和对应分数的数组
      const groupedData = this.allData.reduce((acc, eachItem) => {
        // 假设 eachItem.address 是以逗号分隔的字符串，我们将其分割成数组
        eachItem.address.split(',').forEach(address => {
          address = address.trim() // 去除地址两端的空格
          if (address) { // 确保地址不为空
            const score = parseFloat(eachItem.score) // 确保分数是浮点数
            if (!isNaN(score)) { // 确保分数是有效的数字
              if (acc[address]) {
                acc[address].push(score)
              } else {
                acc[address] = [score]
              }
            }
          }
        })
        return acc
      }, {})

      // 将对象转换为数组，数组中的每个元素都是 { 地址: '地址', 平均分: '平均分数' }
      const formattedData = Object.keys(groupedData).map(address => {
        const scores = groupedData[address]
        const sum = scores.reduce((acc, score) => acc + score, 0)
        const average = scores.length > 0 ? parseFloat((sum / scores.length).toFixed(2)) : 0 // 避免除以零
        return { 地址: address, 平均分: average }
      })

      // 对formattedData进行从大到小的排序
      formattedData.sort((a, b) => {
        return b.平均分 - a.平均分
      })

      // 计算总页数，假设每页显示4条数据
      this.totalPage = Math.ceil(formattedData.length / 4)

      // 返回除了最后一页之外的所有数据
      const dataToShow = formattedData.slice(0, this.totalPage * 4 - 1)

      // 过滤确保平均分是有效的数字
      const validData = dataToShow.filter(item => {
        return typeof item.平均分 === 'number' && !isNaN(item.平均分)
      })

      return validData
    },
    updateChart () {
      const start = (this.currentPage - 1) * 4
      const end = this.currentPage * 4
      const showData = this.groupData.slice(start, end)
      // 处理数据并且更新界面图表
      const sellerNames = showData.map((item) => {
        return item.地址
      })
      const sellerValues = showData.map((item) => {
        return item.平均分.toFixed(2)
      })
      const dataoption = {
        yAxis: {
          data: sellerNames
        },
        series: [
          {
            data: sellerValues
          }
        ]
      }
      this.chartInstance.setOption(dataoption)
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
    },
    // 当浏览器的大小发生变化的时候, 会调用的方法, 来完成屏幕的适配
    screenAdapter () {
      // console.log(this.$refs.seller_ref.offsetWidth)
      const titleFontSize = this.$refs.seller_ref.offsetWidth / 100 * 3.6
      // 和分辨率大小相关的配置项
      const adapterOption = {
        title: {
          textStyle: {
            fontSize: titleFontSize
          }
        },
        tooltip: {
          axisPointer: {
            lineStyle: {
              width: titleFontSize
            }
          }
        },
        series: [
          {
            barWidth: titleFontSize,
            itemStyle: {
              barBorderRadius: [0, titleFontSize / 2,
                titleFontSize / 2, 0]
            }
          }
        ]
      }
      this.chartInstance.setOption(adapterOption)
      // 手动的调用图表对象的resize 才能产生效果
      this.chartInstance.resize()
    }
  }
}
</script>

<!--<script>-->
<!--export default {-->
<!--  data () {-->
<!--    return {-->
<!--      chartInstance: null, // echarts实例对象-->
<!--      allData: [], // 服务器获取的所有数据-->
<!--      groupData: [],-->
<!--      currentPage: 1, // 当前显示的页数-->
<!--      totalPage: 0, // 一共有多少页，需要计算-->
<!--      timerId: null // 定时器标识-->
<!--    }-->
<!--  },-->
<!--  mounted () {-->
<!--    // 由于初始化echarts实例对象需要使用到dom元素,因此必须要放到mounted中, 而不是created-->
<!--    this.initChart()-->
<!--    this.getData()-->
<!--    window.addEventListener('resize', this.screenAdapter)-->
<!--  },-->
<!--  destroyed () {-->
<!--    clearInterval(this.timerId)-->
<!--    // 在组件销毁的时候, 需要将监听器取消掉-->
<!--    window.removeEventListener('resize', this.screenAdapter)-->
<!--  },-->
<!--  methods: {-->
<!--    initChart () {-->
<!--      this.chartInstance = this.$echarts.init(this.$refs.seller_ref, 'chalk') // 初始化echarts实例对象-->
<!--      this.chartInstance.on('mouseover', () => {-->
<!--        clearInterval(this.timerId)-->
<!--      })-->
<!--      this.chartInstance.on('mouseout', () => {-->
<!--        this.startInterval()-->
<!--      })-->
<!--    },-->
<!--    async getData () {-->
<!--      const { data: res } = await this.$http.get('2024daxue') // 获取数据-->
<!--      console.log(res)-->
<!--      this.allData = res-->
<!--      // 对allData进行从大到小的排序-->
<!--      // this.allData.sort((a, b) => {-->
<!--      //   return a.value - b.value-->
<!--      // })-->
<!--      // 处理数据-->
<!--      this.groupData = this.calculateAverageByAddress(this.allData)-->
<!--      console.log(this.groupData)-->
<!--      this.updateChart()-->
<!--      this.startInterval() // 开启动画效果-->
<!--    },-->
<!--    calculateAverageByAddress (data) {-->
<!--      const groupedData = {}-->
<!--      // 按地址分类并累加分数-->
<!--      data.forEach(item => {-->
<!--        if (groupedData[item.地址]) {-->
<!--          groupedData[item.地址].push(parseFloat(item.分数))-->
<!--        } else {-->
<!--          groupedData[item.地址] = [parseFloat(item.分数)]-->
<!--        }-->
<!--      })-->
<!--      // 计算每个地址的平均分-->
<!--      const averageData = Object.keys(groupedData).map(address => {-->
<!--        const sum = groupedData[address].reduce((acc, score) => acc + score, 0)-->
<!--        const average = sum / groupedData[address].length-->
<!--        return { 地址: address, 平均分: average }-->
<!--      })-->
<!--      // 对groupData进行从大到小的排序-->
<!--      averageData.sort((a, b) => {-->
<!--        return a.平均分 - b.平均分-->
<!--      })-->
<!--      // averageData.slice(0, -1)-->
<!--      this.totalPage = averageData.length % 4 === 0 ? parseInt(averageData.length / 4) : parseInt(averageData.length / 5) + 1-->
<!--      return averageData.slice(0, -1)-->
<!--    },-->
<!--    updateChart () {-->
<!--      const start = (this.currentPage - 1) * 4-->
<!--      const end = this.currentPage * 4-->
<!--      const showData = this.groupData.slice(start, end)-->
<!--      // 处理数据并且更新界面图表-->
<!--      const sellerNames = showData.map((item) => {-->
<!--        return item.地址-->
<!--      })-->
<!--      const sellerValues = showData.map((item) => {-->
<!--        return item.平均分.toFixed(2)-->
<!--      })-->
<!--      const option = {-->
<!--        title: {-->
<!--          text: '▎ 不同省份的大学软科平均总分',-->
<!--          left: 20,-->
<!--          top: 20,-->
<!--          textStyle: {-->
<!--            textStyle: {-->
<!--              color: '#fff'-->
<!--            }-->
<!--          }-->
<!--        },-->
<!--        grid: {-->
<!--          top: '20%',-->
<!--          left: '3%',-->
<!--          right: '6%',-->
<!--          bottom: '3%',-->
<!--          containLabel: true// 坐标轴设置的距离是包含文字的-->
<!--        },-->
<!--        tooltip: {-->
<!--          trigger: 'axis',-->
<!--          axisPointer: {-->
<!--            type: 'line',-->
<!--            z: 0,-->
<!--            lineStyle: {-->
<!--              width: 66,-->
<!--              color: '#2D3443'-->
<!--            }-->
<!--          }-->
<!--        },-->
<!--        xAxis: {-->
<!--          type: 'value'-->
<!--        },-->
<!--        yAxis: {-->
<!--          type: 'category',-->
<!--          data: sellerNames-->
<!--        },-->
<!--        tooltipOption: {-->
<!--          trigger: 'axis',-->
<!--          axisPointer: {-->
<!--            type: 'line',-->
<!--            z: 0,-->
<!--            lineStyle: {-->
<!--              width: 66,-->
<!--              color: '#2D3443'-->
<!--            }-->
<!--          }-->
<!--        },-->
<!--        series: [-->
<!--          {-->
<!--            type: 'bar',-->
<!--            data: sellerValues,-->
<!--            barWidth: 66,-->
<!--            itemStyle: {-->
<!--              barBorderRadius: [0, 33, 33, 0],-->
<!--              color: new this.$echarts.graphic.LinearGradient(0, 0, 1, 0, [-->
<!--                {-->
<!--                  offset: 0,-->
<!--                  color: '#5052EE'-->
<!--                },-->
<!--                {-->
<!--                  offset: 1,-->
<!--                  color: '#AB6EE5'-->
<!--                }-->
<!--              ])-->
<!--            },-->
<!--            label: {-->
<!--              show: true,-->
<!--              position: 'right',-->
<!--              textStyle: {-->
<!--                color: '#fff'-->
<!--              }-->
<!--            }-->
<!--          }-->
<!--        ]-->
<!--      }-->
<!--      this.chartInstance.setOption(option)-->
<!--    },-->
<!--    startInterval () {-->
<!--      if (this.timerId) {-->
<!--        clearInterval(this.timerId)-->
<!--      }-->
<!--      this.timerId = setInterval(() => {-->
<!--        this.currentPage++-->
<!--        if (this.currentPage > this.totalPage) {-->
<!--          this.currentPage = 1-->
<!--        }-->
<!--        this.updateChart()-->
<!--      }, 3000)-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->
