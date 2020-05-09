##### Empirical Distribution Function  By Eric Cai - The Chemical Statistician
# set the seed for consistent replication of random numbers
set.seed(12354)
# generate 100 random numbers from the standard normal distribution
normal.numbers <- rnorm(100)

# empirical normal CDF of the 100 normal random numbers
normal.ecdf <- ecdf(normal.numbers)   # plot normal.ecdf (notice that the only argument needed is normal.ecdf)
normal.ecdf
plot(normal.ecdf) 