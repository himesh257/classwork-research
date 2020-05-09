library(faraway)  #this command brings in a library of regression functions
library(psych)
library(stats)
library(olsrr)
library(car)

#Use the QUASARS dataset from the textbook to examine e(i) where
#e(i) is [Yi - Yhat(i)] where Yhat(i) is Yhat at xi with the ith observation deleted

#read in the data which is in a csv file
quasars <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

# n=25 observations on 5 independent variables (covariates) and a response Y=RFEWIDTH 

#Peform a multiple regression using the quasar data with only two predictors: LINEFLUX and AB1450
LMOD <- lm(RFEWIDTH ~ LINEFLUX + AB1450,data=quasars)
summary(LMOD)
 
windows(7,7)
#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Output/ei_QUASAR_R_out.pdf")

#Studentized Residuals vs Leverage Plot
#Graph for detecting outliers without leverage and outliers with leverage
ols_plot_resid_lev(LMOD)

#HADI PLOT
#Potential function (hii/1-hii) 
#Residual function (  (p/(1-hii)) * (di^2/(1-di^2))  ) where di=ei/sqrt(SSE)
#Plot Potential function + Residual Function for each observation
# Rule of thumb:  look for observations that are large compared to all other observations
ols_plot_hadi(LMOD)

##------------------------------------------------------------------##

all_obs <- data.frame(cbind(quasars$LINEFLUX,quasars$AB1450,quasars$RFEWIDTH,LMOD$fitted.values,LMOD$residuals))

names(all_obs) <- c("LINEFLUX","AB1450","RFEWIDTH","Yhat_all","ei_all")
head(all_obs,10L)  #note the values for the row corresponding to observation #8

#Now set RFEWIDTH for observation #8 to missing which excludes the observation from all regression computations.
all_obs[8,3] <- NA
head(all_obs,10L)

#Fit the regression model with observation #8 missing
LMODwo8 <- lm(RFEWIDTH ~ LINEFLUX + AB1450,data=all_obs)
summary(LMODwo8)

LMODwo8$fitted  #note the missing fitted value for observation #8.  We obtain the fit at observation #8 below.

x_at_8 <- data.frame(LINEFLUX=-13.5,AB1450=20.41)

fit_at_8_wo8 <- predict(LMODwo8,newdata = x_at_8)
fit_at_8_wo8

quasars[8, ] #print the 8th row of quasars

e_at_8_wo8 <- quasars[8,7] - fit_at_8_wo8
e_at_8_wo8
 
check <- 259 - (880.501 + (157.423*-13.5) + (69.848*20.41))  #RFEWIDTH at obs 8 - Fit at obs 8
check

LMOD$residuals
LMODwo8$residuals


















dev.off()

