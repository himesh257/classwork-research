library(faraway)  #this command brings in a library of regression functions
library(psych)

#Use the QUASARS dataset from the textbook to examine residuals (data - fit)

#read in the data which is in a csv file
quasars <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

# n=25 observations on 5 independent variables (covariates) 
# REDSHIFT (x1) LINEFLUX(x2) LUMINOSITY(x3) AB1450(x4) ABSMAG(x5) 
# and a response RFEWIDTH (y)
quasars

#Peform a multiple regression using the quasar data
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)

##------------------------------------------------------------------## 

#olsrr offers tools for detecting violation of standard regression assumptions. 

#The error has a normal distribution (normality assumption).
#The errors have mean zero.
#The errors have same but unknown variance (homoscedasticity assumption).
#The error are independent of each other (independent errors assumption).

windows(7,7)
#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 07 03Mar2020/Diag_olsrr_QUASAR_R_out.pdf")

library(olsrr)
#Graph for detecting violation of normality assumption.
ols_plot_resid_qq(lmod)

#Test for detecting violation of normality assumption.
ols_test_normality(lmod)

#Correlation between observed residuals and expected residuals under normality.
ols_test_correlation(lmod)

#Scatter plot of residuals on the y axis and fitted values on the x axis to detect non-linearity, unequal error variances, and outliers.
#Characteristics of a well behaved residual vs fitted plot:
   #The residuals spread randomly around the 0 line indicating that the relationship is linear.
   #The residuals form an approximate horizontal band around the 0 line indicating homogeneity of error variance.
   #No one residual is visibly away from the random pattern of the residuals indicating that there are no outliers.
ols_plot_resid_fit(lmod)

#Histogram of residuals for detecting violation of normality assumption
ols_plot_resid_hist(lmod)

#Example of a plot for nonlinearity (linear fit x or add in quadratic term x^2)
set.seed(12534)
n <- 50
e <- rnorm(n, m=0, sd=2)

x1 <-  runif(n,min=0,max=3)
y <- 1 + 1*x1 + 5*x1^2 + e

lmod_simx1 <- lm(y~x1)
ols_plot_resid_fit(lmod_simx1)  #1st order in x fit

lmod_sim <- lm(y~x1+I(x1^2))
summary(lmod_sim)
confint(lmod_sim)
ols_plot_resid_fit(lmod_sim)  #2nd order in x fit

##------------------------------------------------------------------##