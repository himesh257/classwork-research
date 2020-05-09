if (FALSE) 
{"
Least absolute deviation (LAD) regression is an alternative to ordinary least squares (OLS) regression
that has greater power for thick-tailed symmetric and asymmetric error distributions (Cade and Richards 1996).
LAD regression estimates the conditional median (a conditional 0.50 quantile) of a dependent variable given
the independent variable(s) by minimizing sums of absolute deviations between observed
and predicted values. LAD regression can be used anywhere OLS regression would be used but is often more
desirable because it is less sensitive to outlying data points and is more efficient
for skewed error distributions as well as some symmetric error distributions.
"}  

#install.packages("quantreg") #need to install this package if it is not already installed

library(faraway)

e_ols <- function(x) (x^2)
e_lad <- function(x) (abs(x))
curve(e_ols,-3.5,3.5,n=100,col='red',lwd=4,xlab="Scaled (ei/sigma) residual value",ylab="Value of f(residual)")
curve(e_lad,-3.5,3.5,n=100,col='blue',lwd=4,add=TRUE)

