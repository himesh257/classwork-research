##HW06
library(faraway)  #this command brings in a library of regression functions
library(psych)
library(car)
library(olsrr)

#Read in the data set GFCLOCKS.csv (Exercise 8.30 in 8th Edition, Exercise 8.26 7th edition)
GFCLOCKS <- read.csv(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/GFCLOCKS.csv",header = TRUE)
head(GFCLOCKS,5L)
lmod<-lm(PRICE ~ AGE + NUMBIDS, data=GFCLOCKS)

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/HW06_07_Figures.pdf")

ols_plot_resid_fit(lmod)

spreadLevelPlot(lmod,robust.line=FALSE,grid=TRUE,smooth=TRUE)

ols_plot_resid_stud(lmod)

ols_plot_resid_stand(lmod)

ols_plot_resid_lev(lmod)

ols_plot_resid_stud_fit(lmod)
##------------------------------------------------##

##HW07 plots requested##

ols_plot_cooksd_chart(lmod)

ols_plot_dfbetas(lmod)

ols_plot_dffits(lmod)

ols_plot_hadi(lmod)

ols_plot_resid_pot(lmod)

##------------------------------------------------##

dev.off()