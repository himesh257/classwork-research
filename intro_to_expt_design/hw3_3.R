## Create factor levels and enter the data 
stir    <- factor(rep(1:4, each = 4))   ## you can use the = sign
furnace <- factor(rep(1:4, times = 4))  ## instead of the <- arrow sign
size <- c(8, 4, 5, 6,
          14, 5, 6, 9, 
          14, 6, 9, 2,
          17, 9, 3, 6)
gsize <- data.frame(size, stir, furnace)
gsize    # Check the data
str(gsize)	# This command shows the structure of object called gsize 

## ANOVA analysis: notice we include the block effect first in the model equation
afit <- aov(size ~ furnace + stir, data = gsize)                 
summary(afit)

## The plot to visualize normality is given by the command below 
plot(afit,2)

## The plot to visualize residuals versus stir is given by the command below
plot(stir, afit$residual, xlab='stir levels', ylab='residuals');  abline(0,0) 
plot(stir, afit$furnace, xlab='stir levels', ylab='residuals');  abline(0,0) 

## plot(stir, afit$residual, xlab='stir levels', ylab='residuals');  abline(0,0)

## Notice the difference in the quotes symbol. The first is done using the R editor.
## The second was done using MS Word, and it does not work in R.  MS Word adds metadata.
## You can use a .txt editor such as MS Notepad to generate a flat file, with no metadata

## Next plot shows residuals versus predicted values
plot(afit,1);  abline(0,0)
