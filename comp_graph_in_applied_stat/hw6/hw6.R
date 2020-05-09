# loading the library
library(faraway)
# getting the data
data(teengamb)

# saving the output to a .txt file
sink("C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw6/output.txt", append=TRUE)

# part (a)
# we will generate the summary here and look for Multiple R squared value
teengamb[1:3,]
# using all variables
lmod <- lm(gamble ~ sex+status+income+verbal)
summary(lmod)

# part (b)
lmod$residuals; max(lmod$residuals); 

# part (c)
# finding mean
mean(lmod$residuals);
# finding median
median(lmod$residuals)

# part (d)
fitted_value <- gamble - lmod$residuals
# using the 'cor' command
cor(lmod$residuals, fitted_value)

# part (e)
cor(lmod$residuals, income)

sink()

