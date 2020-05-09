library(faraway)

##---------------------------------------------------------------------##
##See Exercise 3 on page 30 of text

set.seed(13245)
x <- 1:20
y <- x+rnorm(20)

print(x)
print(y)

plot(x,y,type="p",xlab="x",ylab="rnorm(x)",ylim=c(0,25),xlim=c(0,20),main="Exercise 3 page 30 of text",sub=" ")

lwy <- loess(y ~ x)  #loess is a smoothing function that we will review later

plot(x,y,xlab="x",ylab="rnorm(x)",ylim=c(0,25),xlim=c(0,20),main="Exercise 3 page 30 of text",sub=" ")
lines(predict(lwy),col='red',lwd=2)

quad_model <- lm(y ~x + I(x^2))
summary(quad_model)

predicted <- -0.6234103 + 1.0591937*x - 0.0002863*x*x  
#note the use of the set.seed(13245) allowed me to reproduce the random numbers

lines(x,predicted,col='blue',lwd=2)
#note the smoothed line is very close to the least squares quadratic fitted line
##---------------------------------------------------------------------##

Sys.time()  #this function time stamps the output