<!-- 地区销售排行 -->
<template>
  <div class='com-container'>
  <div class='com-chart' ref='rank_ref'></div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data () {
    return {
      chartInstance: null,
      allData: null,
      groupData: [],
      startValue: 0,
      endValue: 10,
      timerId: null
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
      this.chartInstance = this.$echarts.init(this.$refs.rank_ref, 'chalk')
      const initOption = {
        title: {
          text: '▎ 各大学的办学层次水平',
          left: 20,
          top: 20
        },
        xAxis: {
          type: 'category'
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            type: 'bar'
          }
        ],
        grid: {
          top: '27%',
          left: '5%',
          bottom: '1%',
          right: '5%',
          containLabel: true
        },
        tooltip: {
          show: true
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
    async getData () {
      // // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      // console.log(res)
      // this.allData = res
      // this.groupData = this.chulidata(this.allData)
      // console.log(this.groupData)
      // this.groupData.sort((a, b) => {
      //   return b.value - a.value
      // })
      // this.updateChart()
      // this.startInterval()
      try {
        const response = await axios.get('http://localhost:8080/api/scan-all-json')
        console.log(response.data)
        this.allData = response.data // 确保这里的 response.data 是一个数组

        console.log(response)
        this.groupData = this.chulidata(this.allData)
        console.log(this.groupData)
        this.groupData.sort((a, b) => {
          return b.value - a.value
        })
        this.updateChart()
        this.startInterval()
      } catch (error) {
        console.error('错误')
      }
    },
    chulidata (data) {
      // return data.reduce((acc, item) => {
      //   // 检查'办学层次'是否存在且不为空
      //   if (item['办学层次'] !== undefined && item['办学层次'] !== null && item['办学层次'] !== '') {
      //     // 将'办学层次'转换为浮点数
      //     const academicLevel = parseFloat(item['办学层次'])
      //     // 确保转换结果不是NaN
      //     if (!isNaN(academicLevel)) {
      //       acc.push({
      //         name: item['中文名'], // 提取'地址'作为name
      //         value: academicLevel // 提取'办学层次'作为value
      //       })
      //     }
      //   }
      //   return acc
      // }, [])

      return this.allData.reduce((acc, eachItem) => {
        const tags = eachItem.educationLevel // 获取办学层次
        // 检查'办学层次'是否存在且不为空
        if (tags !== undefined && tags !== null && tags !== '' && parseFloat(tags) <= 50) {
          // 将'办学层次'转换为浮点数
          const academicLevel = parseFloat(tags)
          // 确保转换结果不是NaN
          if (!isNaN(academicLevel)) {
            acc.push({
              name: eachItem.name, // 提取'地址'作为name
              value: academicLevel // 提取'办学层次'作为value
            })
          }
        }
        return acc
      }, [])
    },
    startInterval () {
      if (this.timerId) {
        clearInterval(this.timerId)
      }
      this.timerId = setInterval(() => {
        this.startValue++
        this.endValue++
        if (this.endValue > this.allData.length - 1) {
          this.startValue = 0
          this.endValue = 10
        }
        this.updateChart()
      }, 3000)
    },
    updateChart () {
      const colorArr = [
        ['#0BA82C', '#4FF778'],
        ['#2E72BF', '#23E5E5'],
        ['#5052EE', '#AB6EE5']
      ]
      // 处理图表需要的数据
      const provinceArr = this.groupData.map(item => {
        return item.name
      })
      const valueArr = this.groupData.map(item => {
        return item.value
      })
      const dataOption = {
        xAxis: {
          data: provinceArr,
          axisLabel: {
            showMinLabel: true,
            showMaxLabel: true,
            ellipsis: true, // 省略超出范围的文本
            rotate: 50, // 旋转标签角度
            fontSize: '7.5'
          }
        },
        dataZoom: {
          show: false,
          startValue: this.startValue,
          endValue: this.endValue
        },
        series: [
          {
            data: valueArr,
            itemStyle: {
              color: arg => {
                let targetColorArr = colorArr[0]
                if (arg.vaule >= 300) {
                  targetColorArr = colorArr[0]
                } else if (arg.value >= 200) {
                  targetColorArr = colorArr[1]
                } else {
                  targetColorArr = colorArr[2]
                }
                return new this.$echarts.graphic.LinearGradient(0,
                  1, 0, 0, [
                    {
                      offset: 0,
                      color: targetColorArr[0]
                    },
                    {
                      offset: 1,
                      color: targetColorArr[1]
                    }
                  ])
              }
            }
          }
        ]
      }
      this.chartInstance.setOption(dataOption)
    },
    screenAdapter () {
      const titleFontSize = this.$refs.rank_ref.offsetWidth / 100 * 2.7
      const adapterOption = {
        title: {
          textStyle: {
            fontSize: titleFontSize
          }
        },
        series: [
          {
            barWidth: titleFontSize,
            itemStyle: {
              barBorderRadius: [0.5 * titleFontSize, 0.5 *
              titleFontSize, 0, 0]
            }
          }
        ]
      }
      this.chartInstance.setOption(adapterOption)
      this.chartInstance.resize()
    }
  }
}
</script>
<style lang='less' scoped>
</style>
