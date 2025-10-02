<!-- 库存销量分析 -->
<template>
  <div class='com-container'>
    <div class='com-chart' ref='stock_ref'></div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      chartInstance: null,
      allData: null,
      currentPage: 1, // 当前显示的页数
      totalPage: 0, // 一共有多少页，需要计算
      timerId: null,
      titleFontSize: 0
    }
  },
  mounted () {
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
      this.chartInstance = this.$echarts.init(this.$refs.stock_ref, 'chalk')
      const initOption = {
        title: {
          text: '▎ 各地区大学类型分布',
          left: 20,
          top: 20
        },
        legend: {
          orient: 'vertical', // 图例布局为垂直
          left: 'left', // 图例显示在容器的左侧
          bottom: 'bottom' // 图例显示在容器的顶部 // 初始时图例数据为空，将由 updateChart 方法填充
        }
      }
      this.chartInstance.setOption(initOption)
      this.chartInstance.on('mouseover', () => {
        clearInterval(this.timerId)
      })
      this.chartInstance.on('mouseout', () => {
        this.startInterval()
      })
    },
    startInterval () {
      if (this.timerId) {
        clearInterval(this.timerId)
      }
      this.timerId = setInterval(() => {
        this.currentPage++
        if (this.currentPage > this.totalPage) {
          this.currentPage = 0
        }
        this.updateChart()
      }, 3000)
    },
    async getData () {
      // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
      // const { data: ret } = await this.$http.get('stock')
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      // console.log(res)
      // this.allData = res
      // this.groupData = (this.chulidata(this.allData)).slice(0, -1)
      // console.log(this.groupData)
      // // this.groupData.sort((a, b) => {
      // //   return b.value - a.value
      // // })
      // const totalPage = this.groupData.length % 5 === 0 ? parseInt(this.groupData.length / 5) : parseInt(this.groupData.length / 5) + 1
      // this.totalPage = totalPage
      // this.updateChart()
      // this.startInterval()
      try {
        const response = await axios.get('http://localhost:8080/api/scan-all-json')
        console.log(response.data)
        this.allData = response.data // 确保这里的 response.data 是一个数组
        console.log(response)
        this.groupData = this.chulidata(this.allData)
        const totalPage = this.groupData.length % 5 === 0 ? parseInt(this.groupData.length / 5) : parseInt(this.groupData.length / 5) + 1
        this.totalPage = totalPage
        console.log(this.groupData)
        this.updateChart()
        this.startInterval()
      } catch (error) {
        console.error('Error fetching data:', error)
      }
    },
    chulidata (data) {
      // // 用于存储聚合后数据的对象
      // const groupedData = {}
      // data.forEach(item => {
      //   const address = item['地址'] // 假设数据中有一个 '地址' 字段
      //   const industry = item['行业'] // 假设数据中有一个 '行业' 字段
      //
      //   // 如果地址不在 groupedData 中，初始化地址对象
      //   if (!groupedData[address]) {
      //     groupedData[address] = {
      //       name: address, // 地址作为 name
      //       value: [] // 初始化 value 数组
      //     }
      //   }
      //
      //   // 检查该地址是否已经记录了该行业，如果没有则添加
      //   let industryFound = false
      //   groupedData[address].value.forEach(industryItem => {
      //     if (industryItem.n === industry) {
      //       industryItem.v++ // 如果找到，增加该行业的计数
      //       industryFound = true
      //     }
      //   })
      //
      //   // 如果没有找到该行业的记录，添加新记录
      //   if (!industryFound) {
      //     groupedData[address].value.push({ n: industry, v: 1 })
      //   }
      // })
      // // 最终返回聚合后的数据数组
      // return Object.values(groupedData)

      // 初始化 groupedData 用于存储按地址和行业分组的数据
      const groupedData = {}

      // 使用 forEach 对 allData 进行处理
      this.allData.forEach(eachItem => {
        const address = eachItem.address
        const industry = eachItem.industry

        // 检查 groupedData 中是否已经有当前地址的记录
        if (!groupedData[address]) {
          groupedData[address] = { name: address, value: [] } // 初始化地址和行业数组
        }

        // 检查当前地址下是否已经有当前行业的记录
        let industryFound = false
        groupedData[address].value.forEach(industryItem => {
          if (industryItem.n === industry) {
            industryItem.v++ // 如果找到，增加该行业的计数
            industryFound = true
          }
        })

        // 如果当前行业未被记录，则添加到数组中
        if (!industryFound) {
          groupedData[address].value.push({ n: industry, v: 1 })
        }
      })

      // 将 groupedData 转换为格式化的数组
      const formattedData = Object.keys(groupedData).map(address => groupedData[address])

      return formattedData.slice(0, -2)
    },
    updateChart () {
      const start = (this.currentPage - 1) * 5
      const end = this.currentPage * 5
      const showData = this.groupData.slice(start, end)
      // 处理图表需要的数据
      // 5个圆环对应的圆心点
      const centerPointers = [
        // ['18%', '40%'],
        // ['50%', '40%'],
        // ['82%', '40%'],
        // ['34%', '75%'],
        // ['66%', '75%']
        ['18%', '37%'],
        ['50%', '37%'],
        ['82%', '37%'],
        ['34%', '73%'],
        ['66%', '73%']
      ]
      const legendData = []
      const seriesArr = showData.map((group, index) => ({
        name: group.name,
        type: 'pie',
        center: centerPointers[index],
        hoverAnimation: false,
        radius: ['30%', '40%'], // 可以根据需要调整半径
        label: {
          show: true,
          normal: {
            position: 'center', // 标签位置设置为中心
            formatter: group.name, // 设置标签的文本为地址
            textStyle: {
              fontSize: 16, // 设置字体大小
              color: '#FFFFFF', // 设置字体颜色
              fontWeight: 'bold' // 设置字体加粗
            }
          }
        },
        data: group.value.map(industry => {
          if (!legendData.includes(industry.n)) {
            legendData.push(industry.n)
          }
          return {
            value: industry.v, // 行业数作为数据值
            name: industry.n // 行业名称
          }
        })
      }))
      const dataOption = {
        tooltip: {
          trigger: 'item', // 鼠标移动到数据项上时触发
          formatter: function (params) {
            var value = params.value
            var name = params.name
            return name + ' : ' + value
          }
        },
        legend: {
          data: legendData // 设置图例数据
        },
        series: seriesArr
      }
      this.chartInstance.setOption(dataOption)
    },
    screenAdapter () {
      this.titleFontSize = this.$refs.stock_ref.offsetWidth / 100 * 3.6
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
