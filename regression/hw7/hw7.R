#Read in the data set GFCLOCKS.csv
GFCLOCKS <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw6/GFCLOCKS.csv",header = TRUE)

head(GFCLOCKS,5L)

lmod<-lm(PRICE ~ AGE + NUMBIDS, data=GFCLOCKS)

ols_plot_cooksd_chart(lmod)
ols_plot_dfbetas(lmod)
ols_plot_dffits(lmod)
ols_plot_hadi(lmod)
ols_plot_resid_pot(lmod)