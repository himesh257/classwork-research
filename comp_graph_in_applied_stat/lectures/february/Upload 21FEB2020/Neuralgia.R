#Multiple Logistic Regression in R
if (FALSE)
{"
Consider a study of the analgesic effects of treatments on elderly patients with neuralgia.
Two test treatments and a placebo are compared. The response variable is whether the patient reported pain or not.
Researchers recorded the age and gender of 60 patients and the duration of complaint before the treatment began.
Treatment = A and B represent the two test treatments and P represents the placebo treatment
Duration = duration of complaint (months) before treatment
Pain is the response variable 0=No Pain, 1=Pain
"}

#first an explanation of deviance and saturated model
#a saturated model is defined as one where the number of parameters is equal to the number of distinct covariate patterns.
#Deviance is defined as -2*ln[likelihood of fitted model/likelihood of the saturated model]
#In logistic regression the likelihood of the saturated model is equal to 1
#In a saturated model pihat = yi so likelihood[product of pihat ^ yi x (1-pihat)^(1-yi)]
#is equal to likelihood[product of yi^yi x (1-yi)^(1-yi)] which is equal to 1.
#therefore, deviance is defined as -2*ln[likelihood of the fitted model]

#read in the data which is in a csv file
neuralgia <- read.csv("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 10 21FEB2020/Neuralgia.csv",header = TRUE)
neuralgia
summary(neuralgia)

#generate tables for categorical variables  - similar to scatter plots for continuous y
table1 <- with(neuralgia, table(Pain,Treatment))
table1
with(neuralgia, prop.table(table1))     #cell percentages
with(neuralgia, prop.table(table1,1))   #row percentages
with(neuralgia, prop.table(table1,2))   #column percentages

table2 <- with(neuralgia, table(Pain,Sex))
table2
with(neuralgia, prop.table(table2,2)) 

logistic <- glm(Pain ~ Treatment + Sex + Age + Duration, family=binomial(logit), data=neuralgia)
summary(logistic) 
anova(logistic, test="Chisq") 

#install.packages("aod") #install if not already installed
library(aod)
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=1,verbose=TRUE)
if (FALSE)
{"
The Wald test statistic is a generalization of a t or z statistic.
It is a function of the difference in the MLE and its hypothesized value, normalized by an 
estimate of the standard deviation of the MLE.
For large enough n, Wald statistic is chi-squared with 1 df
"}

check<- -20.5883/sqrt(50.45095)
check^2
 
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=2,verbose=TRUE) 

wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=3,verbose=TRUE) 

wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=4,verbose=TRUE) 

wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=5,verbose=TRUE) 

drop1(logistic,test="Chisq",trace=TRUE)  #none in table indicates no variables dropped
drop1(logistic,test="LRT")

#duration was dropped
logistic1 <- glm(Pain ~ Treatment + Sex + Age, family=binomial(logit), data=neuralgia)
drop1(logistic1,test="Chisq",trace=TRUE)
logistic1

add1(logistic1,scope= ~ Treatment + Sex + Age + Duration,test="LRT",trace=TRUE)
add1(logistic1,scope= ~ . + Duration,test="LRT",trace=TRUE)  #the perioid means what is currently in the model

#install.packages("lmtest") #install package if not already installed
logisticfull <- glm(Pain ~ Treatment + Sex + Age +Duration, family=binomial(logit), data=neuralgia)
library(lmtest)
lrtest(logistic1,logisticfull)







