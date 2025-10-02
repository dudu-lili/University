import jieba
import numpy as np


def get_average_word2vec(text, model):
    """将文本转换为 Word2Vec 的特征向量（取词向量的均值）"""
    words=jieba.cut(text)

    vector= []
    for word in words:
        try:
            vector.append(model.wv[word])
        except KeyError:
            continue
        if not vector:
            return None
        return np.mean(vector, axis=0)

# def get_text_vectors(texts, model):
#     """将文本列表转换为向量表示"""
#     return np.array([get_average_word2vec(tokens, model) for tokens in texts])