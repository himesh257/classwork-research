## Find maximum likelihood estimator of Binomial(n,p) if n=10 and y=5
## P(Y=y) = (n choose y) * p^y * (1-p)^(n-y)
## Take natural log of P(Y=y)
## f(p) = ln(P(Y=y))= ln(n choose y) + yln(p) + (n-y)ln(1-p)
## Compute first derivative of f(p) and set = 0  
## h(p) = f'(p) where f'(p) = y/p + (n-y)*(-1/(1-p))
## h'(p) = [-y/(p**2)] - [(n-y)/(1-p)**2]
## note that h'(p) is f''(p)
## Find zero of h(p) for a given n and y - for this example n=10 and y=5

p=seq(0,1,len=200) #define the domain of p
h_p_=(5/p) - (5/(1-p)) ## h(p) = y/p + (n-y)*(-1/(1-p))  #we need to find the 0 of h(p)

##save in pdf
 windows(7,7)
 pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 10 21Feb2020/newtonraphsonexampleR_out.pdf")

## First plot the function h(p) where p is between 0 and 1
plot(p,h_p_,type="l",xlab="p",ylab="h(p)",ylim=c(-25,25),main="Newton Raphson",sub=" ")

axis(2, at = seq(-25, 25, by =  5), las=0) 
axis(1, at = seq(0, 1,    by = .1), las=0)

abline(h=0,lty=2,col="blue") 
abline(v=.5,lty=2,col="blue") 

##now look at the Newton-Raphson solution
## Perform Newton-Raphson method to find the 0 of h(p) = (5/p) - (5/(1-p))  

newton.for.h <- function(initial.value,num.its)
 {
## Inputs:  
## initial.value = starting value for optimization
## num.its = number of iterations

## Outputs:
## out = matrix with two columns
## column 1 = iteration number
## column 2 = the sequence of updated estimates of the maximum of the function
## in class notes, h is fprime=f' where f'(p) = 5/p + (10-5)*(-1/(1-p))
## and h' is f'' where f'' is -5/(p**2)  -  5/(1-p)**2
 
## so T(k+1) = T(k) - [f'(T(k)) / f''(T(k))]  note below k+1 is i and k is i-1 
p=rep(0,num.its)  #define a vector of 0's with length equal to the number of iterations

p[1]=initial.value

for (i in 2:num.its) 
{
num=(5/p[i-1])-(5/(1-p[i-1])) 
den=(-5/(p[i-1]*p[i-1])) - (5/((1-p[i-1])*(1-p[i-1])))

#d=(-5/(p[i-1]*p[i-1])-(5/(1-p[i-1])*(1-p[i-1])))

p[i]= p[i-1]-(num/den)
}
out=cbind(1:num.its,p)
dimnames(out)[[2]]=c("iteration","estimate")
return(out)
}  #closes the definition of the function newton.for.h

## Try it for 15 iterations for various starting points

newton.for.h(.1,15)
newton.for.h(.2,15)
newton.for.h(.3,15)
newton.for.h(.4,15)
newton.for.h(.5,15)
newton.for.h(.6,15)
newton.for.h(.7,15)
newton.for.h(.8,15)
newton.for.h(.9,15)

## Try it for 15 iterations with initial estimates that do not make sense

newton.for.h(0,15)
newton.for.h(1,15)
newton.for.h(1.1,15)

