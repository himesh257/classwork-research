#libraries needed
library(faraway)
library(psych)
library(lmtest)

file1 <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw12/FACTORS.csv", header = TRUE)

# (a)
mean(file1$LOS)   # ans = 6.54
var(file1$LOS)    # ans = 6.906531

# (b)
# y vs x => LOS vs FACTORS
plot(file1$FACTORS, file1$LOS, ylab="LOS", xlab="FACTORS")

#(c)
p <- glm(file1$LOS ~ file1$FACTORS, family="poisson", data=file1)
plot(p)
summary(p)