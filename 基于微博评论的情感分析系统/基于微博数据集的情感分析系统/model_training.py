import nltk.classify as cf
import nltk.classify.util as cu
import jieba
import numpy as np
import pandas as pd
import pickle

from gensim.models import Word2Vec
from matplotlib import pyplot as plt
from sklearn.feature_extraction.text import TfidfVectorizer

from feature_extraction import get_average_word2vec
from data_processing import preprocess_text
from sklearn.metrics import confusion_matrix, precision_recall_curve, auc, PrecisionRecallDisplay, precision_score, \
    recall_score, f1_score
# def train_naive_bayes_model(X_train, y_train):
#     """训练朴素贝叶斯分类器"""
#     gnb = GaussianNB()
#     gnb.fit(X_train, y_train)
#     joblib.dump(gnb, 'naive_bayes_word2vec_model.pkl')  # 保存训练好的模型
#     return gnb

import seaborn as sns
from nltk.classify import NaiveBayesClassifier
from nltk.classify.util import accuracy as nltk_accuracy

def train_and_save_model(filename):
    # 读取积极和消极评论数据
    pos_df = pd.read_csv("./datas/simplifyweibo_4_moods.csv")
    pos_data = [({word: True for word in jieba.cut(row['review'])}, "POSITIVE") for index, row in pos_df.iterrows() if row['label'] == 0]

    neg_df = pd.read_csv("./datas/simplifyweibo_4_moods.csv")
    neg_data = [({word: True for word in jieba.cut(row['review'])}, "NEGATIVE") for index, row in neg_df.iterrows() if row['label'] in [1, 2, 3]]

    # 划分训练集和测试集
    train_data = pos_data[:int(0.8*len(pos_data))] + neg_data[:int(0.8*len(neg_data))]
    test_data = pos_data[int(0.8*len(pos_data)):] + neg_data[int(0.8*len(neg_data)):]

    # 构建分类器
    model = NaiveBayesClassifier.train(train_data)
    ac = nltk_accuracy(model, test_data)  # 使用 NLTK 的 accuracy 函数计算准确率
    print("准确率为：", ac)

    # 获取预测概率
    y_true = [label for _, label in test_data]
    y_scores = [model.prob_classify(features).prob("POSITIVE") for features, _ in test_data]
    y_pred = [model.classify(features) for features, _ in test_data]

    # 设置中文字体
    plt.rcParams['font.sans-serif'] = ['SimHei']  # 'SimHei' 是一种常见的中文字体
    plt.rcParams['axes.unicode_minus'] = False  # 正确显示负号
    # 计算精确率、召回率和F1分数
    precision = precision_score(y_true, y_pred, pos_label="POSITIVE")
    recall = recall_score(y_true, y_pred, pos_label="POSITIVE")
    f1 = f1_score(y_true, y_pred, pos_label="POSITIVE")

    # 绘制精确率、召回率和F1分数的条形图
    metrics = ['Precision', 'Recall', 'F1 Score']
    scores = [precision, recall, f1]

    plt.figure(figsize=(8, 4))
    bars = plt.bar(metrics, scores, color=['blue', 'green', 'red'])
    plt.xlabel('Metrics')
    plt.ylabel('Scores')
    plt.title('精确率、召回率和F1分数条形图')
    plt.ylim(0, 1)  # 因为这些分数都在0到1之间
    # 在每个条形上方添加数值标签
    for bar in bars:
        yval = bar.get_height()
        plt.text(bar.get_x() + bar.get_width() / 2, yval, round(yval, 3), ha='center', va='bottom')
    plt.savefig('./static/model_performance_metrics.png')
    plt.show()
    # 计算混淆矩阵
    conf_matrix = confusion_matrix(y_true, y_pred)
    # 使用seaborn绘制混淆矩阵的热力图
    sns.heatmap(conf_matrix, annot=True, fmt='d', cmap='Blues')
    plt.title('混淆矩阵')
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.savefig('./static/confusion_matrix.png')
    plt.show()

    # 保存模型
    with open(filename, 'wb') as f:
        pickle.dump(model, f)
    return model

def train_word2vec(texts, vector_size=100, window=5, min_count=1, workers=4):
    model = Word2Vec(sentences=texts, vector_size=vector_size, window=window, min_count=min_count, workers=workers)
    model.save("word2vec_model.model")
    return model


def tf_idf(text):
    # 使用jieba进行分词
    words = jieba.cut(text)
    # 将分词结果转换为列表
    texts = [' '.join(words)]

    # 创建TF-IDF向量化器实例
    vectorizer = TfidfVectorizer()

    # 使用文本数据拟合向量化器并转换数据
    tfidf_matrix = vectorizer.fit_transform(texts)

    # 获取特征名称（词汇）
    feature_names = vectorizer.get_feature_names_out()

    # 将稀疏矩阵转换为DataFrame
    tfidf_df = pd.DataFrame(tfidf_matrix.toarray(), columns=feature_names)

    # 将词汇和对应的TF-IDF分数作为Series返回
    return pd.Series(tfidf_df.iloc[0], index=feature_names)
