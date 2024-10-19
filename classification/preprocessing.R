library(reticulate)

sklearn <- import("sklearn.datasets")
olivetti_faces <- sklearn$fetch_olivetti_faces()

x <- olivetti_faces$data
y <- olivetti_faces$target

x_shape <- dim(x)
y_shape <- dim(y)
print(paste("X Shape:", paste(x_shape, collapse = ", ")))
print(paste("Y Shape:", paste(y_shape, collapse = ", ")))

missing_values <- anyNA(x)
print(paste("Missing Values:", missing_values))

duplicates <- anyDuplicated(x)
print(paste("Duplicates:", duplicates))

z_scores <- scale(x)
outlier_count <- sum(rowSums(abs(z_scores) > 3) > 0)
print(paste("Outlier Count:", outlier_count))

total_samples <- nrow(x)
outlier_percentage <- (outlier_count / total_samples) * 100
print(paste("Outlier Percentage:", round(outlier_percentage, 2), "%"))

set.seed(123)
index <- sample(seq_len(nrow(x)), size = 0.8 * nrow(x))
x_train <- x[index, ]
x_test <- x[-index, ]
y_train <- y[index]
y_test <- y[-index]

save(x_train, x_test, y_train, y_test,
  file = "classification/preprocessing.RData"
)
print("Saved: 'classification/preprocessing.RData'")
