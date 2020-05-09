##---------------------------------------------------------------------##
#this example regresses on variables that have no correlation with each other
#Data from an experiment to determine the effects of column temperature, 
#gas/liquid ratio and packing height in reducing unpleasant odor of chemical product
#that was being sold for household use

library(faraway)
data(odor, package="faraway")
#help(odor)

# n=15 observations
# odor is the odor score which is continuous
# temp is Temperature coded as -1, 0 and 1
# gas is Gas/Liquid ratio coded as -1, 0 and 1
# pack is Packing height coded as -1, 0 and 1

odor
cov(odor[,-1])  #variance - covariance matrix of the three independent variables
#note s**2 of temp = s**2 of gas = s**2 of pack = 0.5714286

#now perform a multiple regression of odor on the 3 independent variables
lmod <- lm(odor ~ temp + gas + pack, odor)
summary(lmod,cor=TRUE) #asks for a correlation of the coefficients  
lmod <- lm(odor ~ gas + pack, odor)
summary(lmod)

require(ellipse)
# Plot an ellipse corresponding to a 95% probability region for a
# bivariate normal distribution 
windows(7,7)
#save graph in pdf
pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/uncorrelated_XsR_out.pdf")

plot(ellipse(lmod,c(2,3)),type="l")  #note the use of 2 and 3 - the intercept occupies the 1 position
points(coef(lmod)[2], coef(lmod)[3], pch=19)  #pch is used to define the plotting character

##---------------------------------------------------------------------##

#delete the largest and smallest observation from the dataset (dataframe)
odor_trim <- odor[-c(1,8), ]  #note the use of [ and ] to differentiate from a function named "odor"
#also note the comma after -c(1,8). the space after the comma indicates to leave the columns alone
odor_trim

lmod_trim <- lm(odor ~ temp + gas + pack, odor_trim)
summary(lmod_trim,cor=TRUE)  #asks for a correlation of the coefficients  

require(ellipse)
# Plot an ellipse corresponding to a 95% probability region for a
# bivariate normal distribution 
plot(ellipse(lmod_trim,c(2,3)),type="l")  #note the use of 2 and 3 - the intercept occupies the 1 position
points(coef(lmod)[2], coef(lmod)[3], pch=19)  #pch is used to define the plotting character

##---------------------------------------------------------------------##

dev.off()


