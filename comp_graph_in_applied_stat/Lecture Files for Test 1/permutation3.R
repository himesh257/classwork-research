#Example of a permutation test in Regression
if (FALSE)
{"
see page 40 in text
"}
 
library(faraway)


lmod <- lm(Species ~ Nearest + Scruz, data=gala)

show1 <- summary(lmod)
show1
names(show1)
show1$fstatistic

show1$fstatistic[1]
show1$fstatistic[2]
show1$fstatistic[3]

1-pf(show1$fstatistic[1],show1$fstatistic[2],show1$fstatistic[3])

set.seed(123)
#perform permuation test by permuting the Species (or y) observations
#note there are 30! permutations of the y vector
factorial30 <- factorial(30)  #factorial(x) computes the factorial of x
factorial30

#so, try sampling among the many permutations
nreps <- 4000
vector_fstats <- numeric(nreps)
head(vector_fstats)

for (i in 1:nreps) {
lmod_permute <- lm(sample(Species,rep=FALSE) ~ Nearest + Scruz, data=gala)
#the sampling is without replacement

vector_fstats[i] <- summary(lmod_permute)$fstatistic[1]
}

mean(vector_fstats > show1$fstatistic[1])
