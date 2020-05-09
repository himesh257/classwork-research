library(faraway)  #this command brings in a library of regression functions

#Exercise 4.96 (quasars), page 254, 8th edition which is Exercise 4.11, page 186 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex496 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

# n=25 observations on 5 independent variables (covariates) 
# REDSHIFT (x1) LINEFLUX(x2) LUMINOSITY(x3) AB1450(x4) ABSMAG(x5) 
# and a response RFEWIDTH (y)
ex496

windows(7,7)
#save graph in pdf
pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/Ex4_96_p254R_out.pdf")
#plot the data - generate a basic scatter plot matrix
pairs( ~ RFEWIDTH+REDSHIFT+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)

#Peform a multiple regression using the quasar data
lmod1 <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)

summary(lmod1)
anova(lmod1)

#Peform a multiple regression using the quasar data but changing the order of the Xs 
lmod2 <- lm(RFEWIDTH ~ ABSMAG+REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=ex496)

summary(lmod2)
anova(lmod2)

#explanation SSR(ABSMAG) SSR(REDSHIFT|ABSMAG) SSR(LINEFLUX|ABSMAG,REDSHIFT)
#  . . . SSR(AB1450|ABSMAG,REDSHIFT,LINEFLUX,LUMINOSITY)   more to come on this topic

#BACK TO FOCUS ON lmod1 and the questions in ex4.96
#state fitted model
#interpret the Beta coefficients in the model
# Answer:  Change in y per unit change of REDSHIFT given all other Xs are held constant
# pvalue for REDSHIFT = ?
# R2 = ?  R2adjusted=?
# We will cover testing H0: B1=B2=B3=B4=0  see Section 4.13 A Test for Comparing Nested Models

#extract X matrix from lmod1
x <- model.matrix( ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)  
x

#note the column of 1s in the X matrix:
#  RFEWIDTH ~ B0*1 + B1*REDSHIFT+ B2*LINEFLUX+ B3*LUMINOSITY+ B4*AB1450+ B5*ABSMAG + error

#extract y vector
y <- ex496$RFEWIDTH
y

xtx <- (t(x) %*% x)
xtx

xtxi <- solve(t(x) %*% x)
xtxi

betahat <- xtxi %*% t(x) %*% y
betahat

#another way of obtaining betahat
solve(crossprod(x,x),crossprod(x,y))

names(lmod1)

lmodsum <- summary(lmod1)
names(lmodsum)

lmodsum$residuals

lmodsum$call

sqrt(deviance(lmod1)/df.residual(lmod1))  #square root of SSE/(df of SSE)
lmodsum$sigma #confirm the number above

xtxi <- lmodsum$cov.unscaled  #find the diagonal elements of inverse of (X'X)

sqrt(diag(xtxi))*15.81067   #multiply the square root of each diagonal element of the inverse of (X'X) by sigma_hat

#obtain the estimated standard deviations (standard errors) of the beta coefficients
lmodsum$coef[,2]  #note the use of [ and ] to distinguish from a function that uses ( and )

##--LEAST SQUARES IS ELEGANT--------------------------------------------##

