import os
import pickle
import jieba
import pandas as pd
import nltk.classify as cf
import nltk.classify.util as cu
from gensim.models import Word2Vec
from data_processing import preprocess_text
from feature_extraction import get_average_word2vec
from model_training import train_and_save_model,train_word2vec

def load_model(filename):
    if not os.path.exists(filename):
        print(f"模型文件不存在: {filename}")
        return "None1"
    try:
        with open(filename, 'rb') as f:
            return pickle.load(f)
    except EOFError:
        print(f"模型文件读取失败，可能是文件损坏或为空: {filename}")
        return "Yes1"

def sentiment(sentences, model):

    features = {}
    words = preprocess_text(sentences)  # 对整个句子进行分词
    for word in words:
        features[word] = True
    pcls = model.classify(features)
    if pcls=='POSITIVE':
        pcls='积极'
    else:
        pcls='消极'
    return pcls  # 返回整个句子的情感类别


if __name__ == "__main__":
    model_filename = 'sentiment_model.pkl'  # 定义模型文件名
    word2vec_model = Word2Vec.load("word2vec_model.model")
    print("请输入要预测的句子，输入'exit'结束程序。")

    # 首先检查模型文件是否存在，如果不存在则训练并保存模型
    if not os.path.exists(model_filename):
        print("模型文件不存在，正在训练模型...")
        train_and_save_model(model_filename)  # 调用函数并传入文件名参数
    model = load_model(model_filename)
    if model is None:
        print("模型加载失败，正在重新训练模型...")
        train_and_save_model(model_filename)  # 重新训练并保存模型
        model = load_model(model_filename)  # 再次加载模型

    while True:
        sentence = input("预测语句：")
        if sentence == 'exit':
            break
        result = sentiment(sentence, model)
        print(f"预测的情感类别是: {result}")# import os
