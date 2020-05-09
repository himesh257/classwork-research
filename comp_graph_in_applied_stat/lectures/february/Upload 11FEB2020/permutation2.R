#Another example of a permutation test

if (FALSE)
{"
Data: 15 observations of SAT and GPA on a random sample of 15 individuals,
Problem:  determine if correlation is 0
see http://www.statmethods.net/stats/resampling.html
need to use library(coin)
  Spearman rank correlation is a non-parametric alternative to Pearson product-moment correlation
  where x and y are numeric variables.
H0:  Y and X are independent , that is correlation is 0
"}

SAT <- c(576,635,578,558,666,580,555,651,661,605,575,653,545,572,594)
GPA <- c(3.9,3.8,3.3,3.5,4.0,3.6,4.0,3.5,3.9,3.6,3.6,3.2,3.2,3.3,3.4)

plot(SAT,GPA)
#calculate empirical correlation of the data
r.hat <- cor(SAT,GPA)  #Pearson product-moment correlation
r.hat

mydata <- data.frame(SAT,GPA)

set.seed(13254)

# Spearman Test of Independence
library(coin)
#first obtain a p-value for the spearman test of independence using asymptotic (or large sample) approach
#for example, we know the asymptotic (large sample) distribution of Xbar
#is Normal with mean=mu and variance=(sigma**2/n)
 
spearman_test(SAT~GPA, distribution="asymptotic", data=mydata) #nonparametric test

#now perform some resampling of the possible 15! permuations of the pairing of SAT and GPA for individuals

set.seed(13254)  
# Spearman Test of Independence based on Monte-Carlo
spearman_test(SAT~GPA, data=mydata, distribution=approximate(B=10000))

spearman_test(SAT~GPA, data=mydata, distribution=approximate(B=100000))
