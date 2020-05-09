#HW13
if (FALSE)
{"
Use the presidents data set (presidents.csv, found in Files: presidents.csv  ) that shows quarterly approval ratings of US presidents during 30 years starting in 1945.
a) Generate two lowess plots using spans that you choose between 0.05 and 1.
b) Provide 1 or 2 sentences describing the pattern for the span you choose.
c) Generate two smoothing plots with normal kernel density standard deviation h between .2 and .8
d) Provide 1 or 2 sentences describing the pattern for the h you choose.
"}
#See useful R code below.

#read in the data which is in a csv file
presidents <- read.csv(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Homework/presidents.csv",header = TRUE)

library(faraway)
library(psych)
library(sm) #install if not already installed

head(presidents,1L)
str(presidents)
describe(presidents)

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Homework/HW13_Figures.pdf")

#code to use for different spans. The one below uses a span of 0.20
with(presidents,{
plot(presidents ~ quarter, col=gray(0.1))
f <- loess(presidents ~ quarter,span=0.20)
i <- order(quarter)
lines(f$x[i],f$fitted[i])
})

#code to use for different choices of h. The one below uses an h
library(sm) #install if not already installed
with(presidents,sm.regression(x=quarter,y=presidents,h=.1))
##--------------------------------------------------------------------------------##
#code to use for different spans. The one below uses a span of 0.05
with(presidents,{
plot(presidents ~ quarter, col=gray(0.1))
f <- loess(presidents ~ quarter,span=0.05)
i <- order(quarter)
lines(f$x[i],f$fitted[i])
})

#code to use for different spans. The one below uses a span of 1.0
with(presidents,{
plot(presidents ~ quarter, col=gray(0.1))
f <- loess(presidents ~ quarter,span=1)
i <- order(quarter)
lines(f$x[i],f$fitted[i])
})

#code to use for different choices of h. The one below uses an h of 0.1
with(presidents,sm.regression(x=quarter,y=presidents,h=.1))
with(presidents,sm.regression(x=quarter,y=presidents,h=.2))
with(presidents,sm.regression(x=quarter,y=presidents,h=.3))
with(presidents,sm.regression(x=quarter,y=presidents,h=.4))
with(presidents,sm.regression(x=quarter,y=presidents,h=.5))

#Extension of HW Exercise

#We can use cross-validation to choose the best h to use for the normal kernel function standard deviation.
usecv<-with(presidents,sm.regression(x=quarter,y=presidents,h=h.select(presidents,quarter,method="cv")))
usecv$h

# Assuming the X-values are spread out then the rough approximation of span can be converted to    
# a rough approximation of h equal to [span*(maximum(x's) - minimum(x's))]/6.
CVspan <- usecv$h/((120 - 1)/6)
CVspan  #also will try this span value

#code to use for different spans. The one below uses a span ~ derived from the optimal h that is chosen
with(presidents,{
plot(presidents ~ quarter, col=gray(0.1))
f <- loess(presidents ~ quarter,span=CVspan)
i <- order(quarter)
lines(f$x[i],f$fitted[i])
})

#Another extension of HW Exercise
#Fit a smoothed curve using lowess to the ozone data.frame.  

# ozone data.frame consists of results from a study on the relationship between atmospheric ozone concentration
# and meteorology in the Los Angeles Basin in 1976 (n=330 observations)
# O3 - Ozone concentration, ppm, at Sandburg Air Force Base
# temp - temperature F

data(ozone)
head(ozone,5L)

plot(x=ozone$temp,y=ozone$O3)
with(ozone,sm.regression(x=ozone$temp,y=ozone$O3,h=.2))  #recall h is the smoothing fraction

plot(x=ozone$temp,y=ozone$O3)
with(ozone,sm.regression(x=ozone$temp,y=ozone$O3,h=1))  #recall h is the smoothing fraction

usecv<-with(ozone,sm.regression(x=ozone$temp,y=ozone$O3,h=h.select(ozone$temp,ozone$O3,method="cv")))
usecv$h


##----------------------------------------------------------------##
dev.off()