
windows(7,7)
#save graphics output in a pdf file
#pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 01 21Jan2020/random_numberR_out.pdf")


#Random number generators in R
#You can use set.seed(12345) or some other permutation to create reproducible pseudo-random numbers.

set.seed(54312)

#rnorm(n, m=0,sd=1)	n random normal deviates with mean m and standard deviation sd. 
#generate 100 random normal variates with mean=50, sd=10
ynorm <- rnorm(100, m=50, sd=10)
ynorm

hist(ynorm,xlab="Random Normal",main="Example of Normal Random Number Generation")

# rbinom(n, size, prob)  binomial distribution where n is the number of random numbers, size is the number of trials and prob is the probability of a heads (pi) 
ybinom1 <- rbinom(50,10,.2)
ybinom1
ybinom2 <- rbinom(50,10,.5)
ybinom2
ybinom3 <- rbinom(50,10,.8)
ybinom3

hist(ybinom1,xlim=c(0,10),xlab="Random Binomial with 10 trials, p=.2",main="Example of Binomial Random Number Generation")

hist(ybinom2,xlim=c(0,10),xlab="Random Binomial with 10 trials, p=.5",main="Example of Binomial Random Number Generation")

hist(ybinom3,xlim=c(0,10),xlab="Random Binomial with 10 trials, p=.8",main="Example of Binomial Random Number Generation")

#rpois(n, lamda) poisson distribution with m=std=lamda, n is the number of observations
ypois <- rpois(50,3) #average number of events per unit of time is 3
ypois

hist(ypois,xlab="Random Poisson with mu=3 and 50 random observations",main="Example of Poisson Random Number Generation")

#runif(n, min=0, max=1) uniform distribution of n observations from 0 to 1
yuni  <- runif(50,min=0,max=1)
yuni
 
hist(yuni,xlim=c(0,1),xlab="Random Uniform 50 random observations on 0 to 1",main="Example of Uniform (0,1) Random Number Generation")

if (FALSE)
{"
You can also use the uniform random variable generator to generate probability distributions. x=ranuni(0);
y=F-1(x) y ~ F  so if F-1 is the inverse exponential then y is ~ exponential
Random number generators are used in simulations.
Pharmacoeconomic models use discrete event simulation.  So patients are followed as events 
occur - disease, hospitalized or not, if hospitalized then infection or not.
"}

set.seed(45123)
ypois <- rpois(100,3) #generate a poisson with lambda = average number of events per unit of time = 3

#use the Finverse approach
yuni  <- runif(100,min=0,max=1)

ypois_uni <- qpois(yuni,3)
sort(ypois_uni)

poisson_data <- data.frame(ypois,ypois_uni)

#compare the two Poisson random variables
plot(sort(ypois_uni) ~ sort(ypois),poisson_data) #scatterplot 

##---------------------------------------------------##

dev.off()

