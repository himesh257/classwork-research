library(faraway)
library(psych)
library(QuantPsyc)
library(MASS)

hw13 <- meatspec
hw13 <- data.frame(hw13)
describe(hw13)

lmod <- lm(fat ~ .,data=hw13)
summary(lmod)

rgmod <- lm.ridge(fat ~ .,data=hw13, lambda = seq(0, 6e-08, len=21))
matplot(rgmod$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod$GCV) #use the generalized cross validation (GCV) estimate
abline(v=3.0e-08)
rgmod$coef #prints out the coefficients


hw13_2 <- meatspec[,-(1:70)]
hw13_2 <- data.frame(hw13_2)
describe(hw13_2)

rgmod_2 <- lm.ridge(fat ~ .,data=hw13_2, lambda = seq(0, 6e-08, len=21))
matplot(rgmod_2$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod_2$GCV) #use the generalized cross validation (GCV) estimate
abline(v=3.0e-08)
rgmod_2$coef #prints out the coefficients



