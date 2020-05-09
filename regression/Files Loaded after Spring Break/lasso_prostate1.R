library(faraway)  
data(prostate,package="faraway") 

#save graph in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/lasso_prostate1_Figure.pdf")


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

prostate$svi <- factor(prostate$svi)
summary(prostate$svi)

library(glmnet) # include glmnet library including functions for finding the lasso
#------------------------------------------------#

#perform multiple regression
lmod <- lm(lpsa ~ lcavol + lweight + age + lbph + svi + lcp + gleason + pgg45, prostate)
summary(lmod)

#------------------------------------------------#
# glmnet requires design matrix and response variable

x<-(apply(prostate[,-9],2,as.numeric))
head(x)

y<-(prostate[,9])
head(y)

lassofit<-glmnet(x,y)

# DF gives the number of non-zero coefficients
#and %dev is the percent deviance explained (relative to the null deviance)
print(lassofit) 


par(mfrow = c(1, 2))
plot(lassofit, xvar="lambda")
#------------------------------------------------#

par(mfrow = c(1, 1))
coef(lassofit)

help(cv.glmnet)  #default number of folds for CV is 10

# Cross Validation
cvlassofit <- cv.glmnet(x,y)
print(cvlassofit)
plot(cvlassofit)

# to get the coefficients for the "optimal" lambda
coef(cvlassofit, s = "lambda.min") 

#choose the largest value of lambda which is within 1 SE of the minimum
coef(cvlassofit, s = "lambda.1se") # to get the coefficients for the one SE lambda

dev.off()
