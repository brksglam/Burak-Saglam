pip install pandas
pip install yfinance
pip install scikit-learn

-------------------------------------------------

import yfinance as yf
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split

# Hisse verilerini çeken fonksiyon
def get_stock_data(ticker, start_date, end_date):
    stock_data = yf.download(ticker, start=start_date, end=end_date)
    return stock_data

# Tahminler yapmak için eğitilmiş modeli döndüren fonksiyon
def train_prediction_model(stock_data):
    stock_data['Prediction'] = stock_data['Close'].shift(-1)
    stock_data.dropna(inplace=True)

    X = stock_data.drop('Prediction', axis=1).values
    y = stock_data['Prediction'].values

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = LinearRegression()
    model.fit(X_train, y_train)

    return model

# Alım satım stratejisi
def trading_strategy(stock_data, model):
    budget = 10000  # Başlangıç bütçesi
    stocks_owned = 0
    stock_data['Predicted_Close'] = model.predict(stock_data.drop('Prediction', axis=1))

    for index, row in stock_data.iterrows():
        predicted_close = row['Predicted_Close']
        actual_close = row['Close']

        # Hisse düşerken alım yapma
        if actual_close > predicted_close and budget >= actual_close:
            stocks_owned += 1
            budget -= actual_close

        # Hisse çıkarken satış yapma
        elif actual_close < predicted_close and stocks_owned > 0:
            stocks_owned -= 1
            budget += actual_close

    return budget, stocks_owned

# Ana fonksiyon
def main():
    ticker = "GARAN.IS"  # Garanti Bankası hisse senedi
    start_date = "2020-01-01"
    end_date = "2021-01-01"

    stock_data = get_stock_data(ticker, start_date, end_date)
    model = train_prediction_model(stock_data)
    budget, stocks_owned = trading_strategy(stock_data, model)

    print(f"Net Budget: {budget}")
    print(f"Stocks Owned: {stocks_owned}")

if __name__ == "__main__":
    main()
