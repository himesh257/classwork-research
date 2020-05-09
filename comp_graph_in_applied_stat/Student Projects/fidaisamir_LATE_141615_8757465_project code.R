Happy <- read.csv("C:/Users/samir/Downloads/world-happiness/2019.csv")

summary(Happy)
plot(density(Happiness$Score))
plot(Happy[-c(1, 2)])

lmod <- lm(Happy$Score~Happy$GDP.per.capita + Happy$Social.support + Happy$Healthy.life.expectancy + Happy$Freedom.to.make.life.choices + Happy$Generosity + Happy$Perceptions.of.corruption)
summary(lmod)
library(olsrr)
k <- ols_step_best_subset(lmod)
k
back <- ols_step_backward_p(lmod)
back
forward <- ols_step_forward_p(lmod)
forward
both <- ols_step_both_p(lmod)
both

require(caret)
set.seed(123)
train.control <- trainControl(method = "cv", number = 10)
model_forward <- train(Score~ Social.support + GDP.per.capita + Healthy.life.expectancy + Freedom.to.make.life.choices + Perceptions.of.corruption, data = Happy, trControl = train.control, method = "lm")
print(model_forward)

model_original <- train(Score~Generosity + Social.support + GDP.per.capita + Healthy.life.expectancy + Freedom.to.make.life.choices + Perceptions.of.corruption, data = Happy, trControl = train.control, method = "lm")
print(model_original)