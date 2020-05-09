library(faraway)

##---------------------------------------------------------------------##
#this example regresses on variables that have no correlation with each other
#Data from an experiment to determine the effects of column temperature, 
#gas/liquid ratio and packing height in reducing unpleasant odor of chemical product
#that was being sold for household use

data(odor, package="faraway")
help(odor)

odor
cov(odor[,-1])
lmod <- lm(odor ~ temp + gas + pack, odor)
summary(lmod,cor=TRUE) #asks for a correlation of the coefficients  (see page 28 of text)
lmod <- lm(odor ~ gas + pack, odor)  
summary(lmod)  #note the p-values for gas and pack are similar to the model with all 3 variables

#delete the largest and smallest observation from the dataset (dataframe)
odor_trim <- odor[-c(1,8), ]  #note the use of [ and ] to differentiate from a function named "odor"
#also note the comma after -c(1,8). the space after the comma indicates to leave the columns alone
odor_trim

lmod_trim <- lm(odor ~ temp + gas + pack, odor_trim)
summary(lmod_trim,cor=TRUE)

##---------------------------------------------------------------------##

sessionInfo()  #provides information on session
Sys.time()  #time stamps output

