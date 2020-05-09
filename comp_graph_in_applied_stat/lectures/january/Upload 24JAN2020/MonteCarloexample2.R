#Monte Carlo simulation to predict performance of a stock
#Acknowledgement:  https://www.countbayesie.com/blog/2015/3/3/6-amazing-trick-with-monte-carlo-simulations
#On average CompanyX gains 1.001 times its opening price during the trading day,
#but that can vary by a standard deviation of 0.005 on any given day (this is known as its volatility). 

#Simulate a single sample path for CompanyX by taking the cumulative product
#from a Normal distribution with a mean of 1.001 and a sd of 0.005.
#Assuming CompanyX opens at $20/per share here is a sample path for 200 days of CompanyX trading.

#what is meant by a cumulative product?  

A = 1:5
#A  1 2 3 4 5    1   1x2=2 1x2x3=6 1x2x3x4=24 1x2x3x4x5=120
B = cumprod(A)
B

#It is good practice to set the random seed for reproducibility and debugging
set.seed(54321)

days <- 200
changes <- rnorm(200,mean=1.001,sd=0.005)
plot(cumprod(c(20,changes)),type='l',ylab="Price",xlab="day",main="CompanyX closing price (sample path)")

#But this is just one possible future! 
#If you are thinking of investing in CompanyX you want to know what are the possible closing prices of the stock at the end of 200 days.
#To assess risk in this stock we need to know what are reasonable upper and lower bounds on the future price.
#To solve this we'll just simulate 100,000 different possible paths the stock could take
#and then look at the distribution of closing prices. 

runs <- 100000

#simulates future movements and returns the closing price on day 200
generate.path <- function(){
  days <- 200
  changes <- rnorm(200,mean=1.001,sd=0.005)
  sample.path <- cumprod(c(20,changes))
  closing.price <- sample.path[days+1] #+1 because we add the opening price
  return(closing.price)
                }
mc.closing <- replicate(runs,generate.path())

hist(mc.closing)

stem(mc.closing) #returns a stem and leaf display

#We can obtain the median price of CompanyX in this simulation at the end of 200 days
#along with the upper and lower 95th percentiles 

library(stats) #this library has the quantile function
median(mc.closing) 
quantile(mc.closing,0.95) 
quantile(mc.closing,0.05) 


#Real world quantitative finance makes heavy use of Monte Carlo simulations
