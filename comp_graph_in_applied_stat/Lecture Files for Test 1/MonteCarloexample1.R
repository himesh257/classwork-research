#Monte Carlo simulation to compute the probability of simple event
#Acknowledgement:  https://www.countbayesie.com/blog/2015/3/3/6-amazing-trick-with-monte-carlo-simulations

if (FALSE)
{"
Suppose we rolled two fair dice. What is the probability that their sum is at least 7?
We will approach this by simulating many throws of two fair dice,
and then computing the fraction of those trials whose sum is at least 7.
It will be convenient to write a function that simulates the trials and returns TRUE
if the sum is at least 7 (we call this an event), and FALSE otherwise.
"}

#isEvent is a function that is defined below
isEvent = function(numDice, numSides, targetValue, numTrials){
  apply(matrix(sample(1:numSides, numDice*numTrials, replace=TRUE), nrow=numDice), 2, sum) >= targetValue
         }

#Now that we have our function, we are ready to simulate

#It is good practice to set the random seed for reproducibility and debugging
set.seed(12345)

#try 5 trials
outcomes = isEvent(2, 6, 7, 5) #numDice=2 numSides=6  targetvalue=7 numTrials=5
outcomes

mean(outcomes)

#This result is very different from the theoretical answer of \(\frac{21}{36}=0.58333\). Now try with 10,000 trials

set.seed(12345)
outcomes = isEvent(2, 6, 7, 10000)
mean(outcomes)

set.seed(12345)
outcomes = isEvent(2, 6, 7, 100000)

table(outcomes)
mean(outcomes)
#this estimate is much better

