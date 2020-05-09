#read in the data which is in a csv file
presidents <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw13/presidents.csv",header = TRUE)
head(presidents)
str(presidents)

library(faraway)
#code to use for different spans. The one below uses a span of 0.20
with(presidents,{
  plot(presidents ~ quarter, col=gray(0.1))
  f <- loess(presidents ~ quarter,span=0.20)
  i <- order(quarter)
  lines(f$x[i],f$fitted[i])
})
summary(f)

# The one below uses a span of 0.80
with(presidents,{
  plot(presidents ~ quarter, col=gray(0.1))
  f <- loess(presidents ~ quarter,span=0.80)
  i <- order(quarter)
  lines(f$x[i],f$fitted[i])
})

#code to use for different choices of h. The one below uses an h
library(sm) #install if not already installed
with(presidents,sm.regression(x=quarter,y=presidents,h=.1))

with(presidents,sm.regression(x=quarter,y=presidents,h=.2))
with(presidents,sm.regression(x=quarter,y=presidents,h=.8))



