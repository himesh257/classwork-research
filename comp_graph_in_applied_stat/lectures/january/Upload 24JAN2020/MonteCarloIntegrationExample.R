set.seed(13245)
n = 5000
x1 = runif(n, min =0 , max =1 )
y1 = runif(n, min =0 , max =1 )
plot(x1,y1,col='blue',pch=20)
f <- function(x) ((sin(10*x^2))^2*sin(x))*x+0.1
curve(f,0,1,n=100,col='red',lwd=5,add=TRUE)

#separate the dots below the curve
n = 1000
x1 = runif(n, min =0 , max =1 )
y1 = runif(n, min =0 , max =1 )
f1 <- ((sin(10*x1^2))^2*sin(x1))*x1+0.1
plot(x1[(y1 > f1)],y1[(y1 > f1)],col='yellow',pch=20)
points(x1[(y1 <= f1)],y1[(y1 <= f1)],col='blue',pch=20)
f <- function(x) ((sin(10*x^2))^2*sin(x))*x+0.1
curve(f,0,1,n=100,col='red',lwd=5,add=TRUE)

# count dots above
area_above = length(y1[(y1 > f1)])
# count dots below
area_below = length(y1[(y1<=f1)])
# For nomalized square (1x1), the integration from 0 to 1
# note - cat is useful for producing output in user-defined functions
cat("Integrate function = ((sin(10*x^2))^2*sin(x))*x+0.1, from 0 to 1")

## Integrate function = ((sin(10*x^2))^2*sin(x))*x+0.1, from 0 to 1 
cat("Area under curve f (integrated from 0 to 1) =", area_below/n)

## Area under curve f (integrated from 0 to 1) = 0.269
