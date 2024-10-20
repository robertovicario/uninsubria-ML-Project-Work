library(e1071)
library(class)
load("classification/metrics.RData")
load("classification/preprocessing.RData")

x_train <- norm(x_train_lda)
x_test <- norm(x_test_lda)

k <- 5
y_pred <- knn(train = x_train_lda, test = x_test_lda, cl = y_train, k = k)

print(paste("Accuracy:", accuracy(y_pred, y_test)))
print(paste("Precision:", precision(y_pred, y_test)))
print(paste("Recall:", recall(y_pred, y_test)))
print(paste("F1-Score:", f1_score(y_pred, y_test)))
