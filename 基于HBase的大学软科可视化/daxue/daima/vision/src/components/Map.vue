<!-- 商家分布图表 -->
<template>
  <div class='com-container' @dblclick="revertMap">
    <div class='com-chart' ref='map_ref'></div>
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
      threshold: 10 // 默认阈值
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
  },
  methods: {
    revertMap () {
      this.chartInstance.setOption({
        geo: {
          map: 'china'
        }
      })
    },
    async initChart () {
      this.chartInstance = this.$echarts.init(this.$refs.map_ref, 'chalk')
      const ret = await axios.get('http://localhost:8899/static/map/china.json')
      this.$echarts.registerMap('china', ret.data)
      const initOption = {
        title: {
          text: '▎ 不同省份的大学数量',
          left: 20,
          top: 20
        },
        geo: {
          type: 'map',
          map: 'china',
          top: '5%',
          bottom: '5%',
          itemStyle: {
            areaColor: '#2E72BF',
            borderColor: '#333'
          }
        },
        legend: {
          left: '5%',
          bottom: '5%',
          orient: 'vertical'
        }
      }

      this.chartInstance.setOption(initOption)
      const name2pinyin = {
        安徽: 'anhui',
        陕西: 'shanxi1',
        澳门: 'aomen',
        北京: 'beijing',
        重庆: 'chongqing',
        福建: 'fujian',
        甘肃: 'gansu',
        广东: 'guangdong',
        广西: 'guangxi',
        贵州: 'guizhou',
        海南: 'hainan',
        河北: 'hebei',
        黑龙江: 'heilongjiang',
        河南: 'henan',
        湖北: 'hubei',
        湖南: 'hunan',
        江苏: 'jiangsu',
        江西: 'jiangxi',
        吉林: 'jilin',
        辽宁: 'liaoning',
        内蒙古: 'neimenggu',
        宁夏: 'ningxia',
        青海: 'qinghai',
        山东: 'shandong',
        上海: 'shanghai',
        山西: 'shanxi',
        四川: 'sichuan',
        台湾: 'taiwan',
        天津: 'tianjin',
        香港: 'xianggang',
        新疆: 'xinjiang',
        西藏: 'xizang',
        云南: 'yunnan',
        浙江: 'zhejiang'
      }
      function getProvinceMapInfo (arg) {
        const path = `/static/map/province/${name2pinyin[arg]}.json`
        return {
          key: name2pinyin[arg],
          path: path
        }
      }
      this.chartInstance.on('click', async arg => {
        // arg.name 就是所点击的省份名称, 是中文
        const provinceInfo = getProvinceMapInfo(arg.name)
        const ret = await axios.get('http://localhost:8899' + provinceInfo.path)
        this.$echarts.registerMap(provinceInfo.key, ret.data)
        const changeOption = {
          geo: {
            map: provinceInfo.key
          }
        }
        this.chartInstance.setOption(changeOption)
      })
    },

    async getData () {
      // 获取服务器的数据, 对this.allData进行赋值之后, 调用updateChart方法更新图表
      // const { data: res } = await this.$http.get('2024daxue') // 获取数据
      // console.log(res)
      // this.allData = res
      // this.groupData = this.chulidata(this.allData)
      // console.log(this.groupData)
      // this.updateChart()
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
    chulidata (data) {
      // 使用 reduce 方法聚合标签数量
      const tagCounts = this.allData.reduce((acc, eachItem) => {
        const tags = eachItem.address
        // 假设 tags 是以逗号分隔的字符串，我们将其分割成数组
        tags.split(',').forEach(tag => {
          tag = tag.trim()
          if (tag) { // 确保标签不为空
            acc[tag] = (acc[tag] || 0) + 1 // 初始化计数
          }
        })
        return acc
      }, {})
      // 将对象转换为数组，数组中的每个元素都是 { name: '标签名称', value: '数量' }
      const formattedData = Object.keys(tagCounts).map(tag => {
        return { 地址: tag, 数量: tagCounts[tag] }
      })
      return formattedData.slice(0, -1)

      // // 使用 reduce 函数来累积每个地址的学校数量
      // const groupedData = data.reduce((acc, item) => {
      //   const address = item.地址 // 假设每条数据都有一个 '地址' 属性
      //   if (!acc[address]) {
      //     acc[address] = 0 // 初始化计数为 0
      //   }
      //   acc[address]++ // 对该地址的学校数进行计数
      //   return acc
      // }, {})
      // // 将累积的结果转换为数组，以便于在图表中显示
      // const formattedData = Object.entries(groupedData).map(([address, count]) => {
      //   return { 地址: address, 数量: count }
      // })
      // return formattedData.slice(0, -1)
    },
    updateChart () {
      const addressCoordMap = {
        北京: [116.4074, 39.9042], // 北京
        天津: [117.2009, 39.0842], // 天津
        上海: [121.4737, 31.2304], // 上海
        重庆: [106.5478, 29.5628], // 重庆
        河北: [114.5149, 38.0428], // 石家庄
        山西: [112.5627, 37.8735], // 太原
        辽宁: [123.4315, 41.8055], // 沈阳
        吉林: [125.3268, 43.8160], // 长春
        黑龙江: [126.6427, 45.7732], // 哈尔滨
        江苏: [118.7674, 32.0415], // 南京
        浙江: [120.1536, 30.2400], // 杭州
        安徽: [117.2830, 31.8615], // 合肥
        福建: [119.2965, 26.0745], // 福州
        江西: [115.8926, 28.6635], // 南昌
        山东: [117.0009, 36.6512], // 济南
        河南: [113.6254, 34.7466], // 郑州
        湖北: [114.3162, 30.5750], // 武汉
        湖南: [112.9335, 28.2282], // 长沙
        广东: [113.2644, 23.1291], // 广州
        海南: [110.3407, 20.0242], // 海口
        四川: [104.0668, 30.5728], // 成都
        贵州: [106.7142, 26.5783], // 贵阳
        云南: [102.7044, 25.0428], // 昆明
        陕西: [108.9315, 34.3416], // 西安
        甘肃: [103.8252, 36.0611], // 兰州
        青海: [101.7841, 36.6170], // 西宁
        台湾: [121.4618, 25.0344], // 台北
        内蒙古: [111.6549, 40.8207], // 呼和浩特
        广西: [108.3333, 22.8240], // 南宁
        宁夏: [106.2592, 38.4738], // 银川
        新疆: [87.6168, 43.8256], // 乌鲁木齐
        西藏: [91.1409, 29.6469] // 拉萨
      }
      function convertAddressToCoord (address) {
        const coord = addressCoordMap[address]
        return coord || [120, 30] // 如果没有找到地址，返回默认坐标
      }

      const getColorByCount = (count) => {
        if (count > 30) {
          return '#0ff000' // 红色
        } else if (count > 20) {
          return '#ef5767' // 橙色
        } else if (count > 10) {
          return '#00FFFF' // 黄色
        } else {
          return '#0000FF' // 默认蓝色
        }
      }

      const seriesData = this.groupData.map(item => {
        const coord = convertAddressToCoord(item.地址)
        return {
          name: item.地址,
          value: coord.concat(item.数量), // ECharts 需要 [经度, 纬度, 数量] 的格式
          symbolSize: Math.max(10, item.数量 * 0.5), // 根据数量设置散点大小
          itemStyle: {
            normal: {
              color: getColorByCount(item.数量) // 设置散点颜色
            }
          }
        }
      })
      const legendData = [
        { name: '>30', icon: 'circle', textStyle: { color: '#b8d38f' } },
        { name: '20-30', icon: 'circle', textStyle: { color: '#ef5767' } },
        { name: '10-20', icon: 'circle', textStyle: { color: '#81CEC8' } },
        { name: '<10', icon: 'circle', textStyle: { color: '#0000FF' } }
      ]
      console.log(legendData)
      const dataOption = {
        tooltip: {
          trigger: 'item',
          formatter: '{b}<br/>{c} (大学数量)'
        },
        legend: {
          data: legendData
        },
        series: [{
          name: '大学分布',
          type: 'effectScatter',
          rippleEffect: {
            scale: 5,
            brushType: 'stroke'
          },
          coordinateSystem: 'geo', // 指定坐标系为地理坐标系
          data: seriesData,
          symbolSize: function (val) {
            return val[2] * 10 // 根据数量设置大小
          },
          label: {
            normal: {
              formatter: '{b}',
              position: 'right',
              show: false
            },
            emphasis: {
              show: true
            }
          },
          itemStyle: {
            normal: {
              color: function (val) {
                return getColorByCount(val[2]) // 根据数量获取颜色
              }
            }
          }
        }]
      }

      this.chartInstance.setOption(dataOption)
    },
    screenAdapter () {
      const titleFontSize = this.$refs.map_ref.offsetWidth / 100 * 3.6
      const adapterOption = {
        title: {
          textStyle: {
            fontSize: titleFontSize
          }
        }
        // legend: {
        //   itemWidth: titleFontSize / 2,
        //   itemHeight: titleFontSize / 2,
        //   itemGap: titleFontSize / 2,
        //   textStyle: {
        //     fontSize: titleFontSize / 2
        //   }
        // }
      }
      this.chartInstance.setOption(adapterOption)
      this.chartInstance.resize()
    }
  }
}
</script>
<style lang='less' scoped>
</style>
