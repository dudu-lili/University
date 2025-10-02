import pandas as pd

import jieba
import string

def preprocess_text(text):
    """对输入文本进行预处理"""
    # 检查text是否为字符串，如果不是则返回一个默认值或空字符串
    if pd.isnull(text) or not isinstance(text, str):
        return ""
    # 去除标点符号
    text = ''.join([char for char in text if char not in string.punctuation])

    # 使用 jieba 进行分词
    tokens = jieba.cut(text)

    return list(tokens)


def read_data(dataset_path):
    """读取CSV文件并返回包含文本和标签的DataFrame"""
    # 读取CSV文件
    df = pd.read_csv(dataset_path, encoding='utf-8')
    print(df)
    # 返回标签和文本列
    return df
