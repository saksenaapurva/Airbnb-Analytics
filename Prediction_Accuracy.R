
#12) Precition Model
pred <- predict(multivariate.reg, list_test_data)

actuals_pred <- data.frame(cbind(actuals = list_test_data$price, predicteds = pred))

corr_accuracy <- cor(actuals_pred)
corr_accuracy

mean_of_predict <- mean(apply(actuals_pred, 1, min)/apply(actuals_pred, 1, max))
mean_of_predict
