# loading the library
require(faraway)
# getting the data
data(prostate, package='faraway')
head(prostate)

# writing the output to a .txt file
sink("C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw7/output.txt", append=TRUE)
#generating summary of the dataset
summary(prostate)

# model lweight
lmod <- lm(lpsa ~ lcavol + lweight, prostate)
summary(lmod)

# model svi
lmod <- lm(lpsa ~ lcavol + lweight + svi, prostate)
summary(lmod)

# model lbph
lmod <- lm(lpsa ~ lcavol + lweight + svi + lbph, prostate)
summary(lmod)

# model age
lmod <- lm(lpsa ~ lcavol + lweight + svi + lbph + age, prostate)
summary(lmod)

# model lcp
lmod <- lm(lpsa ~ lcavol + lweight + svi + lbph + age + lcp, prostate)
summary(lmod)

# model pgg45
lmod <- lm(lpsa ~ lcavol + lweight + svi + lbph + age + lcp + pgg45, prostate)
summary(lmod)

# model gleason
lmod <- lm(lpsa ~ lcavol + lweight + svi + lbph + age + lcp + pgg45 + gleason, prostate)
summary(lmod)
sink()