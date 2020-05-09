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
#A subset of 9 variables was selected from the 13 variables in the full dataset  2^13 = 8192 possible regressions  2^9 = 512

lmod <- lm(brozek ~ weight + height + chest + abdom + knee + ankle + biceps + forearm + wrist, data=fat)

x <- model.matrix(lmod)
head(x)
head(fat$brozek)

#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 16 24Mar2020/FatModelSelection_Graph.pdf")

#best subset regregression
k <- ols_step_best_subset(lmod,print_plot = TRUE)
k
plot(k)

#all possible regressions

#all possible regressions
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






