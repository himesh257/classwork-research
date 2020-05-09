# simple smoothing average
stock <- read.csv("acwi.us.txt",header = TRUE)
stock
library(smooth)
MovingAverage <- sma(stock$Volume,order=5,silent=FALSE)
# visualize the forecast plot with order 5
# suppose we want to forecast value at quarter 10 using 5 data points
M10 = (stock[8,6]+stock[9,6]+stock[10,6]+stock[11,6]+stock[12,6])/5
M10  # then we can get predicted value using simple smoothing average

### exponential smooothing
library(tidyverse)
library(fpp2)
goog.train <- window(goog, end = 900)  #traning the dataset of stock data
goog.test <- window(goog, start = 901)
goog.dif <- diff(goog.train)
autoplot(goog.dif)

ses.goog.dif <- ses(goog.dif, alpha = .2, h = 100)  #using parameter 0.2 to forecast
autoplot(ses.goog.dif)  # visualize the fexponential forecast

# to view the accuracy of forecast
goog.dif.test <- diff(goog.test)
accuracy(ses.goog.dif, goog.dif.test)


##ARIMA model
library(quantmod)
library(forecast)
library(xlsx)
library(tseries)
library(timeSeries)
library(dplyr)
library(prophet)
library(fGarch)
getSymbols("GOOG", src = "yahoo", from = "2019-04-20",to = "2020-4-19")
plot(Cl(GOOG))
close_price<-c(Cl(GOOG))
#conduct adf test for the dataset
print(adf.test(close_price))
#apply auto arima to the dataset
modelfit <- auto.arima(close_price, lambda = "auto")
#we can check the residuals of the model with ARIMA parameters selected.
summary(modelfit)
#Box test for lag=2
Box.test(modelfit$residuals, lag= 2, type="Ljung-Box")
#not reject null hypothesis
Box.test(modelfit$residuals, type="Ljung-Box")
#not reject our null hypothesis, we can keep moving on our study.
price_forecast <- forecast(modelfit, h=30)
#forecast the next 30 days stock prices
plot(price_forecast)
#plot for the forecasting data with 80% and 95% confidence intervals for lower and upper price scenarios.
head(price_forecast$mean)
head(price_forecast$lower)
head(price_forecast$upper)
#we can train the 70% of our dataset and set the test set as the rest(30%).
N = length(close_price)
n = 0.7*N
train = close_price[1:n, ]
test  = close_price[(n+1):N,  ]
trainarimafit <- auto.arima(train, lambda = "auto")
predlen=length(test)
trainarimafit <- forecast(trainarimafit, h=predlen)
meanvalues <- as.vector(trainarimafit$mean)
precios <- as.vector(test$GOOG.Close)
plot(meanvalues, type= "l", col= "red")
lines(precios, type = "l")
#Finally, we have the plot for trained dataset of mean tendency.