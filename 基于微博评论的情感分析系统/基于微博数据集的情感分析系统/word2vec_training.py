from gensim.models import Word2Vec

def train_word2vec_model(text_data):
    """训练 Word2Vec 模型"""
    # 确保传入的数据不是空的
    if not text_data:
        raise ValueError("Text data is empty. Cannot train Word2Vec model.")

    # 创建并训练 Word2Vec 模型
    model = Word2Vec(sentences=text_data, vector_size=300, window=5, min_count=1, workers=4)
    model.save("word2vec_model.model")  # 保存模型
    return model
