#Multiple Logistic Regression in R

#install packages as needed
library(faraway)
library(psych)
library(MASS)
library(StepReg)
require(caret)
library(aod)

#Akaike information criterion: AIC = 2p + 2*abs.value(Log Likelihood)
# where p = number of parameters

if (FALSE)
{"
The goal of this study was to identify risk factors associated with
giving birth to a low birth weight baby (weighing less than 2500 grams).
Data were collected on 189 women, 59 of which had low birth weight babies
and 130 of which had normal birth weight babies.  
low(0,1) = low birthweight=(no,yes)
age=age(year) of mother at delivery
lwt=weight(lb) at last menstrual period
race(0,1) = race(white,nonwhite)
smoke(0,1) = smoked during pregnancy(no,yes)
ptl(0,1) = history of premature labor(no,yes)
ht(0,1) = history of hypertension(no,yes)
ftv=# of physician visits during first trimester
--------------------------------------------------------
SOURCE:  Hosmer and Lemeshow (2000) Applied Logistic Regression: Second 
	Edition.  These data are copyrighted by John Wiley & Sons Inc. and must 
	be acknowledged and used accordingly. Data were collected at Baystate
	Medical Center, Springfield, Massachusetts during 1986.
--------------------------------------------------------
"}

#first an explanation of deviance and saturated model
#a saturated model is defined as one where the number of parameters is equal to the number of distinct covariate patterns.
#Deviance is defined as -2*ln[likelihood of fitted model/likelihood of the saturated model]
#In logistic regression the likelihood of the saturated model is equal to 1
#In a saturated model pihat = yi so likelihood[product of pihat ^ yi x (1-pihat)^(1-yi)]
#is equal to likelihood[product of yi^yi x (1-yi)^(1-yi)] which is equal to 1.
#therefore, deviance is defined as -2*ln[likelihood of the fitted model]

#read in the data which is in a csv file
lowbirth <- read.csv("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 11 07APR2020/lowbirth.csv",header = TRUE)
lowbirth$low <- as.numeric(lowbirth$low)

lowbirth
str(lowbirth)
describe(lowbirth)

set.seed(1324)
logistic <- glm(low ~ age + lwt + race + smoke + ptl + ht + ftv,family=binomial(logit),data=lowbirth)
summary(logistic)

## Easier view
logistic.display(logistic)

#note: a crude odds ratio is just an odds ratio of one independent variable for predicting the response.
#The adjusted odds ratio holds other relevant variables constant and provides the odds ratio for the potential variable
# of interest which is adjusted for the other independent variables included in the model.

#For Logistic Regression:
#Akaike information criterion: AIC = 2p + 2*abs.value(Log Likelihood)
# where p = number of parameters

# Also, Residual Deviance of a Model is equal to 2*abs(Log Likelihood of the Model)

#Check AIC computation for Full model  p=8
##AIC (Full Model) = Residual Deviance of Full Model + 2p   = 199.52 + 2*8 = 215.52
##Log Likelihood of Full Model = -(Residual Deviance/2)  =  -199.52/2 = - 99.76 

anova(logistic, test="Chisq")

y<- "low"
stepwiselogit(data=lowbirth,y, exclude = NULL, include = NULL, selection = "forward",
select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=lowbirth,y, exclude = NULL, include = NULL, selection = "backward",
select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=lowbirth,y, exclude = NULL, include = NULL, selection = "bidirection",
select = "AIC", sle = 0.15, sls = 0.15)

logistic.display(logistic)
#obtain the percentage change in odds (pi/(1-pi)) for every
# 1-unit increase in Xi, holding all other X's fixed
(exp(coef(logistic)) - 1) * 100
##-----------------------##


