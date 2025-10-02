<!-- 热销商品图表 -->
<template>
  <div class='com-container'>
    <div class='com-chart' ref='hot_ref'></div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      chartInstance: null,
      allData: [],
      currentIndex: 0,
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
    this.$socket.unRegisterCallBack('hotData')
  },
  methods: {
    initChart () {
      this.chartInstance = this.$echarts.init(this.$refs.hot_ref, 'chalk')
      const initOption = {
        title: {
          text: '▎ 大学类型的占比统计',
          left: 20,
          top: 20
        },
        legend: {
          top: '15%',
          icon: 'circle'
        },
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            // params 是系列数据的当前数据
            return `${params.name}: ${params.value} (${params.percent}%)` // 显示名称、数量和百分比
          }
        },
        series: [
          {
            type: 'pie',
            label: {
              show: false
            },
            emphasis: {
              label: {
                show: false
              },
              labelLine: {
                show: false
              }
            }
          }
        ]
      }
      this.chartInstance.setOption(initOption)
    },
    // async getData (ret) {
    //   // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
    //   // const { data: ret } = await this.$http.get('hotproduct')
    //   const { data: res } = await this.$http.get('2024daxue') // 获取数据
    //   console.log(res)
    //   this.allData = res
    //   this.groupData = this.chulidata(this.allData)
    //   console.log(this.groupData)
    //   this.updateChart()
    // },
    async getData (res) {
      // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
      // axios.get('http://localhost:8080/api/scan-all')
      //   .then(res => {
      //     ret = res.data
      //   })
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      try {
        const response = await axios.get('http://localhost:8080/api/scan-all-json')
        console.log(response.data)
        this.allData = response.data // 确保这里的 response.data 是一个数组

        console.log(response)
        this.groupData = this.chulidata(this.allData)
        console.log(this.groupData)
        this.updateChart()
      } catch (error) {
        console.error('错误')
      }
    },
    chulidata () {
      // 使用 reduce 方法聚合标签数量
      const tagCounts = this.allData.reduce((acc, eachItem) => {
        let tags = eachItem.tags
        if (!tags) {
          tags = '双非'
        }
        // 假设 tags 是以逗号分隔的字符串，我们将其分割成数组
        tags.split(',').forEach(tag => {
          if (tag && /[\u4e00-\u9fa5]/.test(tag)) { // 确保标签不为空
            acc[tag] = (acc[tag] || 0) + 1 // 初始化计数
          }
        })
        return acc
      }, {})
      // 将对象转换为数组，数组中的每个元素都是 { name: '标签名称', value: '数量' }
      return Object.keys(tagCounts).map(tag => {
        return { name: tag, value: tagCounts[tag] }
      })
    },
    updateChart () {
      // 处理图表需要的数据
      const legendData = this.groupData.map(item => {
        return item.name
      })
      const seriesData = this.groupData.map(item => {
        return {
          name: item.name,
          value: item.value
        }
      })
      const dataOption = {
        legend: {
          data: legendData
        },
        series: [
          {
            data: seriesData
          }
        ]
      }
      this.chartInstance.setOption(dataOption)
    },
    screenAdapter () {
      this.titleFontSize = this.$refs.hot_ref.offsetWidth / 100 * 3.6
      const adapterOption = {
        title: {
          textStyle: {
            fontSize: this.titleFontSize
          }
        },
        series: [ // 饼图的大小和位置
          {
            radius: this.titleFontSize * 5,
            center: ['50%', '60%']
          }
        ],
        legend: { // 图例大小
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
