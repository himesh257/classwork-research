# R program for HW 1 - 9

##all packages needed for HW 1-9 are provided below
##these were loaded all at one time at the start of the HW solutions

library(faraway) #loads the library faraway into the current session
library(psych)
library(ggplot2)
library(vcd) 
library(quantreg)


#HW01

#For numerical summary: the summary statement of ALL variables is sufficient. 
head(prostate)
summary(prostate)
describe(prostate)

windows(7,7)
#save all graphics output into pdf files
 pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/HW01.pdf")

#For graphical summary: provide histogram plot and density plot of lpsa.
hist(prostate$lpsa,xlab="LPSA",main="")  

ggplot(data=prostate,aes(x=prostate$lpsa)) + geom_histogram(aes(y =..density..), 
      breaks=seq(-1, 6, by = 1), 
      col="red", 
      fill="blue", 
      alpha = .2) + geom_density(col="red") + 
  labs(title="Histogram for LPSA") +
  labs(x="LPSA", y="Count")

#Also provide a scatter plot with x=lpsa and y=lcavol.
plot(lcavol ~ lpsa,prostate) #scatterplot 

dev.off()

##-------------------------------------------------------------##

#HW02
set.seed(13245)

# a) Generate poisson, binomial, negative binomial Diagnostic Distribution Plots using distplot
# b) Generate a histogram and overlay a kernel estimator of the density

binom <- rbinom(n=1000,size=30, prob=0.2)
describe(binom)

windows(7,7)

#note size is not specified.  ylim range is not specified
#sometimes it is better to accept the defaults of the package
#save all graphics output into pdf files

 pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/HW02.pdf")

distplot(binom,type="poisson",main="Poissonness Plot")  
distplot(binom,type="binomial",main="Binomialness Plot")
distplot(binom,type="nbinomial",main="Negative Binomialness Plot")

binom <- data.frame(binom)
head(binom)

#Generate a histogram and overlay a kernel estimator of the density
ggplot(data=binom,aes(x=binom)) + geom_histogram(aes(y =..density..), 
      breaks=seq(0, 15, by = 1), 
      col="red", 
      fill="blue", 
      alpha = .2) + geom_density(col="red") + 
  labs(title="Histogram for Binomial Random Counts(n=30,p=0.2)") +
  labs(x="Binomial RV", y="Count")

dev.off()

##-------------------------------------------------------------##

#HW03
set.seed(14532)

# a) Generate poisson, binomial, negative binomial Diagnostic Distribution Plots using distplot
# b) Generate a histogram and overlay a kernel estimator of the density

poisson <- rpois(n=1000,lambda=2.4)
describe(poisson)

windows(7,7)
pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/HW03.pdf")

distplot(poisson,type="poisson",main="Poissonness Plot")  
distplot(poisson,type="binomial",main="Binomialness Plot")
distplot(poisson,type="nbinomial",main="Negative Binomialness Plot")

poisson <- data.frame(poisson)
head(poisson)

#Generate a histogram and overlay a kernel estimator of the density
ggplot(data=poisson,aes(x=poisson)) + geom_histogram(aes(y =..density..), 
      breaks=seq(0, 10, by = 1), 
      col="red", 
      fill="blue", 
      alpha = .2) + geom_density(col="red") + 
  labs(title="Histogram for Poisson Counts(lambda=2.4)") +
  labs(x="Poisson RV", y="Count")

dev.off()
##-------------------------------------------------------------##

#HW04
describe(pima)

#Compute the mean, 0.05 trimmed mean, 0.10 trimmed mean, 0.05 winsorized mean, and 0.10 winsorized mean
trim1 <- describe(pima$bmi,trim=0.0)
print(trim1,digits=5)

trim2 <- describe(pima$bmi,trim=0.05)
print(trim2,digits=5)

trim3 <- describe(pima$bmi,trim=0.1)
print(trim3,digits=5)

winsor.mean(pima$bmi, trim=.05) #Winsorized mean
winsor.mean(pima$bmi, trim=.1) #Winsorized mean

winsor1 <- winsor(pima$bmi, trim=.05) #Winsorized mean
winsor2 <- winsor(pima$bmi, trim=.1)  #Winsorized mean

sort(winsor1)
sort(winsor2)

##-------------------------------------------------------------##

#HW05
describe(prostate)

#Perform a simple linear regression with lpsa as the response and lcavol as the predictor.
#Show the ANOVA table and provide a histogram of the residuals. 

#Simple Linear Regression 
##always plot the data
windows(7,7)

pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/HW05.pdf")

plot(lpsa ~ lcavol,data=prostate)

#fit a straight line (least squares line) through the data
lmod <- lm(lpsa ~ lcavol,data=prostate)
abline(lmod)

summary(lmod)  #we are interested in the test of slope:  H0: slope=0   H1: slope not equal to 0
#When p is low (<0.05) then H0 must go
anova(lmod)

head(residuals(lmod))   #prints out the first six residuals 
describe(residuals(lmod)) #obtain summary statistics on the residuals

ggplot(data=prostate,aes(x=residuals(lmod))) + geom_histogram(aes(y =..density..), 
      breaks=seq(-1.5, 2, by = .5), 
      col="red", 
      fill="blue", 
      alpha = .2) + geom_density(col="red") + 
  labs(title="Histogram for residuals from lpsa ~ lcavol") +
  labs(x="residual", y="Count")

dev.off()

##-------------------------------------------------------------##

#HW06
#Exercise #1 on page 30 of the text.  Do only parts a, b, c, d, e.

describe(teengamb)

lmod <- lm(gamble ~ sex+status+income+verbal,data=teengamb)
summary(lmod)
anova(lmod)

max_ei=sort(lmod$residuals)
sum(max_ei) #residuals should sum to 0
tail(max_ei,n=6L)  #shows the six largest observations including their case number
head(max_ei,n=6L)  #shows the six smallest observations including their case number

describe(max_ei)  #shows mean and median of residuals along with other descriptive statistics

r1 <- cor(predict(lmod),teengamb$gamble)  #correlation yhat with yi  this is the Hint you were given
r1
r1^2  #this should be R^2 from the model

r2 <- cor(residuals(lmod),predict(lmod))  #correlation ei with yihat
r2    #this should be 0

rincome <- cor(residuals(lmod),teengamb$income)  #correlation ei with income
rincome

#look at correlation of residuals with all other predictors
rsex <- cor(residuals(lmod),teengamb$sex)  #correlation ei with sex
rsex

rstatus <- cor(residuals(lmod),teengamb$status)  #correlation ei with status
rstatus

rverbal <- cor(residuals(lmod),teengamb$verbal)  #correlation ei with verbal
rverbal

##-------------------------------------------------------------##

#HW07 Exercise #4 on page 30.
#You only need to show the summary output for each model, no need to do any plotting as requested in the exercise.
describe(prostate)

lmod1 <- lm(lpsa ~ lcavol,data=prostate)
lmod2 <- lm(lpsa ~ lcavol+lweight,data=prostate)
lmod3 <- lm(lpsa ~ lcavol+lweight+svi,data=prostate)
lmod4 <- lm(lpsa ~ lcavol+lweight+svi+lbph,data=prostate)
lmod5 <- lm(lpsa ~ lcavol+lweight+svi+lbph+age,data=prostate)
lmod6 <- lm(lpsa ~ lcavol+lweight+svi+lbph+age+lcp,data=prostate)
lmod7 <- lm(lpsa ~ lcavol+lweight+svi+lbph+age+lcp+pgg45,data=prostate)
lmod8 <- lm(lpsa ~ lcavol+lweight+svi+lbph+age+lcp+pgg45+gleason,data=prostate)

summary(lmod1)
summary(lmod2)
summary(lmod3)
summary(lmod4)
summary(lmod5)
summary(lmod6)
summary(lmod7)
summary(lmod8)

##residual standard errors for models 1-8
#(1)0.7875 (2)0.7506 (3)0.7168 (4)0.7108 (5)0.7073 (6)0.7102 (7)0.7048 (8)0.7084

##R^2 for models 1-8
#(1)0.5394 (2)0.5859 (3)0.6264 (4)0.6366 (5)0.6441 (6)0.6451 (7)0.6544 (8)0.6548

anova(lmod8)  
#note SSR(lcavol) + SSR(lweight|lcavol) +     + SSR(gleason|lcavol lweight svi lbph age lcp pgg45) = 83.754 = SSR
#SSTO = SSR + SSE = 83.754 + 44.163 = 127.917

##-------------------------------------------------------------##

#HW08 
set.seed(15324)

#Perform an OLS regression of stackloss on the 3 predictors in the data set and obtain 95% CIs on the regression coefficients.
#Perform a  LAD regression of stackloss on the 3 predictors in the data set and obtain 95% bootstrapped CIs on the regression coefficients.

describe(stackloss)  #note n=21

#fit the OLS model
lmod <- lm(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)
summary(lmod)
confint(lmod)

  #set the seed for random number generation that is used
#fit the LAD model - minimize the sum of the absolute values of (data - fit) |yi - yhati|

#note the rq function generates the LAD results
LADmodel <- rq(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)  
summary(LADmodel)

#use bootstrapping to obtain the confidence intervals

bcoef <- matrix(0,1000,4)  #generate a 1000 by 4 matrix of 0s which will be populated with the bootstrap regression results
head(bcoef)

for(i in 1:1000){
newy <- predict(LADmodel) + residuals(LADmodel)[sample(21,rep=TRUE)]  #take a sample of size n=21 of residuals and generate new y values
brg <- rq(newy  ~ Air.Flow + Water.Temp + Acid.Conc., data= stackloss)
bcoef[i,] <- brg$coef
}

colnames(bcoef) <- names(coef(LADmodel))

bcoef <- data.frame(bcoef)
head(bcoef) #prints out the first 6 observations 

apply(bcoef,2,function(x) quantile(x, c(0.025,0.975)))

confint(lmod)

##-------------------------------------------------------------##

#HW09 Use "happy" data set in Faraway library and perform permutation test applied to B4 a single coefficient in Linear Regression
#See text starting on the bottom of page 41 for procedure and code.

set.seed(12345)

data(happy)
head(happy)
lmod <- lm(happy ~ money + sex + love + work, data=happy)
summary(lmod)
summary(lmod)$coefficients[5,3] #extracts the t-statistic you need for "work"

#Now perform 5000 permutations of "work"

#perform permuation test by permuting the "work" observations
#note there are 39! permutations of the "work" vector
factorial39 <- factorial(39)  #factorial(x) computes the factorial of x
factorial39

#so, try sampling among the many permutations
nreps <- 5000
vector_tB4 <- numeric(nreps)
head(vector_tB4)

for (i in 1:nreps) {
lmod_work_permuted <- lm(happy ~ money + sex + love + sample(work,rep=FALSE), data=happy)
#the sampling is without replacement
vector_tB4[i] <- summary(lmod_work_permuted)$coefficients[5,3]
}

head(abs(vector_tB4) > abs(summary(lmod)$coefficients[5,3]),100L) #show the first 100 results

mean(abs(vector_tB4) > abs(summary(lmod)$coefficients[5,3]))  #obtain the permutation test p-value for H0:B4=0

summary(lmod)$coefficients[5,4]  #p-value from the OLS approach


