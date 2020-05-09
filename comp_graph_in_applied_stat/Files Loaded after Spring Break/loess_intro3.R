
library(faraway)
library(psych)
library(sm)
library(ggplot2)

# Classic dataset about the Old Faithful geyser in Yellowstone National Park, Wyoming
# each row has two observed variables on an observed eruption: duration of eruption (minutes)
# waiting - waiting time to next eruption (minutes) 

head(faithful,5L)

#save graph in pdf
windows(7,7)
#pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/loess_intro3_Figure.pdf")

plot(waiting ~ eruptions, data=faithful,main="Old Faithful")

##-----------------------------------------------------##

with(faithful,{
plot(waiting ~ eruptions, col=gray(0.75))
f <- loess(waiting ~ eruptions)
i <- order(eruptions)
lines(f$x[i],f$fitted[i])
})


describe(faithful$eruptions)

#h: A normal kernel function is used to assign weights for the smoothing at x0 and h is its standard deviation.
# h can be used to approximate the span.  Since sm.regression uses a normal kernel 
# with standard deviation h to assign weights for the local weighted regression at 
# a point x0, the span which is the proportion of sample data observations providing positive weights  
# at x0 can be approximated by h/[(maximum(x's) - minimum(x's)/6].  The points with positive weights
# for each x0 are located within x0 -3h to x0 +3h or within an interval approximately 6h. 
# Assuming the X-values are spead out then the rough appoximation of span can be converted to    
# a rough approximation of h equal to [span*(maximum(x's) - minimum(x's)]/6.

with(faithful,sm.regression(x=eruptions,y=waiting,h=.1))
with(faithful,sm.regression(x=eruptions,y=waiting,h=.2))
with(faithful,sm.regression(x=eruptions,y=waiting,h=.3))
with(faithful,sm.regression(x=eruptions,y=waiting,h=.4))
with(faithful,sm.regression(x=eruptions,y=waiting,h=.5))

#We can use cross-validation to choose the best h to use for the normal kernel function standard deviation.

usecv<-with(faithful,sm.regression(x=eruptions,y=waiting,h=h.select(eruptions,waiting,method="cv")))
usecv$h

CVspan <- usecv$h/((5.1 - 1.6)/6)
CVspan

loessData <- data.frame(x = faithful$eruptions,y=predict(loess(waiting~eruptions,faithful,span=CVspan)),
               method = "loess()")

loessData <- data.frame(cbind(loessData,faithful$eruptions,faithful$waiting))

ggplot(loessData, aes(faithful.eruptions,faithful.waiting)) + 
  geom_point(dat = faithful, aes(x=eruptions, y=waiting), alpha = 0.9, col = "black") +
  geom_point(dat = loessData, aes(x, y), alpha = 0.9, col = "red") +
  geom_line(data=loessData,col = "blue") +
  facet_wrap(~method) +
  ggtitle("Loess at CV Validation chosen h (approximately)") +
  theme_bw(16)

dev.off()
