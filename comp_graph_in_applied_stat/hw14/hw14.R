library(smooth)

presidents <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw13/presidents.csv",header = TRUE)

# sma at order 5
MovingAverage5 <- sma(presidents$presidents,order=5,silent=FALSE)
summary(MovingAverage5)

# sma at order 10
MovingAverage10 <- sma(presidents$presidents,order=10,silent=FALSE)
summary(MovingAverage10)

#sma with 5 datapoints at quarter 10
MovingAverage <- sma(presidents$presidents,order=5,silent=FALSE)
summary(MovingAverage)
