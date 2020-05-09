library(faraway) #this command brings in a library of regression functions
library(psych)
library(olsrr)
library(car)

#Read in the data set GFCLOCKS.csv
GFCLOCKS <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw6/GFCLOCKS.csv",header = TRUE)

head(GFCLOCKS,5L)

lmod<-lm(PRICE ~ AGE + NUMBIDS, data=GFCLOCKS)

ols_plot_resid_fit(lmod)

spreadLevelPlot(lmod,robust.line=FALSE,grid=TRUE,smooth=TRUE)

ols_plot_resid_stud(lmod)

ols_plot_resid_stand(lmod)

ols_plot_resid_lev(lmod)

ols_plot_resid_stud_fit(lmod)