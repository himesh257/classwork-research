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

#The errors have same but unknown variance (homoscedasticity assumption).

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Output/Diag_more_QUASAR_R_out.pdf")

library(stats)
summary(influence.out <- influence.measures(lmod))
influence.out

library(olsrr)
#Scatter plot of residuals on the y axis and fitted values on the x axis to detect non-linearity, unequal error variances, and outliers.
#Characteristics of a well behaved residual vs fitted plot:
   #The residuals spread randomly around the 0 line indicating that the relationship is linear.
   #The residuals form an approximate horizontal band around the 0 line indicating homogeneity of error variance.
   #No one residual is visibly away from the random pattern of the residuals indicating that there are no outliers.

library(car)
ols_plot_resid_fit(lmod)

# if robust.line=FALSE then OLS line is drawn; if smooth=TRUE then a loess line is drawn 
spreadLevelPlot(lmod,robust.line=FALSE,grid=TRUE,smooth=TRUE)

#Plot for detecting outliers. Studentized deleted residuals (or externally studentized residuals) is the deleted
#residual divided by its estimated standard deviation. Studentized residuals are going to be more effective for
#detecting outlying Y observations than standardized residuals. If an observation has an externally studentized
#residual that is larger than 3 (in absolute value) we can call it an outlier.
ols_plot_resid_stud(lmod)

#Standardized residual (internally studentized) is the residual
# divided by estimated standard deviation sqrt(MSE).
# Rule of thumb:  look for absolute value of Standardized residual >= 2
ols_plot_resid_stand(lmod)

#Studentized Residuals vs Leverage Plot
#Graph for detecting outliers without leverage and outliers with leverage
ols_plot_resid_lev(lmod)

#Deleted Studentized Residual vs Fitted Values Plot
# Rule of thumb:  look for absolute value of Studentized Residual >= 3
ols_plot_resid_stud_fit(lmod)

#Cook's D
# Rule of thumb:  look for values >= 4/n  4/25=0.16
ols_plot_cooksd_chart(lmod)

#DFBETAS
# Rule of thumb:  look for values >= 2/sqrt(n)  2/(25^.5) = 0.4
ols_plot_dfbetas(lmod)

#DFFITS
# Rule of thumb:  look for values >= 2*sqrt(p/n)   2*((5/25)^.5) = 0.89
ols_plot_dffits(lmod)

#COVRATIO
# Rule of thumb: look for values >= 1 + (3p/n) or <= 1 - (3p/n)
# if COVRATIO for an obs < 1 the ith obs improves the precision
# if COVRATIO for an obs > 1 the ith obs degrades the precision

covratio(lmod)

library(stats)
influence.out
summary(influence.out <- influence.measures(lmod))

#HADI PLOT
#Potential function (hii/1-hii) 
#Residual function (  (p/(1-hii)) * (di^2/(1-di^2))  ) where di=ei/sqrt(SSE)
#Plot Potential function + Residual Function for each observation
# Rule of thumb:  look for observations that are large compared to all other observations
ols_plot_hadi(lmod)

#POTENTIAL-RESIDUAL PLOT
#Plot Potential function on Y-axis versus Residual function on X-axis
#Look for points that are large both on the Y-axis (Potential) and the X-axis (Residual)
#That is, look in the upper right-hand corner of the plot 
ols_plot_resid_pot(lmod)

##------------------------------------------------------------------##

dev.off()

