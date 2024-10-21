library(reticulate)
library(MASS)

sklearn <- import("sklearn.datasets")
olivetti_faces <- sklearn$fetch_olivetti_faces()

x <- olivetti_faces$data
y <- olivetti_faces$target

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

lda_model <- lda(x_train, grouping = y_train)
x_train_lda <- predict(lda_model, x_train)$x
x_test_lda <- predict(lda_model, x_test)$x

save(x_train_lda, x_test_lda, y_train, y_test, file = "classification/preprocessing.RData") # nolint
print("Saved: 'classification/preprocessing.RData'")
