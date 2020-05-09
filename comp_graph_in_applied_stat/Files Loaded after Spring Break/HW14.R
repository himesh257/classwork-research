#HW14
if (FALSE)
{"
Use the presidents data set from HW13 and the R code below to plot the data and the smoothed simple moving average:
a) using 5 data points
b) using 10 data points
"}

#read in the data which is in a csv file
presidents <- read.csv(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Homework/presidents.csv",header = TRUE)

library(faraway)
library(psych)
library(smooth)

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Homework/HW14_Figures.pdf")

head(presidents,1L)
str(presidents)

MovingAverage <- sma(presidents$presidents,order=5,silent=FALSE)   #HW assignment a)
summary(MovingAverage)

#c) Compute the Simple Moving Average using 5 data points at quarter =10.

HW14c <- cbind(MovingAverage$y,MovingAverage$fitted)
head(HW14c,20L)  

plot(MovingAverage$y[10],MovingAverage$fitted[10],xlab="original data",ylab="SMA(5)")

MovingAverage <- sma(presidents$presidents,order=10,silent=FALSE)  #HW assignment b)
summary(MovingAverage)

#--------------------------------------------------------------------------------#
#by default sma provides optimal order based on AICc and returns the model with the lowest value of AICc
sma(presidents$presidents,silent=FALSE)  

sma(presidents$presidents,order=1,silent=FALSE)
sma(presidents$presidents,order=2,silent=FALSE)
sma(presidents$presidents,order=3,silent=FALSE)
sma(presidents$presidents,order=4,silent=FALSE)
sma(presidents$presidents,order=5,silent=FALSE)

#--------------------------------------------------------------------------------#
sma(presidents$presidents,order=1,silent=FALSE)
MovingAverage1 <- sma(presidents$presidents,order=1,silent=FALSE)
summary(MovingAverage1)
plot(MovingAverage1$y,MovingAverage1$fitted,xlab="original data",ylab="SMA(1)")
plot(MovingAverage1$y~MovingAverage1$fitted,xlab="original data",ylab="SMA(1)")

sma(presidents$presidents,order=10,silent=FALSE)

#h=Length of forecasting horizon   holdout: If TRUE, holdout sample of size h is taken from the end of the data.
MovingAverage1 <- sma(presidents$presidents,order=1,h=20,holdout=TRUE,silent=FALSE)  	
plot(MovingAverage1)

MovingAverage10 <- sma(presidents$presidents,order=10,h=20,holdout=TRUE,silent=FALSE)  	
plot(MovingAverage10)
#--------------------------------------------------------------------------------#
print(MovingAverage1$accuracy)
print(MovingAverage10$accuracy)

##--------------------------------------------------------------------------------##
dev.off()