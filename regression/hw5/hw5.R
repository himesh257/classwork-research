
# loading the library
library(faraway)

# reading the csv file
hw5_ans <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw4/HW04_data.csv", header = TRUE)

# regression
lmod_hw5 <- lm(y ~ x1+x2+x3+x4+x5+x6+x7+x8+x9,data=hw5_ans)

# part a)
vif(lmod_hw5)

# part b)
pdf(file="C:/Users/buchh/OneDrive/Desktop/regression/hw5/HW5_b.pdf")
qqnorm(residuals(lmod_hw5),ylab="Residuals")
qqline(residuals(lmod_hw5))
dev.off()

# part c)
pdf(file="C:/Users/buchh/OneDrive/Desktop/regression/hw5/HW5_c.pdf")
plot(fitted(lmod_hw5),residuals(lmod_hw5),xlab="Fitted",ylab="Residuals")
abline(h=0) 
dev.off()
