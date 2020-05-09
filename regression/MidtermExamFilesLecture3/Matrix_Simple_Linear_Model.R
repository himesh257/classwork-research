library(faraway)

#Matrix approach to Simple Linear Model
#Experiment: 4 rats were injected with a dose(mcg) of a drug.  
#The time (minute) to run a maze was recorded for each rat.
# x=dose y=time


dose=c(0, 2, 4, 6)
y=c(7, 5, 4, 4)


X=as.matrix(cbind(1,dose))
X  #this is what the X-matrix looks like

y  #this is what the vector of y responses looks like

#create a data frame named "example" for later use
example <- data.frame(dose,y)
example 

XtX <- t(X) %*% X
XtX #show XtX - should be a 2x2 symmetric matrix about the diagonal

XtXi <- solve(t(X) %*% X)  #compute XtX inverse
XtXi #show XtX inverse
 

I2 <- XtX %*% XtXi
I2 #should get back the Identity (2x2) matrix


Xty <- t(X) %*% y 
Xty 


Bhat <- XtXi %*% t(X) %*% y   #Beta hat is equal to (X'X)inverse * X'y
Bhat


#compute the standard errors of Beta hat which can be found by taking
#the square root of the diagonal elements of the matrix XtXi * sigma_hat


mod <- lm(y ~ dose, data=example)
modsum <- summary(mod)
modsum #check to be sure the matrix computations agree with the output from R


sigma_hat=sqrt(deviance(mod)/df.residual(mod)) #compute the estimate of sigma
sigma_hat


sigma_hat_of_Beta_hat=sqrt(diag(XtXi))*sigma_hat
sigma_hat_of_Beta_hat


#done