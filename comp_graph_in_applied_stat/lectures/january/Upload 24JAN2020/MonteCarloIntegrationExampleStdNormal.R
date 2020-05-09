#Use Monte Carlo approach to compute area under the standard normal curve (AUC) from 0 to 1
#Using standard normal table the AUC should be 0.3413

set.seed(13245)
n = 5000
x1 = runif(n, min =0, 1 )
y1 = runif(n, min = 0 , 1 )
plot(x1,y1,col='blue',pch=20)
f <- function(x) exp(-x*x/2)/(sqrt(2*pi))
curve(f,from=0, to=1,n=200,col='red',lwd=5,add=TRUE)

set.seed(13245)
#separate the dots below the curve
n = 1000
x1 = runif(n, min =0 , max =1 )
y1 = runif(n, min =0 , max =1 )
f1 <- exp(-x1*x1/2)/(sqrt(2*pi))
plot(x1[(y1 > f1)],y1[(y1 > f1)],col='yellow',pch=20)
points(x1[(y1 <= f1)],y1[(y1 <= f1)],col='blue',pch=20)
f <- function(x) exp(-x*x/2)/(sqrt(2*pi))
curve(f,from=0,to=1,n=200,col='red',lwd=5,add=TRUE)

# count dots above
area_above = length(y1[(y1 > f1)])
# count dots below
area_below = length(y1[(y1<=f1)])

# note - cat is useful for producing output in user-defined functions
cat("Integrate function = standard normal density function from 0 to 1")


## Integrate function = standard normal density function from 0 to 1 
cat("Area under curve f (integrated from 0 to 1) =", (area_below/n))

## Area under standard normal curve (integrated from 0 to 1) is equal to 0.3413
