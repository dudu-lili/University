# import imageio as imageio
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer
from sklearn.preprocessing import label_binarize
# import WordCloud

# 设置中文字体
plt.rcParams['font.sans-serif'] = ['SimHei']  # 'SimHei' 是一种常见的中文字体
plt.rcParams['axes.unicode_minus'] = False  # 正确显示负号
# 读取CSV文件
df = pd.read_csv('datas/tokenized_weibo.csv')
print(df.head())

# # 计算'label'列中每个值出现的次数
# label_counts = df['label'].value_counts()
# # 准备标签说明
# labels = ['喜悦', '愤怒', '厌恶', '低落']
# # 绘制饼图，并添加自定义的百分比标签和描述
# plt.figure(figsize=(8, 8))  # 可以设置图表大小
# plt.pie(label_counts, labels=labels, autopct='%1.1f%%', startangle=140)
# # 添加标题
# plt.title('情感分布图')
# # 保存图表到指定目录
# plt.savefig('./static/pie_chart.png')  # 保存为PNG格式，您可以根据需要更改文件路径和格式
# # 显示图表
# plt.show()




# # 使用TfidfVectorizer进行TF-IDF关键词提取
# df['tokenized_text'] = df['tokenized_text'].fillna('')
# tfidf_vectorizer = TfidfVectorizer(max_features=5000)
# tfidf_matrix = tfidf_vectorizer.fit_transform(df['tokenized_text'])
# feature_names = tfidf_vectorizer.get_feature_names_out()
#
# # 获取前100个关键词
# top_n_words = 100
# top_tfidf_feat = tfidf_matrix.toarray().sum(axis=0)
# top_indices = top_tfidf_feat.argsort()[-top_n_words:][::-1]
# top_words = [feature_names[i] for i in top_indices]
# print(top_words)
#
# back_pic = imageio.imread("./static/background.jpg")
# # 词云图，增加 width 和 height 参数以提高分辨率
# wordcloud = WordCloud(
#     width=2000,  # 增加宽度
#     height=1200,  # 增加高度
#     background_color='white',
#     mask=back_pic,
#     font_path='C:/Windows/Fonts/simkai.ttf'
# ).generate(' '.join(top_words))
# # 显示图像
# plt.figure(figsize=(10, 6))  # 可以调整图像大小以适应词云图
# plt.imshow(wordcloud, interpolation='bilinear')
# plt.axis('off')
# plt.title('词云图')
# # 保存图像，增加 DPI 参数以提高清晰度
# plt.savefig('./static/wordcloud_chart.png', dpi=300)  # 增加 DPI
# plt.show()



# df['tokenized_text'] = df['tokenized_text'].fillna('')
#
# # 使用 CountVectorizer 进行词频统计
# count_vectorizer = CountVectorizer(max_features=5000)
# count_matrix2 = count_vectorizer.fit_transform(df['tokenized_text'])
# feature_names2 = count_vectorizer.get_feature_names_out()
#
# # 获取前10个出现次数最多的词
# top_n_words = 10
# top_counts = count_matrix2.sum(axis=0).A1  # 计算每个词的总出现次数
# top_indices = top_counts.argsort()[-top_n_words:][::-1]
# top_words = [feature_names2[i] for i in top_indices]
# top_counts = [top_counts[i] for i in top_indices]
#
# # 打印前10个词及其出现次数
# print(top_words)
# print(top_counts)
#
# # 绘制柱状图
# plt.figure(figsize=(10, 6))
# bars = plt.barh(top_words, top_counts, color='skyblue')
# for bar, count in zip(bars, top_counts):
#     plt.text(bar.get_width(), bar.get_y() + bar.get_height()/2, f'{int(count)}', va='center')
# plt.xlabel('出现次数')
# plt.title('出现次数最多的前10个词')
# plt.gca().invert_yaxis()
# plt.savefig('./static/top10_words.png')
# plt.show()