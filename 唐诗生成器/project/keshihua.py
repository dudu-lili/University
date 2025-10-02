import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import os

# 全局变量存储已生成的图表路径
GENERATED_CHARTS = {}

def generate_default_distribution(df):
    path = 'static/chart1.html'
    if os.path.exists(path):  # 检查文件是否存在
        return path
    
    counts = df['未来两年可能违约'].value_counts()
    labels = ['未来两年可能不违约', '未来两年可能会违约']
    fig = px.pie(
        names=labels,
        values=counts.values,
        title='未来两年可能违约情况的分布'
    )
    fig.write_html(path)
    return path

def generate_age_overdue_relation(df):
    if 'chart2' in GENERATED_CHARTS:
        return GENERATED_CHARTS['chart2']
    
    grouped_data_sum = df.groupby('年龄')[['逾期30-59天的笔数', '逾期60-89天的笔数', '逾期90天+的笔数']].sum().reset_index()
    fig = make_subplots(specs=[[{"secondary_y": True}]])
    
    fig.add_trace(
        go.Histogram(x=df['年龄'], nbinsx=30, name='年龄分布'),
        secondary_y=False
    )
    
    colors = ['red', 'green', 'blue']
    overdue_columns = ['逾期30-59天的笔数', '逾期60-89天的笔数', '逾期90天+的笔数']
    for col, color in zip(overdue_columns, colors):
        fig.add_trace(
            go.Scatter(
                x=grouped_data_sum['年龄'],
                y=grouped_data_sum[col],
                mode='lines',
                name=col,
                line=dict(color=color),
                hovertemplate='年龄: %{x}<br>逾期笔数: %{y}'
            ),
            secondary_y=True
        )
    
    fig.update_layout(
        title='年龄分布与不同逾期天数区间逾期笔数的关系',
        xaxis_title='年龄',
        yaxis_title='频率',
        yaxis2_title='逾期笔数总和'
    )
    
    path = 'static/chart2.html'
    fig.write_html(path)
    GENERATED_CHARTS['chart2'] = path
    return path

def generate_correlation_matrix(df):
    if 'correlation_matrix' in GENERATED_CHARTS:
        return GENERATED_CHARTS['correlation_matrix']
    
    numeric_cols = df.select_dtypes(include=['float64', 'int64']).columns.drop('未来两年可能违约')
    if 'Unnamed: 0' in numeric_cols:
        numeric_cols = numeric_cols.drop('Unnamed: 0')
    corr_matrix = df[numeric_cols].corr()

    fig = go.Figure(data=go.Heatmap(
        z=corr_matrix.values,
        x=corr_matrix.columns,
        y=corr_matrix.columns,
        colorscale='Viridis',
        hoverongaps=False,
        text=corr_matrix.round(2).values
    ))
    fig.update_layout(title='数值特征相关性矩阵', xaxis_title='特征', yaxis_title='特征')
    
    path = 'static/correlation_matrix.html'
    fig.write_html(path)
    GENERATED_CHARTS['correlation_matrix'] = path
    return path

def generate_age_delinquency_boxplot(df):
    if 'age_delinquency_boxplot' in GENERATED_CHARTS:
        return GENERATED_CHARTS['age_delinquency_boxplot']
    
    fig = px.box(df,
                x='未来两年可能违约',
                y='年龄',
                title='逾期情况与年龄关系',
                color='未来两年可能违约',
                color_discrete_sequence=['#10b981', '#ef4444'],
                labels={'未来两年可能违约': '是否逾期(1=是, 0=否)', '年龄': '年龄'})
    
    fig.update_layout(
        xaxis_title='是否逾期(1=是, 0=否)',
        yaxis_title='年龄',
        showlegend=False
    )
    
    path = 'static/age_delinquency_boxplot.html'
    fig.write_html(path)
    GENERATED_CHARTS['age_delinquency_boxplot'] = path
    return path

def generate_debt_ratio_violin(df):
    if 'debt_ratio_violin' in GENERATED_CHARTS:
        return GENERATED_CHARTS['debt_ratio_violin']
    
    fig = go.Figure()
    for label in [0, 1]:
        filtered_data = df[df['未来两年可能违约'] == label]
        fig.add_trace(
            go.Violin(
                x=filtered_data['未来两年可能违约'],
                y=filtered_data['负债率'],
                name='违约' if label == 1 else '不违约',
                box_visible=True,
                meanline_visible=True
            )
        )
    fig.update_layout(title='负债率与违约状态分布对比', 
                     xaxis_title='违约状态（0=不违约，1=违约）',
                     yaxis_title='负债率')
    
    path = 'static/debt_ratio_violin.html'
    fig.write_html(path)
    GENERATED_CHARTS['debt_ratio_violin'] = path
    return path

def generate_income_default_trend(df):
    if 'income_default_trend' in GENERATED_CHARTS:
        return GENERATED_CHARTS['income_default_trend']
    
    df['月收入区间'] = pd.cut(
        df['月收入'],
        bins=[0, 3000, 6000, 10000, df['月收入'].max()],
        labels=['<3000', '3000-6000', '6000-10000', '>10000']
    )
    trend_data = df.groupby('月收入区间')['未来两年可能违约'].mean().reset_index()

    fig = px.line(
        trend_data,
        x='月收入区间',
        y='未来两年可能违约',
        markers=True,
        color_discrete_sequence=['#2196F3'],
        title='月收入区间与平均违约率的趋势',
        labels={'未来两年可能违约': '平均违约率'}
    )
    fig.update_layout(
        xaxis_title='月收入区间',
        yaxis_title='平均违约率',
        yaxis=dict(tickformat='.0%')
    )
    
    path = 'static/income_default_trend.html'
    fig.write_html(path)
    GENERATED_CHARTS['income_default_trend'] = path
    return path

def create_visualizations():
    if not os.path.exists('static'):
        os.makedirs('static')
    
    # 加载数据集
    df = pd.read_csv('./data/cs-training_processed.csv')
    
    # 生成所有图表（会自动检查文件是否存在）
    chart1 = generate_default_distribution(df)
    chart2 = generate_age_overdue_relation(df)
    correlation_matrix = generate_correlation_matrix(df)
    age_delinquency_boxplot = generate_age_delinquency_boxplot(df)
    debt_ratio_violin = generate_debt_ratio_violin(df)
    income_default_trend = generate_income_default_trend(df)
    
    return (
        chart1, 
        chart2, 
        correlation_matrix,
        age_delinquency_boxplot,
        debt_ratio_violin,
        income_default_trend
    )

def generate_income_overdue_scatter():
    if 'income_overdue_scatter' in GENERATED_CHARTS:
        return GENERATED_CHARTS['income_overdue_scatter']

    df = pd.read_csv('./data/cs-training_processed.csv')
    # 筛选月收入在合理范围的数据
    df = df[(df['月收入'] >= 0) & (df['月收入'] <= 100000)]
    fig = px.scatter(df, x='月收入', y='逾期90天+的笔数', title='月收入与逾期次数关系')
    path = 'static/income_overdue_scatter.html'
    fig.write_html(path)
    GENERATED_CHARTS['income_overdue_scatter'] = path
    return path


def generate_credit_loan_default():
    if 'credit_loan_default' in GENERATED_CHARTS:
        return GENERATED_CHARTS['credit_loan_default']

    df = pd.read_csv('./data/cs-training_processed.csv')
    # 修改列名
    grouped = df.groupby('信贷数量')['未来两年可能违约'].mean().reset_index()
    fig = px.bar(
        grouped,
        x='信贷数量',
        y='未来两年可能违约',
        title='信贷数量与违约概率的关系'
    )
    path = 'static/credit_loan_default.html'
    fig.write_html(path)
    GENERATED_CHARTS['credit_loan_default'] = path
    return path