#simple moving average (sma)
#install the following libraries if needed

library(faraway)
library(smooth)
library(Mcomp)
library(tibbletime)
library(dplyr)
library(tidyr)

#save graph in pdf
windows(7,7)
# pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/sma_Figure.pdf")

data(FB) #closing stock market price of Facebook from 2013-2016
head(FB) #the data are sorted by date
FB <- data.frame(select(FB,date,close))  #select only date and close as variables
head(FB,25L)

MovingAverage <- sma(FB$close,order=20,silent=FALSE)  #use order=20 to calculate moving averages with n=20
names(MovingAverage)
head(MovingAverage$fitted,25L)

MovingAverage <- sma(FB$close,order=10,silent=FALSE)
summary(MovingAverage)

MovingAverage <- sma(FB$close,order=25,silent=FALSE)
summary(MovingAverage)

MovingAverage <- sma(FB$close,order=50,silent=FALSE)
summary(MovingAverage)

MovingAverage <- sma(FB$close,h=20,silent=FALSE) #the h option allows the choice of the best order
summary(MovingAverage)

dev.off()


