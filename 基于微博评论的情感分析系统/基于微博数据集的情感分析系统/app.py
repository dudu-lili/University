import pandas as pd
from flask import Flask, render_template, request, redirect, url_for
from main import load_model, sentiment
from data_processing import preprocess_text
from  model_training import tf_idf
from datachuli import segment_and_tag
app = Flask(__name__)


# 路由：展示图表
@app.route('/charts',methods=['GET'])
def charts():
    # generate_plots()  # 生成图表
    return render_template('charts.html')  # 渲染图表页面
@app.route('/charts2',methods=['GET'])
def charts2():
    return render_template('charts2.html')  # 渲染图表页面

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        user_input = request.form['text']
        model = load_model('sentiment_model.pkl')
        result = sentiment(user_input, model)
        print(result)
        return render_template('result.html', result=result)
@app.route('/datas', methods=['GET'])
def datas():
    # 设置显示选项
    pd.set_option('display.max_rows', None)  # 显示所有行
    pd.set_option('display.max_columns', None)  # 显示所有列
    pd.set_option('display.width', None)  # 自动调整宽度
    result =pd.read_csv("./datas/simplifyweibo_4_moods.csv")
    return render_template('charts3.html', result=result)
@app.route('/index1')
def index1():
    return render_template('index1.html')
@app.route('/index2')
def index2():
    return render_template('index2.html')
@app.route('/cixi', methods=['POST'])
def cixi():
    if request.method == 'POST':
        user_input = request.form['text']
        result1=segment_and_tag(user_input)
        result2=pd.read_csv("./datas/tagged_weibo.csv")
        return render_template('result2.html', result1=result1,result2=result2)
@app.route('/tiqu', methods=['POST'])
def tiqu():
    if request.method == 'POST':
        user_input = request.form['text']
        result3=tf_idf(user_input)
        return render_template('result1.html', result3=result3)
if __name__ == '__main__':
    app.run(debug=True)