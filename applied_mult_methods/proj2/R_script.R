# Loading required libraries
library("dplyr")
require(olsrr)
require(MASS)
#install.packages("devtools")
library(devtools)
library(ggplot2)
library(lmtest)
library(NbClust)
library(cluster)

# Loading the dataset
nba_players <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/applied_mult_methods/proj1/nba_players_dataset.csv", header = TRUE)
lmod <- lm(nba_players$PER ~ nba_players$Points + nba_players$Blocks + nba_players$Steals + nba_players$Assists + nba_players$Rebounds + nba_players$FG. + nba_players$FT., nba_players)
lmod_1 <- lm(nba_players$mvp_index ~ nba_players$Points + nba_players$Blocks + nba_players$Steals + nba_players$Assists + nba_players$Rebounds + nba_players$FG. + nba_players$FT., nba_players)


#set.seed(1234)
#dplyr::sample_n(nba_players, 10)

# MANOVA test
res.man <- manova(cbind(nba_players$Points, nba_players$Blocks, nba_players$Assists, nba_players$Steals, nba_players$Rebounds, nba_players$FT., nba_players$FG.) ~ nba_players$PER, data = nba_players)
summary(res.man)
summary.aov(res.man)

x <- resid(lmod)
qqnorm(x)
qqline(x)

# goodness of fit test
# http://www.sthda.com/english/wiki/chi-square-goodness-of-fit-test-in-r
# change the prob as importance of eaxh var changes

num_data <- nba_players[ , c("Points", "Blocks", "Steals", "Assists", "Rebounds", "FT.", "FG.")] 
num_data_eigen <- head(num_data, 8)
matrix_data <- as.matrix(data.frame(num_data_eigen))
matrix_data
res <- chisq.test(matrix_data, simulate.p.value=TRUE)
res
#res <- chisq.test(matrix_data, p=c(1/8, 1/8, 1/8, 1/8, 1/8, 1/8, 1/8, 1/8))
#res
res$p.value
res$expected

# Simultaneous Confidence Intervals
# https://rpubs.com/aaronsc32/simultaneous-confidence-intervals
   

# Multivariate Regression
# residual plots
for(c in names(num_data)) {
  print(c)
  c.lm = lm(nba_players$PER ~ nba_players[[c]], data=nba_players) 
  c.res = resid(c.lm)
  plot(nba_players[[c]], c.res, 
       ylab="Residuals", xlab=paste(c, " per game"), 
       main=paste("Residual plot of ", c, " per game")) 
  abline(0, 0)
}

# forward stepwise regression
k <- ols_step_forward_p(lmod)
k
plot(k)

# Likelihood Ratio Test
logistic <- glm(nba_players$per_logistic ~ nba_players$points_logistic + nba_players$blocks_logistic + nba_players$assist_logistic + nba_players$steals_logistic + nba_players$reb_logistic, family=binomial(logit), data=nba_players)
logistic_points <- glm(nba_players$per_logistic ~ nba_players$blocks_logistic + nba_players$assist_logistic + nba_players$steals_logistic + nba_players$reb_logistic, family=binomial(logit), data=nba_players)
logistic_blocks <- glm(nba_players$per_logistic ~ nba_players$points_logistic + nba_players$assist_logistic + nba_players$steals_logistic + nba_players$reb_logistic, family=binomial(logit), data=nba_players)
logistic_steals <- glm(nba_players$per_logistic ~ nba_players$points_logistic + nba_players$assist_logistic + nba_players$blocks_logistic + nba_players$reb_logistic, family=binomial(logit), data=nba_players)
logistic_assists <- glm(nba_players$per_logistic ~ nba_players$points_logistic + nba_players$blocks_logistic + nba_players$steals_logistic + nba_players$reb_logistic, family=binomial(logit), data=nba_players)
logistic_reb <- glm(nba_players$per_logistic ~ nba_players$points_logistic + nba_players$assist_logistic + nba_players$steals_logistic + nba_players$blocks_logistic, family=binomial(logit), data=nba_players)

plot(logistic_points)
par(mfrow=c(2,1))
plot(logistic_assists)

lrtest(logistic_points,logistic)
lrtest(logistic_blocks,logistic)
lrtest(logistic_assists,logistic)
lrtest(logistic_steals,logistic)
lrtest(logistic_reb,logistic)

# Multivariate methods
# K-means clustering
nba_scale <- scale(num_data) 
set.seed(1423)
k.max <- 10
wss<- sapply(1:k.max,function(k){kmeans(nba_scale,k,nstart = 20,iter.max = 20)$tot.withinss})
wss
plot(1:k.max,wss, type= "b", xlab = "Number of clusters(k)", ylab = "Within cluster sum of squares")
nc <- NbClust(nba_scale, min.nc=2, max.nc=15, method="kmeans")
irisCluster <- kmeans(nba_scale, 3, nstart = 20)
clusplot(pam(nba_scale,3))

# Factor analysis
# https://www.geo.fu-berlin.de/en/v/soga/Geodata-analysis/factor-analysis/A-simple-example-of-FA/index.html#:~:text=In%20the%20R%20software%20factor,specified%20by%20the%20argument%20factors%20.
food.fa <- factanal(num_data, factors = 2)
food.fa
food.fa$uniquenesses
apply(food.fa$loadings^2,1,sum) # communality



