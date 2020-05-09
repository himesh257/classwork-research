# loading the library
library(faraway)
# specifying the dataset
data("prostate")
head(prostate)
lmod = lm(lpsa~lcavol,data=prostate)

# generating output
summary(lmod)

# saving the output in a pdf file
pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw5/output.pdf") 
# drawing histogram
hist(residuals(lmod),main="Histogram of the Residuals")
anova(lmod)
dev.off()

