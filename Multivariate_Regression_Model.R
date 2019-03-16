#11) Multivariate regression Model with price and rest all the other 15 variables
multivariate.reg <- lm(list_traning_data$price ~ . , data = list_traning_data)
summary(multivariate.reg)



