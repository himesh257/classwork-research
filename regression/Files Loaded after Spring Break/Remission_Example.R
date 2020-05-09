#Multiple Logistic Regression in R
if (FALSE)
{"
The data, taken from Lee (1974), consist of patient characteristics and
whether or not cancer remission occurred, and are saved in the data set
Remission. The variable remiss is the cancer remission indicator variable
with a value of 1 for remission and a value of 0 for nonremission.  The other
six variables are the risk factors thought to be related to cancer remission.
"}

#first an explanation of deviance and saturated model
#a saturated model is defined as one where the number of parameters is equal to the number of distinct covariate patterns.
#Deviance is defined as -2*ln[likelihood of fitted model/likelihood of the saturated model]
#In logistic regression the likelihood of the saturated model is equal to 1
#In a saturated model pihat = yi so likelihood[product of pihat ^ yi x (1-pihat)^(1-yi)]
#is equal to likelihood[product of yi^yi x (1-yi)^(1-yi)] which is equal to 1.
#therefore, deviance is defined as -2*ln[likelihood of the fitted model]

#read in the data which is in a csv file
remission <- read.csv("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 11 07APR2020/remission.csv",header = TRUE)
remission
summary(remission)

logistic <- glm(remiss ~ cell + smear + infil + li + blast + temp, family=binomial(logit), data=remission)
summary(logistic) 
anova(logistic, test="Chisq") 

#easier summary
library(epiDisplay)
logistic.display(logistic)  #check  AIC=2*abs.value(LL) + 2*p

#now save the graph in a pdf file
 pdf(file="C:/users/jmard/Desktop/RegressionMethodsSpring2020/Output/Remission_ExampleR_Figure.pdf")

library(pROC)
#generate ROC curve
ROCresult <- roc(remission$remiss ~ logistic$fitted)
plot(ROCresult, legacy.axes = TRUE)
names(ROCresult)
ROCresult$auc

#obtain the odds ratios for each coefficient
exp(coef(logistic))

#obtain the percentage change in odds (pi/(1-pi)) for every
# 1-unit increase in Xi, holding all other X's fixed
(exp(coef(logistic)) - 1) * 100
##-----------------------##

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

check <- 24.66/sqrt(2288.4)  #check Wald for cell coefficient
check^2
 
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=2,verbose=TRUE) #H0 B(cell) = 0
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=3,verbose=TRUE) 
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=4,verbose=TRUE) 
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=5,verbose=TRUE) 
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=6,verbose=TRUE)
wald.test(b = coef(logistic), Sigma = vcov(logistic),Terms=7,verbose=TRUE)

library(lmtest)
#Likelihood Ratio Test for H0: B(li)=0  #write model without li
logistic1 <- glm(remiss ~ cell + smear + infil + blast + temp, family=binomial(logit), data=remission)
lrtest(logistic1,logistic)  #different than Wald p-value

#Likelihood Ratio Test for H0: all B's except B(li) are equal to 0  #write model with li
logistic2 <- glm(remiss ~ li , family=binomial(logit), data=remission)
lrtest(logistic2,logistic) ##Do not reject HO !

#Likelihood Ratio Test for H0: B(cell) = B(smear)
logistic3 <- glm(remiss ~ I(cell + smear) + infil + li + blast + temp , family=binomial(logit), data=remission)
lrtest(logistic3,logistic) ##Do not reject HO !


dev.off()
