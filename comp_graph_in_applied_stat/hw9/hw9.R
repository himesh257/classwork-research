# loading the library
library(faraway)
# getting the data
data(happy)
head(happy)
lmod <- lm(happy ~ money + sex + love + work, data=happy)
summary(lmod)
summary(lmod)$coefficients[5,3] #extracts the t-statistic you need for work

# critical value
qt(.975, 34)
set.seed(12345)

# there are 39! permutations. factorial() commands computes that for us
factorial39 <- factorial(39)
factorial39

# sampling process
nreps <- 5000
v_84 <- numeric(nreps)
head(v_84, 1L)

for(i in 1:nreps){
  lmod_permuted <- lm(happy ~ money + sex + love + sample(work, rep = FALSE), data = happy)
  v_84[i] <- summary(lmod_permuted)$coefficient[5, 3]
}

head(lmod_permuted, 1L)
# the first 100 results
head(abs(v_84) > abs(summary(lmod)$coefficient[5, 3]), 100L)
pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw9/density_plot.pdf") 
plot(density(v_84))
dev.off()

mean(abs(v_84))
# p-value from the OLS approach
summary(lmod)$coefficient[5, 3]






