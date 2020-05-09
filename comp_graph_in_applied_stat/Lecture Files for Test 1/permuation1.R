#What Are P values? From Understanding Hypothesis Tests_ Significance Levels (Alpha) and P values in.pdf 
#P-values are the probability of obtaining an effect at least as extreme
#as the one in your sample data, assuming the truth of the null hypothesis.

#Permutation tests
if (FALSE)
{"
Data:  Two independent samples of rocket propellant type (type1, type2)
Response is burn time
"}

type1 = c(65,81,57,66,82,82,67,59,75,70)
type2 = c(64,71,83,59,65,56,69,74,82,79)
#generate descriptive statistics

summary(type1)
summary(type2)

#perform F-test of equality of variances
var.test(type1,type2)

if (FALSE)
{"
We obtained p-value greater than 0.05,
then we can assume that the two variances are homogeneous (equal).
Indeed we can compare the value of F obtained with the tabulated value of F for alpha = 0.05,
degrees of freedom of numerator = 9, and degrees of freedom of denominator = 9,
using the function qf(p, df.num, df.den):
"}

#compare the computed F-statistic to the 0.975 quantile of an F-distribution with num=9 and denom=9 df
qf(0.975, 9, 9) # 97.5% quantile from F-distribution with 9 df in numerator and 9 df in denominator

#perform the two-sample t-test
t.test(type1,type2,var.equal=TRUE, paired=FALSE)

qt(0.975, 18)  # 97.5% quantile from t-distribution with 18 df


windows(7,7)
#now save the ecdf in a pdf file
 pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 06 07Feb2020/permutation1R_out.pdf")

qqnorm(type1)  #Normal Quantile-Quantile plot
qqline(type1)

qqnorm(type2)
qqline(type2)

#generate a single column vector of two variables, type and burntime
example <- data.frame(type=c(rep("1", times=length(type1)), 
           rep("2", times=length(type2))), 
           burntime=c(type1,type2))
attach(example)  #The database is attached to the R search path.This means that the database is searched
#by R when evaluating a variable, so objects in the database can be accessed by simply giving their names.

#print data
example

t.test(burntime~type,var.equal=TRUE)

if (FALSE)
{"
Permutation Tests
The logic behind a permutation test is straightforward. Logic: Okay, these are the twenty (in this example) scores
we observed.  If in fact the two samples came from the same population (assume the null hypothesis) then here is one
possible permutation of the twenty scores. There are, in fact 20Choose10
"}

choose(20,10)

if (FALSE)
{"
...possible permutations (technically combinations--but same idea) of these data into two groups of ten,
 and each is equally likely to occur if we were to pick one at random out of a hat. Most of these permutations
 would give no or little difference between the group means, but a few of them would give large differences.
 How extreme is the obtained case? In other words, the logic of the permutation test is quite similar to the
 logic of the t-test. If the obtained case is in the most extreme 5% of possible results, then we reject the null
 hypothesis of no difference between the means (assuming we were looking at differences between means).
 The advantage of the permutation test is it does not make any assumption about normality, and in fact, doesn't
 make any assumption at all about parent distributions. Furthermore, a permutation test is generally more powerful
 than a traditional nonparametric test. 
The disadvantage of a permutation test is the number of permutations that must be generated.
Instead of using all possible permutations, take a random sample of possible permuations
"}

set.seed(13254)

R <- 100000
scores <- burntime
t.values <- numeric(R)

for (i in 1:R) {
index <- sample(1:20, size=10, replace=FALSE)
group1 <- scores[index]
group2 <- scores[-index]
t.values[i] = t.test(group1,group2)$statistic
}

#we took a random sample of the vector 1 to 20, without replacement,
# and stored that in an object called index. These index values were then used
# to extract the first resampled group of scores. 
#The second group of scores was extracted using a trick, which in words goes, 
#for group two take all the scores that are not indexed by the values in index.
# In other words, put the remaining scores in group two. Then we did the t-test and stored
# the test statistic (t-value). It now remains to compare those simulated t-values to the one
# we obtained above when we did the actual t-test.


t.values = abs(t.values)         # for a two-tailed test
#or curiosity, compute the proportion of abs(t-values) >= 0.048008 
mean(t.values >=0.048008)        
# note: 0.048008 was the computed t-statistic from the two-sample test.
# recall p-value from the two-sample t-test was equal to 0.9622

#The resampling scheme tells us that a little more than 0.9412 of the simulations gave us a abs(t.value)
 #as extreme or more extreme than the abs(t* observed in the experiement).
 #This is the p-value resulting from the randomization test.
 #We can see that it is pretty close to the p-value obtained in the actual t-test above (0.9622).
 #The difference may be nothing more than random noise, 
 #or we may be seeing that the t-test was a bit too generous here, perhaps due to nonnormality. 

#For more information on permutation tests available in the coin package:
#help(package="coin")

### Permutation test using the R package coin

#install.packages("coin") #install if the package is not already installed

library(coin)
# independence of burntime and type via normal scores test independence_test
# go to www.rseek.org and search: nonparametric independence test for more information

independence_test(burntime ~ type, data = example,teststat = "max",alternative = "two.sided", distribution = "asymptotic")

##-------------------------------------------------------------##

dev.off()
