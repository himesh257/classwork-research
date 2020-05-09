# Requied libraries/packages
# ==========================
require(olsrr)
require(MASS)
install.packages("devtools")
library(devtools)
library(ggplot2)

# Loading the .csv file
# =====================
main_data <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/stacked-data-ergodicity.csv",header = TRUE)
main_data
summary(main_data)

# Regression
# ==========
lmod <- lm(choice ~ Xa+Xb+H+D+T , data=main_data)           # linear model regression
lmod_g <- glm(choice ~ Xa+Xb+H+D+T , data=main_data)        # generalized linear model
lmod_gnb <- glm.nb(choice ~ Xa+Xb+H+D+T , data=main_data)   # negative binomial model
abline(lmod)
summary(lmod)
summary(lmod_g)
summary(lmod_gnb)
anova(lmod)
anova(lmod_g)
anova(lmod_gnb)
coef(lmod)
confint(lmod)             # CI at 95%
confint(lmod, level=.99)  # CI at 99%

# by looking at the summary(lmod) result, we realize that it heavily
# depends on H, so now we only regress upon that
lmod_H <- lm(choice ~ H , data=main_data)
lmod_H
summary(lmod_H)
anova(lmod_H)
confint(lmod_H)             # CI at 95%
confint(lmod_H, level=.99)  # CI at 99%

# Plotting the regression models
# ==============================
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Regression1.pdf") 
plot(lmod)
dev.off()
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Regression2.pdf") 
plot(lmod_H)
dev.off()

# Plotting different scenarios
# ============================
ggplot(main_data, aes(x=cumXb, y=H)) + geom_point(shape=1) + geom_smooth(method=lm)
ggplot(main_data, aes(x=H, y=idealChoice)) + geom_point(shape=1) + geom_smooth(method=lm)
boxplot(cumXb~H,data=main_data, main="BoxPlot", xlab="CumXb", ylab="Horizon")

















