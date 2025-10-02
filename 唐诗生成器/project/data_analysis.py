import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
from sklearn.impute import SimpleImputer
import joblib
import time

# 设置中文字体
plt.rcParams["font.family"] = ["SimHei"]

class CreditRiskAnalyzer:
    def __init__(self):
        self.train_data = None
        self.test_data = None
        self.model = None
        self.scaler = StandardScaler()
        self.imputer = SimpleImputer(strategy='median')

    def load_data(self, train_path, test_path):
        """加载数据集"""
        try:
            self.train_data = pd.read_csv(train_path)
            self.test_data = pd.read_csv(test_path)
            print(f"训练集: {self.train_data.shape}")
            print(f"测试集: {self.test_data.shape}")
        except Exception as e:
            print(f"数据加载错误: {e}")

    def data_summary(self):
        """数据集概述"""
        if self.train_data is None:
            print("请先加载数据")
            return

        print("\n数据集概述:")
        print(f"训练集样本数: {self.train_data.shape[0]}, 属性数: {self.train_data.shape[1]}")
        print(f"测试集样本数: {self.test_data.shape[0]}, 属性数: {self.test_data.shape[1]}")

        print("\n属性含义:")
        print("SeriousDlqin2yrs: 两年内发生90天以上逾期的情况(标签)")
        print("RevolvingUtilizationOfUnsecuredLines: 无担保信用额度使用率")
        print("age: 年龄")
        print("NumberOfTime30-59DaysPastDueNotWorse: 30-59天逾期次数")
        print("DebtRatio: 负债比率")
        print("MonthlyIncome: 月收入")
        print("NumberOfOpenCreditLinesAndLoans: 开放式信贷和贷款数量")
        print("NumberOfTimes90DaysLate: 90天逾期次数")
        print("NumberRealEstateLoansOrLines: 房地产贷款或额度数量")
        print("NumberOfTime60-89DaysPastDueNotWorse: 60-89天逾期次数")
        print("NumberOfDependents: 家属数量")

        # 检查标签分布
        if 'SeriousDlqin2yrs' in self.train_data.columns:
            label_dist = self.train_data['SeriousDlqin2yrs'].value_counts()
            print(f"\n标签分布(训练集):\n{label_dist}")

    def preprocess_data(self):
        """数据预处理"""
        if self.train_data is None:
            print("请先加载数据")
            return

        print("\n数据预处理...")

        # 定义特征列（排除标签列和可能的索引列）
        feature_columns = [col for col in self.train_data.columns
                           if col not in ['SeriousDlqin2yrs', 'Unnamed: 0']]

        # 1. 检查缺失值
        missing_train = self.train_data[feature_columns].isnull().sum()
        missing_test = self.test_data[feature_columns].isnull().sum()

        print("\n训练集缺失值:")
        print(missing_train[missing_train > 0])

        print("\n测试集缺失值:")
        print(missing_test[missing_test > 0])

        # 2. 处理缺失值
        # 一次性拟合所有特征列
        self.imputer.fit(self.train_data[feature_columns])

        # 转换训练数据
        train_imputed = self.imputer.transform(self.train_data[feature_columns])
        self.train_data[feature_columns] = train_imputed

        # 转换测试数据
        test_imputed = self.imputer.transform(self.test_data[feature_columns])
        self.test_data[feature_columns] = test_imputed

        # 3. 检查重复记录
        train_duplicates = self.train_data[feature_columns].duplicated().sum()
        test_duplicates = self.test_data[feature_columns].duplicated().sum()

        print(f"\n训练集重复记录: {train_duplicates}")
        print(f"测试集重复记录: {test_duplicates}")

        # 4. 删除重复记录
        if train_duplicates > 0:
            self.train_data = self.train_data.drop_duplicates()
            print(f"已删除训练集重复记录，剩余样本: {self.train_data.shape[0]}")

        if test_duplicates > 0:
            self.test_data = self.test_data.drop_duplicates()
            print(f"已删除测试集重复记录，剩余样本: {self.test_data.shape[0]}")

        # 5. 数据标准化
        # 分离特征和标签
        X_train = self.train_data[feature_columns]
        y_train = self.train_data['SeriousDlqin2yrs'] if 'SeriousDlqin2yrs' in self.train_data.columns else None

        X_test = self.test_data[feature_columns]

        # 保存列名
        columns = X_train.columns

        # 标准化
        self.scaler.fit(X_train)
        X_train = self.scaler.transform(X_train)
        X_test = self.scaler.transform(X_test)

        # 转回DataFrame
        self.train_data_processed = pd.DataFrame(X_train, columns=columns)
        if y_train is not None:
            self.train_data_processed['SeriousDlqin2yrs'] = y_train

        self.test_data_processed = pd.DataFrame(X_test, columns=columns)

        print("\n数据预处理完成")

    # def exploratory_analysis(self):
    #     """探索性数据分析与可视化"""
    #     if self.train_data is None:
    #         print("请先加载数据")
    #         return
    #
    #     print("\n探索性数据分析...")
    #
    #     # 1. 年龄分布
    #     plt.figure(figsize=(10, 6))
    #     sns.histplot(self.train_data['age'], bins=30, kde=True)
    #     plt.title('年龄分布')
    #     plt.xlabel('年龄')
    #     plt.ylabel('频数')
    #     plt.savefig('static/age_distribution.png')
    #
    #     # 2. 逾期情况与年龄关系
    #     plt.figure(figsize=(10, 6))
    #     sns.boxplot(x='SeriousDlqin2yrs', y='age', data=self.train_data)
    #     plt.title('逾期情况与年龄关系')
    #     plt.xlabel('是否逾期(1=是, 0=否)')
    #     plt.ylabel('年龄')
    #     plt.savefig('static/age_vs_delinquency.png')
    #
    #     # 3. 相关性分析
    #     plt.figure(figsize=(12, 10))
    #     corr = self.train_data.corr()
    #     sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm')
    #     plt.title('特征相关性热图')
    #     plt.savefig('static/correlation_heatmap.png')
    #
    #     # 4. 月收入分布(取对数以更好展示)
    #     plt.figure(figsize=(10, 6))
    #     income_data = self.train_data['MonthlyIncome'].dropna()
    #     income_data = income_data[income_data > 0]  # 排除零和缺失值
    #     sns.histplot(np.log(income_data), bins=30, kde=True)
    #     plt.title('月收入分布(对数变换)')
    #     plt.xlabel('月收入(对数)')
    #     plt.ylabel('频数')
    #     plt.savefig('static/income_distribution.png')
    #
    #     print("可视化图表已保存至static目录")

    def build_model(self):
        """构建并训练模型"""
        if not hasattr(self, 'train_data_processed'):
            print("请先进行数据预处理")
            return

        print("\n构建模型...")


        # 分离特征和标签
        X = self.train_data_processed.drop('SeriousDlqin2yrs', axis=1)
        y = self.train_data_processed['SeriousDlqin2yrs']

        # 划分训练集和验证集
        X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, random_state=42)

        # 使用随机森林分类器
        start_time = time.time()
        self.model = RandomForestClassifier(n_estimators=100, random_state=42, n_jobs=-1)
        self.model.fit(X_train, y_train)
        training_time = time.time() - start_time

        # 在验证集上评估
        y_pred = self.model.predict(X_val)

        print(f"\n模型训练时间: {training_time:.2f}秒")
        print(f"验证集准确率: {accuracy_score(y_val, y_pred):.4f}")
        print("\n分类报告:")
        print(classification_report(y_val, y_pred))

        # 特征重要性
        feature_importance = pd.DataFrame({
            'Feature': X.columns,
            'Importance': self.model.feature_importances_
        }).sort_values('Importance', ascending=False)

        print("\n特征重要性:")
        print(feature_importance)

        # 保存模型和评估结果
        joblib.dump(self.model, 'model/random_forest_model.pkl')
        joblib.dump(self.scaler, 'model/scaler.pkl')
        joblib.dump(self.imputer, 'model/imputer.pkl')
        # joblib.dump(self.evaluation_results, 'model/evaluation_results.pkl')

        # 保存评估结果用于Flask应用
        self.evaluation_results = {
            'accuracy': accuracy_score(y_val, y_pred),
            'report': classification_report(y_val, y_pred),
            'confusion_matrix': confusion_matrix(y_val, y_pred).tolist(),
            'feature_importance': feature_importance.to_dict('records'),
            'training_time': training_time
        }

        print("模型已保存至model目录")

    def predict(self, data):
        """使用模型进行预测"""
        if self.model is None:
            print("请先训练模型")
            return None

        # 预处理输入数据
        if isinstance(data, pd.DataFrame):
            # 确保输入数据包含所有需要的列
            missing_cols = set(self.train_data_processed.columns) - set(data.columns) - {'SeriousDlqin2yrs'}
            for col in missing_cols:
                data[col] = 0

            # 按训练数据的列顺序排列
            data = data[self.train_data_processed.columns.drop('SeriousDlqin2yrs')]

            # 标准化
            data_scaled = self.scaler.transform(data)

            # 预测
            predictions = self.model.predict(data_scaled)
            probabilities = self.model.predict_proba(data_scaled)

            return {
                'predictions': predictions.tolist(),
                'probabilities': probabilities.tolist()
            }
        else:
            print("输入数据格式不正确，需要DataFrame")
            return None

    def evaluate_test_data(self):
        """在测试数据上评估模型"""
        if not hasattr(self, 'test_data_processed') or self.model is None:
            print("请先进行数据预处理并训练模型")
            return

        print("\n在测试数据上评估模型...")

        # 如果测试数据有标签
        if 'SeriousDlqin2yrs' in self.test_data.columns:
            X_test = self.test_data_processed
            y_test = self.test_data['SeriousDlqin2yrs']

            # 检查标签列是否有缺失值
            if y_test.isnull().any():
                print(f"警告: 测试数据的标签列包含 {y_test.isnull().sum()} 个缺失值")
                print("无法计算准确率，因为标签列包含缺失值")

                # 进行预测但不评估
                predictions = self.predict(X_test)
                return predictions
            else:
                # 没有缺失值，正常评估
                y_pred = self.model.predict(X_test)

                print(f"测试集准确率: {accuracy_score(y_test, y_pred):.4f}")
                print("\n分类报告:")
                print(classification_report(y_test, y_pred))

                self.test_evaluation = {
                    'accuracy': accuracy_score(y_test, y_pred),
                    'report': classification_report(y_test, y_pred),
                    'confusion_matrix': confusion_matrix(y_test, y_pred).tolist()
                }

                return self.test_evaluation
        else:
            print("测试数据中没有标签列，无法进行完整评估")
            # 进行预测
            predictions = self.predict(self.test_data_processed)
            return predictions

if __name__ == "__main__":
    analyzer = CreditRiskAnalyzer()
    analyzer.load_data('./data/cs-training.csv', './data/cs-test.csv')
    analyzer.data_summary()
    analyzer.preprocess_data()
    # analyzer.exploratory_analysis()
    # analyzer.build_model()

    # 在测试数据上评估
    test_results = analyzer.evaluate_test_data()
    if test_results and 'accuracy' in test_results:
        print(f"最终测试集准确率: {test_results['accuracy']:.4f}")