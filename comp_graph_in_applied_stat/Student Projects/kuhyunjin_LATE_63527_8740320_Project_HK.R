#Diet vs Diet Ex vs Control
#Weight loss as time goes
#Weight loss vs Self esteem
#Self esteem ~ Weight loss, diet,Excercise (0,1,2)
weightloss<-WeightLoss
as.factor(weightloss$group)
weightloss1<-lm(se1~wl1+group,WeightLoss)
summary(weightloss1)
weightloss2<-lm(se2~wl2+group,weightloss)
summary(weightloss2)
weightloss3<-lm(se3~wl3+group,WeightLoss)
anova(weightloss1)
anova(weightloss2)
anova(weightloss3)
summary(weightloss2)$r.squared
summary(weightloss2)
