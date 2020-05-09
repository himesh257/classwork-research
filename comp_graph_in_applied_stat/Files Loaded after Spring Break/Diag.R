library(faraway)  #this command brings in a library of regression functions
library(psych)
library(stats)
library(olsrr)
library(car)

#Basic Regression Diagnostics from R

#Focus attention on only Area and Adjacent from Gala data
lmod <- lm(Species ~ Area + Adjacent,data=gala)
summary(lmod)

##------------------------------------------------------------------## 

#olsrr offers tools for detecting violation of standard regression assumptions. 

#The error has a normal distribution (normality assumption).
#The errors have mean zero.
#The errors have same but unknown variance (homoscedasticity assumption).
#The error are independent of each other (independent errors assumption).

windows(7,7)
#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/Diag_Figure.pdf")

#Graph for detecting violation of normality assumption.
ols_plot_resid_qq(lmod)

#Scatter plot of residuals on the y axis and fitted values on the x axis to detect non-linearity, unequal error variances, and outliers.
#Characteristics of a well behaved residual vs fitted plot:
   #The residuals spread randomly around the 0 line indicating that the relationship is linear.
   #The residuals form an approximate horizontal band around the 0 line indicating homogeneity of error variance.
   #No one residual is visibly away from the random pattern of the residuals indicating that there are no outliers.

ols_plot_resid_fit(lmod)

# if robust.line=FALSE then OLS line is drawn; if smooth=TRUE then a loess line is drawn 
spreadLevelPlot(lmod,robust.line=FALSE,grid=TRUE,smooth=TRUE)


##------------------------------------------------------------------##

dev.off()

