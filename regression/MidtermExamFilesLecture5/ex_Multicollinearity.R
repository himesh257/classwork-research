#Variance Inflation Example

if (FALSE)
{"
Measuring body fat is not so simple.  Hydrostatic underwater weighing is a method of determining body composition (body fat to lean mass).
Obtain a person's total body density by submerging the body underwater in a tank and measuring the displacement.
Considered the gold standard for body composition assessment. More sophisticated methods may make underwater weighing obsolete in the near future.
n=252 men  - Brozek's equation was applied to each man's hydrostatic underwater weighing results to accurately estimate their percentage of body fat.
"}

library(faraway)  #this command brings in a library of regression functions
data(fat,package="faraway")
head(fat)

#full model
lmod <- lm(brozek ~ age + weight + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)

vif_weight <- lm( weight ~ age +  height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)
1/(1-summary(vif_weight)$r.squared)

vif(lmod)

X <- model.matrix(lmod)[,-1]  #exclude the column of 1's

round(cor(X),2)

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 05 18FEB2020/ex_Multicollinearity_R_out.pdf")

# Basic Scatterplot Matrix
 pairs(~ weight + hip + chest + abdom, data=fat, main="Simple Scatterplot Matrix")

#model excluding weight
lmod1 <- lm(brozek ~ age + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)
vif(lmod1)  #just removing weight from the model reduces the multicollinearity issue

#model excluding weight and abdom
lmod2 <- lm(brozek ~ age + height + neck + chest + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)
vif(lmod2)  #even better improvement in multicollinearity by removing weight and abdom from the model 

require(olsrr)

full <- ols_step_backward_p(lmod,details=FALSE)
full

full1 <- ols_step_backward_p(lmod1,details=FALSE)
full1

full2 <- ols_step_backward_p(lmod2,details=FALSE)
full2

full3 <- ols_step_forward_p(lmod,details=FALSE)
full3

full4 <- ols_step_forward_p(lmod1,details=FALSE)
full4

full5 <- ols_step_forward_p(lmod2,details=FALSE)
full5

##----------------------------------##

dev.off()





