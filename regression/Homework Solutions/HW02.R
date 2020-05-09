
##HW02
library(faraway)  #this command brings in a library of regression functions

#read in the data which is in a csv file
#change the directory below to your directory
HW02 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/ASWELLS.csv",header = TRUE)

# Fit a multiple linear regression model using y=Arsenic Level and X1=Latitude, X2=Longitude, and X3=Depth.
lmod <- lm(ARSENIC ~ LATITUDE + LONGITUDE + DEPTH, data=HW02)

#a) output that shows the estimated regression coefficients, standard errors, and p-values associated with each coefficient.
summary(lmod)

#b) output that shows R2 and adjusted R2.
#See above output from summary(lmod) statement

#c) output that shows 95% confidence intervals for Beta1, Beta2, Beta3
confint(lmod)

#d) output that shows a test for H0: Beta1= - Beta2  which is the same as H0: Beta1 + Beta2 =0.
lmod_reduced1 <- lm(ARSENIC ~ I(-LATITUDE + LONGITUDE) + DEPTH, data=HW02)

#e) output that shows the X matrix for the Reduced Model where Beta1 + Beta2 = 0.
head(model.matrix(lmod_reduced1),10L)  #just showing the first 10 rows of the X matrix for the Reduced Model

#f) output that shows the SSE for a model with only X1 and X2.
lmod_reduced2 <- lm(ARSENIC ~ LATITUDE + LONGITUDE, data=HW02)
summary(lmod_reduced2)$SSE
anova(lmod_reduced2,lmod) #this information was not requested - just showing the test for H0: B3=0

#g) output that shows the X matrix for the Full Model.
head(model.matrix(lmod),10L)  #just showing the first 10 rows of the X matrix for the Full Model

#h) output that shows the residuals from the fitted Full Model.
head(residuals(lmod),10L)  #just showing the first 10 residuals

##-----------------------------------------------------------------------##

