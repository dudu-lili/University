import pandas as pd
import re
import jieba
import jieba.posseg as pseg

# 1. 读取原始微博数据文件和停用词表
raw_file_path = 'datas/simplifyweibo_4_moods.csv'  # 输入的原始数据文件路径
stopwords_files = ['中文停用词库.txt', '哈工大停用词表.txt', '四川大学机器智能实验室停用词库.txt']  # 停用词文件路径列表

# 2. 加载原始数据
raw_data = pd.read_csv(raw_file_path)

# 3. 合并停用词表
stopwords = set()
for stopwords_file in stopwords_files:
    try:
        with open(stopwords_file, 'r', encoding='utf-8') as f:
            stopwords.update([line.strip() for line in f if line.strip()])
    except FileNotFoundError:
        print(f"Warning: 停用词文件 {stopwords_file} 未找到，已跳过。")

# 4. 定义清洗函数
def clean_text(text):
    """
    对文本进行清洗，包括去除HTML标签、特殊符号和多余的空白。
    """
    text = re.sub(r'<.*?>', '', text)  # 去除HTML标签
    text = re.sub(r'[^一-龥a-zA-Z0-9]', ' ', text)  # 保留中文、英文和数字，去除特殊符号
    text = re.sub(r'\s+', ' ', text)  # 合并多个空白为一个
    return text.strip()

# 5. 定义分词函数
def tokenize(text):
    """
    对文本进行分词，去除停用词。
    """
    words = jieba.cut(text)
    filtered_words = [word for word in words if word not in stopwords and len(word) > 1]
    return ' '.join(filtered_words)

# 6. 数据清洗与分词
if 'review' not in raw_data.columns:  # 将'text'替换为实际的列名'review'
    raise ValueError("输入文件中未找到 'review' 列，请确认数据格式。")

raw_data['cleaned_text'] = raw_data['review'].astype(str).apply(clean_text)  # 清洗文本
raw_data['tokenized_text'] = raw_data['cleaned_text'].apply(tokenize)  # 分词

# 7. 保存分词后的数据
tokenized_file_path = 'datas/tokenized_weibo.csv'  # 分词后的数据文件路径
# 只保留label和tokenized_text列
tokenized_data = raw_data[['label', 'tokenized_text']]
# tokenized_data.to_csv(tokenized_file_path, index=False, encoding='utf-8-sig')

print(f"分词已完成，结果已保存到 {tokenized_file_path}")
将label中的2和3修改为1
tokenized_data.loc[tokenized_data['label'].isin([2, 3]), 'label'] = 1
# 保存修改后的数据到新的CSV文件
tokenized_data.to_csv('datas/clan_weibo_text_modifie.csv', index=False)
def segment_and_tag(text):
    # 使用jieba进行分词和词性标注
    words = pseg.cut(text)
    # 将分词和词性标注的结果转换为列表
    result = [(word.word, word.flag) for word in words]
    return result
# 8. 定义分词并标注词性函数
def tokenize_and_tag(text):
    """
    对文本进行分词，并标注词性，去除停用词。
    """
    words = pseg.cut(text)
    filtered_words = [(word, flag) for word, flag in words if word not in stopwords and len(word) > 1]
    return ' '.join([f"{word}/{flag}" for word, flag in filtered_words])

# 9. 分词并标注词性
raw_data['tagged_text'] = raw_data['cleaned_text'].apply(tokenize_and_tag)  # 分词并标注词性

# 10. 保存标注词性后的数据
tagged_file_path = 'datas/tagged_weibo.csv'  # 标注词性后的数据文件路径
# 只保留label和tagged_text列
tagged_data = raw_data[['label', 'tagged_text']]
tagged_data.to_csv(tagged_file_path, index=False, encoding='utf-8-sig')

print(f"标注词性已完成，结果已保存到 {tagged_file_path}")