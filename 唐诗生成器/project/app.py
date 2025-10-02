import joblib
import pandas as pd
from flask import Flask, jsonify, request, render_template
from datetime import datetime

app = Flask(__name__)

# 加载模型和预处理工具
try:
    model = joblib.load('model/random_forest_model.pkl')
    scaler = joblib.load('model/scaler.pkl')
    imputer = joblib.load('model/imputer.pkl')
    evaluation_results = joblib.load('model/evaluation_results.pkl')
except Exception as e:
    print(f"模型或预处理工具加载错误: {e}")
    model = None
    scaler = None
    imputer = None
    evaluation_results = None

# 特征列表
FEATURES = [
    'RevolvingUtilizationOfUnsecuredLines',
    'age',
    'NumberOfTime30-59DaysPastDueNotWorse',
    'DebtRatio',
    'MonthlyIncome',
    'NumberOfOpenCreditLinesAndLoans',
    'NumberOfTimes90DaysLate',
    'NumberRealEstateLoansOrLines',
    'NumberOfTime60-89DaysPastDueNotWorse',
    'NumberOfDependents'
]

"""首页"""


@app.route('/')
def index():
    """首页"""
    return render_template('index.html', features=FEATURES, evaluation_results=evaluation_results)


"""预测API"""


@app.route('/predict', methods=['POST'])
def predict():
    """预测API"""
    if model is None or scaler is None or imputer is None:
        return jsonify({'error': '模型或预处理工具未加载'}), 500

    try:
        # 获取表单数据
        data = request.form.to_dict()

        # 转换为DataFrame
        input_data = pd.DataFrame([data])

        # 确保所有特征都存在
        for feature in FEATURES:
            if feature not in input_data.columns:
                input_data[feature] = 0

        # 选择需要的特征
        input_data = input_data[FEATURES]

        # 处理缺失值
        input_data = pd.DataFrame(imputer.transform(input_data), columns=FEATURES)

        # 标准化
        input_scaled = scaler.transform(input_data)

        # 预测
        prediction = model.predict(input_scaled)[0]
        probability = model.predict_proba(input_scaled)[0][1]  # 违约概率

        # 返回结果
        result = {
            'prediction': int(prediction),
            'probability': float(probability),
            'interpretation': '高风险' if prediction == 1 else '低风险',
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }

        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)}), 400


"""关于页面"""


@app.route('/about')
def about():
    """关于页面"""
    return render_template('about.html')


"""模型信息页面"""


@app.route('/model')
def model_page():
    """模型信息页面"""
    if evaluation_results:
        return render_template('model.html', results=evaluation_results)
    else:
        return render_template('model.html', error="模型评估结果不可用，请先训练模型")


"""可视化页面"""


@app.route('/visualizations')
def visualizations():
    from keshihua import create_visualizations, generate_income_overdue_scatter, generate_credit_loan_default
    chart_files = create_visualizations()
    income_overdue_scatter = generate_income_overdue_scatter()
    credit_loan_default = generate_credit_loan_default()
    return render_template('visualizations.html',
                         chart1=chart_files[0],
                         chart2=chart_files[1],
                         correlation_matrix=chart_files[2],
                         age_delinquency_boxplot=chart_files[3],
                         debt_ratio_violin=chart_files[4],
                         income_default_trend=chart_files[5],
                         income_overdue_scatter=income_overdue_scatter,
                         credit_loan_default=credit_loan_default)


if __name__ == '__main__':
    app.run(debug=True)