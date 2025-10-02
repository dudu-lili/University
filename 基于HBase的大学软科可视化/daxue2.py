import pandas as pd
from bs4 import BeautifulSoup
import bs4
from selenium import webdriver
from selenium.webdriver.common.by import By

option = webdriver.ChromeOptions()

# option是让谷歌一直开着，而不是只打开一下子就关掉
option.add_experimental_option("detach", True)
# 定义url
url = "https://www.shanghairanking.cn/rankings/bcur/2024"
# 启动谷歌浏览器
browser = webdriver.Chrome(options=option)
# 访问url
browser.get(url)
# 隐式等待
browser.implicitly_wait(10)

# 先创建一个数组，保存结果
contents = []

def get_info(element, method, tag, **kwargs):
    if method == "find":
        return element.find(tag, **kwargs)
    elif method == "find_all":
        return element.find_all(tag, **kwargs)
# 检索数据取出放进数组里面
def get_data(page):
    # 获取全部网页信息
    html = browser.page_source
    soup = BeautifulSoup(html, "html.parser")
    # print(soup)
    # 找到tbody的子节点
    for tr in soup.find('tbody').children:
        # 判断tr是否属于子节点中
        # if isinstance(tr, bs4.element.Tag):
        #
        #     tds = tr('td')
        #     # 获取文本，清除换行符，清空空格
        #     name = tr.find(class_="name-cn").text.replace('\n', '').strip()
        #     contents.append([tds[0].text.strip(),name,tds[2].text.strip(), tds[3].text.strip(),
        #                      tds[4].text.strip(), tds[5].text.strip()])
        if isinstance(tr, bs4.element.Tag):  # 如果为Tag类型
            # tds = tr('td')
            #     # 获取文本，清除换行符，清空空格
            #     name = tr.find(class_="name-cn").text.replace('\n', '').strip()
            #     contents.append([tds[0].text.strip(),name,tds[2].text.strip(), tds[3].text.strip(),
            #                      tds[4].text.strip(), tds[5].text.strip()])
            td_list = tr.find_all('td')
            "排名"
            top = td_list[0].text.strip()
            "logo"
            logo = td_list[1].find('img')["src"]
            "中文名/英文名"
            university_list = get_info(td_list[1], "find_all", "a")
            ch_name = tr.find(class_="name-cn").text.replace('\n', '').strip()#university_list[0].string.replace("\n", "").replace("\t", "").strip(" ")
            en_name =tr.find(class_="name-en").text.replace('\n', '').strip()# university_list[1].string.replace("\n", "").strip(" ")
            "学校标签"
            tag=td_list[1].find('p')
            tags=tag.text.strip()if tag else "" #get_info(td_list[1], "find", "p")

            "学校地址"
            area = td_list[2].text.replace("\n", "").strip(" ")
            "学校行业"
            main = td_list[3].text.replace("\n", "").strip(" ")
            "综合分数"
            score = td_list[4].text.replace("\n", "").strip(" ")
            "办学层次"
            layer = td_list[5].text.replace("\n", "").strip(" ")
            # 添加到列表
            contents.append([top, ch_name, en_name, tags, area, main, score, layer, logo])




def get_all():
    page = 1
    while page <=20:  # 循环页数
        # print("开始爬取第", page, "页")
        get_data(page)  # 每次循环都要调用一次获取数据的函数
        next_page = browser.find_element(By.CSS_SELECTOR, 'li.ant-pagination-next>a')
        next_page.click()  # 点击下一页，selenium内置的点击事件
        page += 1  # 循环完加一


def save_data(data):
    first_name = ['排名', '中文名', '英文名', '标签', '地址', '行业', '分数', '办学层次', 'Logo']
    rank = pd.DataFrame(data, columns=first_name)
    # 将字符串转为int或float类型
    rank["排名"] = rank["排名"].astype(int)
    rank["分数"] = rank["分数"].astype(float)
    # pd.to_numeric函数errors参数设为'coerce'，可以将无效解析设置为NaN
    rank["办学层次"] = rank["办学层次"].apply(pd.to_numeric, errors='coerce')
    print(rank)
    # print(rank.head())

    # rank.to_csv("2024daxue.csv", index=False)
    print("保存成功！")


if __name__ == '__main__':
    get_all()
    save_data(contents)
    # 关闭浏览器
    browser.quit()

