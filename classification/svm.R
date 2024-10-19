library(e1071)
library(caret)
library(stats)

load("classification/preprocessing.RData")
load("classification/metrics.RData")

x_train <- scale(x_train)
x_test <- scale(x_test)

svm_model <- svm(x_train, as.factor(y_train), kernel = "linear")
y_pred <- predict(svm_model, x_test)
accuracy_val <- accuracy(y_pred, y_test)

print(paste("Accuracy:", accuracy_val, "%"))

pca_model <- prcomp(x_train, center = TRUE, scale. = TRUE)
x_train_pca <- predict(pca_model, x_train)
x_test_pca <- predict(pca_model, x_test)

k <- 50
x_train_pca <- x_train_pca[, 1:k]
x_test_pca <- x_test_pca[, 1:k]

svm_model <- svm(x_train_pca, as.factor(y_train), kernel = "linear")
y_pred <- predict(svm_model, x_test_pca)

accuracy_val <- accuracy(y_pred, y_test)
print(paste("Accuracy:", accuracy_val, "%"))
