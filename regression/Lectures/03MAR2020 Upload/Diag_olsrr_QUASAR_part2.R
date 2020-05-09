library(faraway)  #this command brings in a library of regression functions
library(psych)
library(olsrr)

#Use the QUASARS dataset from the textbook to examine residuals (data - fit)

#read in the data which is in a csv file
quasars <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

# n=25 observations on 5 independent variables (covariates) 
# REDSHIFT (x1) LINEFLUX(x2) LUMINOSITY(x3) AB1450(x4) ABSMAG(x5) 
# and a response RFEWIDTH (y)
quasars

#Peform a multiple regression using the quasar data
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)

windows(7,7)
#save graph in pdf
# pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 07 03Mar2020/Diag_olsrr_QUASAR_part2_R_out.pdf")

##------------------------------------------------------------------## 
#Plot for detecting outliers. Studentized deleted residuals (or externally studentized residuals) is the deleted
#residual divided by its estimated standard deviation. Studentized residuals are going to be more effective for
#detecting outlying Y observations than standardized residuals. If an observation has an externally studentized
#residual that is larger than 3 (in absolute value) we can call it an outlier.
ols_plot_resid_stud(lmod)

#Standardized residual (internally studentized) is the residual
# divided by estimated standard deviation.
ols_plot_resid_stand(lmod)

#Studentized Residuals vs Leverage Plot
#Graph for detecting influential observations
ols_plot_resid_lev(lmod)

#Deleted Studentized Residual vs Fitted Values Plot
ols_plot_resid_stud_fit(lmod)

#Cook's D
 ols_plot_cooksd_chart(lmod)

#DFBETAS
 ols_plot_dfbetas(lmod)

#DFFITS
ols_plot_dffits(lmod)

#ols_plot_hadi(lmod)

#ols_plot_resid_pot(lmod)

##-------------------------------------------------##
dev.off()
