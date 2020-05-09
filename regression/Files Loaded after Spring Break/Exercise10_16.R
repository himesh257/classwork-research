#Exercise 10.8 in Text
if (FALSE)
{"
Data consist of annual average mortgage interest rates for conventional, 
 fixed-rate, 30-year loans for 1995-2007
"}

library(faraway)
#install.packages("forecast",dependencies=TRUE)
library(forecast)
library(ggplot2)
library(dplyr)

#read in the data which is in a csv file
IntRate <- read.csv("C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/TimeSeries/INTRATE30.csv",header = TRUE)
head(IntRate,10L)
plot.ts(IntRate[,2],type = "b",xlab="Year:1995 through 2017", ylab="Interest Rate")                         
IntRate_df <- data.frame(IntRate)
head(IntRate_df)
IntRate_df <- rename(IntRate_df,YEAR=ï..YEAR) # rename ï..YEAR to YEAR

lmod <- lm(RATE ~ YEAR,data=IntRate_df)
lmod$fitted[23] #Fit at 2017

#compute predictions at 2018 and 2019 using typical regression approach
forecast_y <- data.frame(YEAR=seq(2017,2019,1)) #forecasts for 2017, 2018, 2019.
predict(lmod,forecast_y, interval="prediction")

forecast_m <- data.frame(YEAR=seq(2018,2019,.25))  #Quarterly Forecasts
predict(lmod,forecast_m, interval="prediction")






