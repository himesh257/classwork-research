library(forecast)
Sales <-read.csv('monthly-car-sales-in-quebec-1960.csv')
Sales_ts <- ts(Sales$Monthly.car.sales.in.Quebec.1960.1968,frequency = 12, start = c(1960,01))
training <- window(Sales_ts, start=c(1960,01), end=c(1966, 12))
test <- window(Sales_ts, start=c(1967, 1), end=c(1968, 12))
model1 <-tslm(training ~ trend)
summary(model1)
model2 <- tslm(training ~ trend + season)
summary(model2)

res1 <- model1$residuals
res2 <- model2$residuals
ggtsdisplay(res1,lag.max=50)
ggtsdisplay(res2,lag.max=50)

fc1 <- forecast(model1, h=24)
plot(fc1)
lines(fc1$fitted, col="red")
legend(1959.75,28700, legend=c("Observed values of training sample", "Forecasted values of training sample", "Forecasted values for testing sample"),col=c("black", "red", "blue"),lty=1,lwd = 1 ,title="Line types",cex=0.7, text.font=3)
fc2 <- forecast(model2, h=24)
plot(fc2)
lines(fc2$fitted, col="red")
legend(1959.75,29000, legend=c("Observed values of training sample", "Forecasted values of training sample", "Forecasted values for testing sample"),col=c("black", "red", "blue"),lty=1,lwd=1 ,title="Line types",cex=0.7, text.font=4)

MeanSquaredError_f <- ts(0, frequency=12, start=c(1967, 1), end=c(1968, 12)) 
MeanAbsoluteError_f <- ts(0, frequency=12, start=c(1967, 1), end=c(1968, 12)) 
for ( h in 1:24){
  MeanSquaredError_f[h]=test[h]-fc1$mean[h]
  MeanAbsoluteError_f[h]=test[h]-fc1$mean[h] }
for(h in 1:24){ 
MeanSquaredError_f[h]=(MeanSquaredError_f[h])^2
MeanAbsoluteError_f[h]=abs(MeanAbsoluteError_f[h]) }
RMSE <- sqrt(mean(MeanSquaredError_f))
MAE <- mean(MeanAbsoluteError_f)

MeanSquaredError_f2 <- ts(0, frequency=12, start=c(1967, 1), end=c(1968, 12)) 
MeanAbsoluteError_f2 <- ts(0, frequency=12, start=c(1967, 1), end=c(1968, 12)) 
for ( h in 1:24){
  MeanSquaredError_f2[h]=test[h]-fc2$mean[h] 
  MeanAbsoluteError_f2[h]=test[h]-fc2$mean[h]
}
for(h in 1:24){
  MeanSquaredError_f2[h]=(MeanSquaredError_f2[h])^2
  MeanAbsoluteError_f2[h]=abs(MeanAbsoluteError_f2[h]) }
RMSE2 <- sqrt(mean(MeanSquaredError_f2))
MAE2 <- mean(MeanAbsoluteError_f2)