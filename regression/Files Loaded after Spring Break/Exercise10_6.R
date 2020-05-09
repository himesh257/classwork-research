#Exercise 10.6 in Text
if (FALSE)
{"
Standard & Poor’s 500 Composite 
Stock Index (S&P 500) is a stock market index.
Like the Dow Jones Industrial Average, it is an
indicator of stock market activity.
"}

library(faraway)
#install.packages("forecast",dependencies=TRUE)
library(forecast)
library(ggplot2)

#read in the data which is in a csv file
SP500 <- read.csv("C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/TimeSeries/SP500.csv",header = TRUE)
head(SP500,10L)
plot.ts(SP500[,4])


#####  Part a)
#moving average smooth				
moving_average <- ma(SP500[,4],order=4,centre=FALSE)
moving_average
moving_average_forecast <- forecast(moving_average,h=5)
moving_average_forecast
plot(moving_average_forecast,xlab="Quarter Number",ylab="moving average forecast")
#
#
#####  Part b)
#exponential smooth #alpha is the weight
exponential_smooth <- ses(SP500[,4],h=4,alpha=0.30,exponential=TRUE, initial="simple")
plot(exponential_smooth)
#
exponential_smooth$fitted
plot(exponential_smooth$fitted)
#
names(exponential_smooth)
#
match_answer <- exponential_smooth$fitted[-1]
match_answer[40] <- 2440.78
match_answer
plot(match_answer,xlab="Quarter Number",ylab="simple exponential smooth forecast")
#
#
##Optimizing the value of alpha and the initial starting point - see optimization.pdf in file in Lecture notes##
##from https://otexts.com/fpp2/ses.html   Forecasting: Principles and Practice
#
round(accuracy(exponential_smooth),2)
max_alpha <- ses(SP500[,4],h=4)
summary(max_alpha)
round(accuracy(max_alpha),2)

autoplot(ts(SP500[,4])) + autolayer(fitted(exponential_smooth),series="Fitted") +
	ylab("simple exponential smooth forecast") + xlab("Quarter Number")


#####  Part c)
H_W_smooth <- HoltWinters(ts(SP500[,4],frequency=4),seasonal="additive",alpha=0.30)
names(H_W_smooth) 
H_W_smooth
H_W_smooth$fitted

autoplot(ts(SP500[,4],frequency=4)) + autolayer(fitted(H_W_smooth),series="Fitted") +
	ylab("Holt-Winters additive forecasts") + xlab("Year")





