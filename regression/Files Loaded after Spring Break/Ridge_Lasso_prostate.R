library(faraway)  
data(prostate,package="faraway") 

#save graph in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/Ridge_Lasso_prostate_Figure.pdf")

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

head(prostate)
summary(prostate)

prostate$svi <- factor(prostate$svi)
summary(prostate$svi)
#------------------------------------------------#
library(MASS)
fit <- lm.ridge(lpsa~.,prostate,lambda=seq(0,50,by=0.1))
fit$GCV

#perform multiple regression
modlm <- lm(lpsa ~ lcavol + lweight + age + lbph + svi + lcp + gleason + pgg45, prostate)
summary(modlm)

library(glmnet) # include glmnet library including functions for finding the lasso
#------------------------------------------------#
# glmnet requires design matrix and response variable

x<-(apply(prostate[,-9],2,as.numeric))
head(x)

y<-(prostate[,9])
head(y)

lassofit<-glmnet(x,y)

print(lassofit) # DF gives the number of non-zero coefficients

par(mfrow = c(1, 2))

plot(lassofit, xvar="lambda")
#------------------------------------------------#

plot(lassofit, xvar="norm")
#------------------------------------------------#

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