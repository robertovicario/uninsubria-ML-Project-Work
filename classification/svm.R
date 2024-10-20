library(e1071)
load("classification/metrics.rData")
load("classification/preprocessing.rData")

x_train <- scale(x_train_lda)
x_test <- scale(x_test_lda)

cost_vals <- 10^seq(-3, 3, by = 1)
tuned_model <- tune(svm,
                    train.x = x_train,
                    train.y = as.factor(y_train),
                    kernel = "linear",
                    ranges = list(cost = cost_vals),
                    tunecontrol = tune.control(sampling = "cross", cross = 10))
print(tuned_model)

svm_model <- tuned_model$best.model
y_pred <- predict(svm_model, x_test)

print(paste("Accuracy:", accuracy(y_pred, y_test)))
print(paste("Precision:", precision(y_pred, y_test)))
print(paste("Recall:", recall(y_pred, y_test)))
print(paste("F1-Score:", f1_score(y_pred, y_test)))
