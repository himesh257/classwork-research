# Loading required libraries
library("dplyr")
library(e1071)
library(purrr)
library(tidyr)
library(mvdalab)
library(ggplot2)
library(mvoutlier)
library(lmtest)
source("http://www.sthda.com/upload/rquery_cormat.r")

# Loading the dataset
nba_players <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/applied_mult_methods/proj1/nba_players_dataset.csv", header = TRUE)
nba_players

only_two = nba_players[ , c("Name", "PER")]
plot(only_two)

scatterplot(nba_players$name ~ nba_players$PER)

# Univariate analysis
str(nba_players)
summary(nba_players)
class(nba_players)

# range of each variables
range(nba_players$Points)
range(nba_players$Blocks)
range(nba_players$Steals)
range(nba_players$Assists)
range(nba_players$Rebounds)
range(nba_players$FT.)
range(nba_players$FG.)
range(nba_players$PER)

plot(density(nba_players$Points), main="Density plot for Points")
plot(density(nba_players$Blocks), main="Density plot for Blocks")
plot(density(nba_players$Steals), main="Density plot for Steals")
plot(density(nba_players$Assists), main="Density plot for Assists")
plot(density(nba_players$Rebounds), main="Density plot for Rebounds")
plot(density(nba_players$FT.), main="Density plot for FT%")
plot(density(nba_players$FG.), main="Density plot for FG%")
plot(density(nba_players$PER), main="Density plot for PER")

# sd of each variable
sd(nba_players$Points)
sd(nba_players$Blocks)
sd(nba_players$Steals)
sd(nba_players$Assists)
sd(nba_players$Rebounds)
sd(nba_players$FT.)
sd(nba_players$FG.)
sd(nba_players$PER)

# skewness of each variable
skewness(nba_players$Points)
skewness(nba_players$Blocks)
skewness(nba_players$Steals)
skewness(nba_players$Assists)
skewness(nba_players$Rebounds)
skewness(nba_players$FT.)
skewness(nba_players$FG.)
skewness(nba_players$PER)

num_data <- nba_players[ , c("Points", "Blocks", "Steals", "Assists", "Rebounds", "FT.", "FG.", "PER")] 
num_data1 <- nba_players[ , c("Points", "Blocks", "Steals", "Assists", "Rebounds", "FT.", "FG.")] 

#Hotellings T2 Confidence Intervals
MVcis(num_data, Vars2Plot = c(1, 2), include.zero = TRUE)

pp.plot(num_data)
chisq.plot(num_data)

# pp-plot
num_data %>%
        keep(is.numeric) %>% 
        gather() %>% 
        ggplot(aes(value)) +
        facet_wrap(~ key, scales = "free") +
        geom_histogram()

# graphs
# variable: points
hist(nba_players$Points, xlab = "Points", ylab = "Frequency", main = "Histogram of points per game", col="grey")
boxplot(nba_players$Points, xlab = "Points", ylab = "Frequency", main = "Boxplot of points per game", col="grey")
plot(nba_players$Points, xlab = "Points", ylab = "Frequency", main = "Distribution of points per game")
dotchart(nba_players$Points, xlab = "Points", ylab = "Frequency", main = "Dotplot for points per game")

# Normal probability distribution plot
points.lm = lm(nba_players$per ~ nba_players$points, data=nba_players) 
points.stdres = rstandard(points.lm)
qqnorm(points.stdres, 
              ylab="Standardized Residuals", 
              xlab="Normal Scores", 
              main="Points per game") 
qqline(points.stdres)

# variable: blocks
hist(nba_players$Blocks, xlab = "Blocks", ylab = "Frequency", main = "Histogram of blocks per game", col="grey")
boxplot(nba_players$Blocks, xlab = "Blocks", ylab = "Frequency", main = "Box plot of blocks per game", col="grey")
plot(nba_players$Blocks, xlab = "Blocks", ylab = "Frequency", main = "Distribution of blocks per game")
dotchart(nba_players$Blocks, xlab = "Blocks", ylab = "Frequency", main = "Dotplot of blocks per game")

# Normal probability distribution plot
blocks.lm = lm(nba_players$PER ~ nba_players$Blocks, data=nba_players) 
blocks.stdres = rstandard(blocks.lm)
qqnorm(blocks.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Blocks per game") 
qqline(blocks.stdres)

# variable: steals
hist(nba_players$Steals, xlab = "Steals", ylab = "Frequency", main = "Histogram of steals per game", col="grey")
boxplot(nba_players$Steals, xlab = "Steals", ylab = "Frequency", main = "Box plot of steals per game", col="grey")
plot(nba_players$Steals, xlab = "Steals", ylab = "Frequency", main = "Distribution of steals per game")
dotchart(nba_players$Steals, xlab = "Steals", ylab = "Frequency", main = "Dotplot of steals per game")

# Normal probability distribution plot
steals.lm = lm(nba_players$PER ~ nba_players$Steals, data=nba_players) 
steals.stdres = rstandard(steals.lm)
qqnorm(steals.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Steals per game") 
qqline(steals.stdres)

# variable: assists
hist(nba_players$Assists, xlab = "Assists", ylab = "Frequency", main = "Histogram of assists per game", col="grey")
boxplot(nba_players$Assists, xlab = "Assists", ylab = "Frequency", main = "Box plot of assists per game", col="grey")
plot(nba_players$Assists, xlab = "Assists", ylab = "Frequency", main = "Distribution of assists per game")
dotchart(nba_players$Assists, xlab = "Assists", ylab = "Frequency", main = "Dotplot of assists per game")

# Normal probability distribution plot
assists.lm = lm(nba_players$PER ~ nba_players$Assists, data=nba_players) 
assists.stdres = rstandard(assists.lm)
qqnorm(assists.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Assists per game") 
qqline(assists.stdres)

# variable: rebounds
hist(nba_players$Rebounds, xlab = "Rebounds", ylab = "Frequency", main = "Histogram of rebounds per game", col="grey")
boxplot(nba_players$Rebounds, xlab = "Rebounds", ylab = "Frequency", main = "Box plot of rebounds per game", col="grey")
plot(nba_players$Rebounds, xlab = "Rebounds", ylab = "Frequency", main = "Distribution of rebounds per game")
dotchart(nba_players$Rebounds, xlab = "Rebounds", ylab = "Frequency", main = "Dotplot of rebounds per game")

# Normal probability distribution plot
rebounds.lm = lm(nba_players$PER ~ nba_players$Rebounds, data=nba_players) 
rebounds.stdres = rstandard(rebounds.lm)
qqnorm(rebounds.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Rebounds per game") 
qqline(rebounds.stdres)

# variable: ft
hist(nba_players$FT., xlab = "Free throw %", ylab = "Frequency", main = "Histogram of free throw % per game", col="grey")
boxplot(nba_players$FT., xlab = "Free throw %", ylab = "Frequency", main = "Box plot of free throw % per game", col="grey")
plot(nba_players$FT., xlab = "Free throw %", ylab = "Frequency", main = "Distribution of free throw % per game")
dotchart(nba_players$FT., xlab = "Free throw %", ylab = "Frequency", main = "Dotplot of free throw % per game")

# Normal probability distribution plot
ft.lm = lm(nba_players$PER ~ nba_players$FT., data=nba_players) 
ft.stdres = rstandard(ft.lm)
qqnorm(ft.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Free throw % per game") 
qqline(ft.stdres)

# variable: fg
hist(nba_players$FG., xlab = "Field goal %", ylab = "Frequency", main = "Histogram of field goal % per game", col="grey")
boxplot(nba_players$FG., xlab = "Field goal %", ylab = "Frequency", main = "Box plot of field goal % per game", col="grey")
plot(nba_players$FG., xlab = "Field goal %", ylab = "Frequency", main = "Distribution of field goal % per game")
dotchart(nba_players$FG., xlab = "Field goal %", ylab = "Frequency", main = "Dotplot of field goal % per game")

# Normal probability distribution plot
fg.lm = lm(nba_players$PER ~ nba_players$FG., data=nba_players) 
fg.stdres = rstandard(fg.lm)
qqnorm(fg.stdres, 
       ylab="Standardized Residuals", 
       xlab="Normal Scores", 
       main="Field goal % per game") 
qqline(fg.stdres)


# Bivariate Analysis
# corelation matrix
rquery.cormat(num_data)

# variance covariance matrix
cov(num_data)
cor(num_data)
var(num_data)

# eigen values
num_data_eigen <- head(num_data, 8)
matrix_data <- as.matrix(data.frame(num_data_eigen))
matrix_data
e <- eigen(matrix_data)
e$values
e$vectors

# regression
lmod <- lm(nba_players$PER ~ nba_players$Points + nba_players$Blocks + nba_players$Steals + nba_players$Assists + nba_players$Rebounds + nba_players$FG. + nba_players$FT., nba_players)
lmod
lmod1 <- lm(nba_players$mvp_index ~ nba_players$Points + nba_players$Blocks + nba_players$Steals + nba_players$Assists + nba_players$Rebounds + nba_players$FG. + nba_players$FT., nba_players)
summary(lmod)
summary(lmod1)

# logistic regression
logistic <- glm(nba_players$per_logistic ~ nba_players$points_logistic, family=binomial(logit), nba_players)
summary(logistic)
logistic1 <- glm(nba_players$per_logistic ~ nba_players$blocks_logistic, family=binomial(logit), nba_players)
summary(logistic1)

lrtest(logistic1,logistic)

# scatterplots
plot(nba_players$PER, nba_players$Points, xlab = "PER", ylab = "Points", main = "PER vs Points per game")
plot(nba_players$PER, nba_players$Blocks, xlab = "PER", ylab = "Blocks", main = "PER vs Blocks per game")
plot(nba_players$PER, nba_players$Assists, xlab = "PER", ylab = "Assists", main = "PER vs Assists per game")
plot(nba_players$PER, nba_players$Rebounds, xlab = "PER", ylab = "Rebounds", main = "PER vs Rebounds per game")
plot(nba_players$PER, nba_players$FT., xlab = "PER", ylab = "FT.", main = "PER vs Free throw % per game")
plot(nba_players$PER, nba_players$FG., xlab = "PER", ylab = "FG.", main = "PER vs Field goal % per game")
plot(nba_players$PER, nba_players$Steals, xlab = "PER", ylab = "Steals", main = "PER vs Steals per game")

# PER vs mvp_index
plot(nba_players$PER, col = "orange", xlab="MVP index", ylab="PER", main = "PER vs MVP index")
lines(nba_players$mvp_index, type = "o", col = "black")
legend(0, -5, legend=c("PER", "MVP index"), col=c("orange", "black"), lty=1:1, cex=0.8)
