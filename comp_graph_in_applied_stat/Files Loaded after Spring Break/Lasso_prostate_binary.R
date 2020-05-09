#performs LASSO on binomial variables#       
#--------------------------------------------------------------------------------------------------------#
library(faraway)
data(prostate,package="faraway")
head(prostate)

#save graph in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/Lasso_prostate_binary_Figure.pdf")

if (FALSE)
{"
lcavol log(cancer volume)
lweight log(prostate weight)
age age
lbph log(benign prostatic hyperplasia amount)
svi seminal vesicle invasion
lcp log(capsular penetration)
gleason Gleason score
pgg45 percentage Gleason scores 4 or 5
lpsa log(prostate specific antigen)
"}

summary(prostate)

y<-(prostate[,5])  #svi (0,1) is found in the 5th column
head(y)

library(glmnet) # include glmnet library including functions for finding the lasso

#------------------------------------------------#

#perform multiple regression
lmod <- lm(lpsa ~ lcavol + lweight + age + lbph + svi + lcp + gleason + pgg45, prostate)
summary(lmod)

#perform binary LASSO regression#
#------------------------------------------------#
# glmnet requires design matrix and response variable

x<-(apply(prostate[,-5],2,as.numeric))
#svi (0,1) is seminal vesicle invasion and is found in the 5th column

head(x) 
#-----------------------------------------------------------------#

lassofit<-glmnet(x,y,family=c("binomial"))  #fits a logistic regression model

print(lassofit) # DF gives the number of non-zero coefficients

par(mfrow = c(1, 1))

plot(lassofit, xvar="lambda")
#-----------------------------------------------------------------#

#plot(lassofit, xvar="norm")
#-----------------------------------------------------------------#

par(mfrow = c(1, 1))
coef(lassofit)

# Cross Validation
cvlassofit <- cv.glmnet(x,y)
print(cvlassofit)
plot(cvlassofit)

coef(cvlassofit, s = "lambda.min") # to get the coefficients for the "optimal" lambda

#choose the largest value of lambda which is within 1 SE of the minimum
coef(cvlassofit, s = "lambda.1se") # to get the coefficients for the one SE lambda

dev.off()