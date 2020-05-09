#There are a few R packages that perform variable selection methods.  Here is a recently released on that generates readable output.
#See the manual at https://cran.r-project.org/web/packages/olsrr/olsrr.pdf 
#See an example at https://cran.r-project.org/web/packages/olsrr/vignettes/variable_selection.html

#R code to demonstrate Variable Selection: stepwise and all possible
#will perform stepwise (forward, backward, stepwise)
#and all possible regressions  k=6 so 2**6 = 64 possible regressions

#this site below has a useful tutorial on Variable Selection in R
#https://rpubs.com/davoodastaraky/subset

library(faraway)  #this command brings in a library of regression functions

#install.packages("olsrr")  #install olsrr if package has not been installed on your computer
#Because R is developed by an open source community, it is not uncommon
# that multiple packages may use the same name for a function or dataset.
# If you load packages that use the same name for an object, R will warn
# that certain object(s) have been “masked”.

library(olsrr)
#The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption
# and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

data(mtcars)

if (FALSE)
{"
A data frame with 32 observations on 11 (numeric) variables.
[, 1]	mpg	Miles/(US) gallon
[, 2]	cyl	Number of cylinders
[, 3]	disp	Displacement (cu.in.)
[, 4]	hp	Gross horsepower
[, 5]	drat	Rear axle ratio
[, 6]	wt	Weight (1000 lbs)
[, 7]	qsec	1/4 mile time
[, 8]	vs	Engine (0 = V-shaped, 1 = straight)
[, 9]	am	Transmission (0 = automatic, 1 = manual)
[,10]	gear	Number of forward gears
[,11]	carb	Number of carburetors
"}
mtcars

#with n=32 use only k=6 candidate variables
lmod <- lm(mpg ~ cyl + disp + hp + drat + wt + qsec,data=mtcars)  

#save graph in pdf
windows(7,7)
# pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 11 25Feb2020/Example_olsrr_Figure.pdf")

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
##msep estimated MSE of prediction, assuming multivariate normality

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

#dev.off()






