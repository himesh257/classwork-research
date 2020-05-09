library(vcd)
## Simulated data examples:

library(psych)

#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/distplotexample.pdf")

# output is directed to poissonness.txt - new file is built - output is also sent to terminal. 
sink("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/distplot.txt",append=FALSE,split=TRUE) 

#See Poisson.pdf for a description of the Poisson distribution
#generate 10000 observations from a Poisson distribution with lambda=2
poisson <- rpois(10000,lambda=2)
describe(poisson)   #mean is lambda and variance is lambda

hist(poisson,breaks=c(0,1,2,3,4,5,6,7,8,9,10),prob=TRUE,ylim=c(0,1.0),border="blue",main="Poisson histogram with lambda=2") 

if (FALSE)
{"The Negative Binomial Random Variable is the number X of repeated trials to 
produce r successes in a negative binomial experiment:  Suppose we flip a coin repeatedly and 
count the number of heads (successes). If we continue flipping the coin until it
has landed 2 times on heads, we are conducting a negative binomial experiment. 
"}

#generate 10000 observations from a negative binomial with p=0.25 size=2 ==> number of failures before the second success
neg_binom <- rnbinom(10000,size=2, prob=0.25)
head(neg_binom)
describe(neg_binom)  #a zero represents the sequence S,S, 0 failures before the second success

hist(neg_binom,prob=TRUE,ylim=c(0,0.2),border="blue",main="Negative binomial histogram with p=0.25")  
# Kernel Density Plot
#help(density)   # also see kernel density plots from http://www.r-bloggers.com/

d <- density(neg_binom)  # returns the density data 
plot(d,main="kernel density of neg_binom") # plots the results 
hist(neg_binom,prob=TRUE,ylim=c(0,0.2),border="blue",main="Negative binomial histogram with #Successes=2 and p=0.25")  
lines(d)

distplot(neg_binom,type="nbinomial",main="Negative binomialness plot")

distplot(neg_binom,type="poisson",main="Poissonness plot")

#dev.off()
#sink() #redirects output to terminal
