#FROM: SIMULATING POWER JEFFREY HUGHES  2017-10-23
#https://cran.r-project.org/web/packages/paramtest/vignettes/Simulating-Power.html

library(paramtest)
library(pwr)
library(ggplot2)
library(knitr)
library(nlme)
library(dplyr)

windows(7,7) 
#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/PowerSampleSizeExamplesSimulation_Figure.pdf")

# varying N and Cohen's d
# create user-defined function to generate and analyze data
set.seed(3214)

t_func <- function(simNum, N, d) {
x1 <- rnorm(N, 0, 1)
x2 <- rnorm(N, d, 1)
t <- t.test(x1, x2, var.equal=TRUE)
# run t-test on generated data
stat <- t$statistic
p <- t$p.value
return(c(t=stat, p=p, sig=(p < .05)))
# return a named vector with the results we want to keep
}

power_ttest_vary2 <- grid_search(t_func, params=list(N=c(25, 50, 100), d=c(.2, .5)),
n.iter=5000, output='data.frame')
power <- results(power_ttest_vary2) %>%
group_by(N.test, d.test) %>%
summarise(power=mean(sig))
print(power)

ggplot(power, aes(x=N.test, y=power, group=factor(d.test), colour=factor(d.test))) +
geom_point() +
geom_line() +
ylim(c(0, 1)) +
labs(x='Sample Size', y='Power', colour="Cohen's d") +
theme_minimal()


#using simulation, we can determine the power for more complex models,
#including interactions and simple effects.

set.seed(2134)
lm_test_interaction <- function(simNum, N, b1, b2, b3, b0=0, x1m=0, x1sd=1,
x2m=0, x2sd=1) {

x1 <- rnorm(N, x1m, x1sd)
x2 <- rnorm(N, x2m, x2sd)

yvar <- sqrt(1 - b1^2 - b2^2 - b3^2) # residual variance
y <- rnorm(N, b0 + b1*x1 + b2*x2 + b3*x1*x2, yvar)

model <- lm(y ~ x1 * x2)

# pull output from model (two main effects and interaction)

est_x1 <- coef(summary(model))['x1', 'Estimate']
p_x1 <- coef(summary(model))['x1', 'Pr(>|t|)']
sig_x1 <- p_x1 < .05
est_x2 <- coef(summary(model))['x2', 'Estimate']
p_x2 <- coef(summary(model))['x2', 'Pr(>|t|)']
sig_x2 <- p_x2 < .05
est_int <- coef(summary(model))['x1:x2', 'Estimate']
p_int <- coef(summary(model))['x1:x2', 'Pr(>|t|)']
sig_int <- p_int < .05
return(c(est_x1=est_x1, p_x1=p_x1, sig_x1=sig_x1, est_x2=est_x2, p_x2=p_x2,
sig_x2=sig_x2, est_int=est_int, p_int=p_int, sig_int=sig_int))
}

#varying N at 200 and 300; setting coefficient of x1 = .15, coefficient of
# x2 = 0, and coefficien of interaction = .3

power_lm_int <- grid_search(lm_test_interaction, params=list(N=c(200, 300)),
n.iter=5000, output='data.frame', b1=.15, b2=0, b3=.3, parallel='snow', ncpus=4)
results(power_lm_int) %>%
group_by(N.test) %>%
summarise(
power_x1=mean(sig_x1),
power_x2=mean(sig_x2),
power_int=mean(sig_int))

dev.off()