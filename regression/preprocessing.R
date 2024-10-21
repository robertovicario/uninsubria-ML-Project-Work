library(reticulate)
library(MASS)

sklearn <- import("sklearn.datasets")
california_housing <- sklearn$fetch_california_housing()

x <- california_housing$data
y <- california_housing$target

x_shape <- dim(x)
y_shape <- length(y)
print(paste("X Shape:", paste(x_shape, collapse = ", ")))
print(paste("Y Shape:", y_shape))

missings <- sum(anyNA(x))
print(paste("Missings:", missings, "/", nrow(x)))

duplicates <- sum(anyDuplicated(x))
print(paste("Duplicates:", duplicates, "/", nrow(x)))

z_scores <- scale(x)
outliers <- sum(rowSums(abs(z_scores) > 3) > 0)
print(paste("Outliers:", outliers, "/", nrow(x)))

set.seed(123)
index <- sample(seq_len(nrow(x)), size = 0.8 * nrow(x))
x_train <- x[index, ]
x_test <- x[-index, ]
y_train <- y[index]
y_test <- y[-index]

pca_model <- prcomp(z_scores, center = TRUE, scale. = TRUE)
x_train_pca <- as.data.frame(predict(pca_model, newdata = scale(x_train)))
x_test_pca <- as.data.frame(predict(pca_model, newdata = scale(x_test)))
summary(pca_model)

save(x_train_pca, x_test_pca, y_train, y_test, file = "regression/preprocessing.RData")
print("Saved: 'regression/preprocessing.RData'")
