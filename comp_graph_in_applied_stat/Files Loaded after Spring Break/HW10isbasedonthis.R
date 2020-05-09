#The package olsrr in R performs model selection method
#See the manual at https://cran.r-project.org/web/packages/olsrr/olsrr.pdf 
#See an example at https://cran.r-project.org/web/packages/olsrr/vignettes/variable_selection.html

#R code to demonstrate Variable Selection: stepwise and all possible
#will perform stepwise (forward, backward, stepwise)
#and all possible regressions  k=7 so 2**7 = 128 possible regressions

#this site below has a useful tutorial on Variable Selection in R
#https://rpubs.com/davoodastaraky/subset

if (FALSE)
{"
Measuring body fat is not so simple.  Hydrostatic underwater weighing is a method of determining body composition (body fat to lean mass).
Obtain a person's total body density by submerging the body underwater in a tank and measuring the displacement.
Considered the gold standard for body composition assessment. More sophisticated methods may make underwater weighing obsolete in the near future.
n=252 men  - Brozek's equation was applied to each man's hydrostatic underwater weighing results to accurately estimate their percentage of body fat.
"}

library(faraway)  #this command brings in a library of regression functions

#install.packages("olsrr")  #install olsrr if package has not been installed on your computer
#Because R is developed by an open source community, it is not uncommon
# that multiple packages may use the same name for a function or dataset.
# If you load packages that use the same name for an object, R will warn
# that certain object(s) have been “masked”.
require(olsrr)

data(fat,package="faraway")
#Can we predict body fat using only easy-to-record measurements?

#full model
 lmod <- lm(brozek ~ age + weight + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)

x <- model.matrix(lmod)
head(x)
head(fat$brozek)

#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 11 25Feb2020/ModelSelectionExample.pdf")

#all possible regressions
#note there are 13 variables in the Full Model  2^13 = 8192 possible regressions

#you may need to install leaps if you do not have this package on your computer 
#install.packages("leaps") 

require(leaps) #be sure to bring in the package leaps into your current session
#help(leaps) #performs all-subsets regression

##Example showing adjusted R2 and R2 for Full Model 
full <- regsubsets(brozek ~ age + weight + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist,nbest=5, nvmax=13,data=fat,intercept=TRUE)
summary.full <- summary(full)
summary.full

names(summary.full)  #shows what measures are available

summary.full$rsq #note the increase in R2 as variables are entered into model
summary.full$adjr2  #note the decrease in the last adjr2

k <- ols_step_all_possible(lmod)
k
plot(k)

#best subset regregression
k <- ols_step_best_subset(lmod,print_plot = TRUE)
k
plot(k)

#Selection criteria output - focus on the criteria starting with ##
##rsquare rsquare of the model
##adjr adjusted rsquare of the model
##predrsq predicted rsquare of the model
##cp mallow’s Cp
##aic akaike information criteria
#sbic sawa bayesian information criteria
##sbc schwarz bayes information criteria
##gmsep estimated MSE of prediction, assuming multivariate normality

#jp final prediction error
#pc amemiya prediction criteria
#sp hocking’s Sp

#Stepwise Forward Regression
#Build regression model from a set of candidate predictor variables
# by entering predictors based on p values, in a stepwise manner until there
# is no variable left to enter any more. The model should include all
# the candidate predictor variables. 
#If details is set to TRUE, each step is displayed.

k <- ols_step_forward_p(lmod,details=TRUE)
k
plot(k)

#Stepwise Backward Regression
#Build regression model from a set of candidate predictor variables by removing predictors
# based on p values, in a stepwise manner until there is no variable left to remove any more.
# The model should include all the candidate predictor variables.
#If details is set to TRUE, each step is displayed.

k <- ols_step_backward_p(lmod,details=TRUE)
k
plot(k)

#Stepwise Regression
#Build regression model from a set of candidate predictor variables by entering and removing predictors
# based on p values, in a stepwise manner until there is no variable left to enter or remove any more.
# The model should include all the candidate predictor variables.
#If details is set to TRUE, each step is displayed.

k <- ols_step_both_p(lmod,details=TRUE)
k
plot(k)

#Stepwise models based on Akaike Information Criteria criterion
k <- ols_step_forward_aic(lmod) #forward selection
k
plot(k)

k <- ols_step_backward_aic(lmod)
k
plot(k)

k <- ols_step_both_aic(lmod)
k
plot(k)

dev.off()






