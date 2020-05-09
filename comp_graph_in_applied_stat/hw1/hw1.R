# loading the library
library(faraway)
# loading the dataset
data(prostate)
prostate[1:5,]

# computation
lmod <- lm(lpsa ~ lcavol+age+lweight+gleason)

# writing the output to .txt file
sink("C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw1/output.txt", append=TRUE) 
summary(lmod)
sink()

# generating the pdf for the plots
pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw1/plots.pdf") 
plot(lmod)
dev.off()

