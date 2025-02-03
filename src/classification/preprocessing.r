# ---------------------------------------------


# Importing the libraries
library(caret)
library(kernlab)

# Loading the data
data(spam)
data <- as.data.frame(spam)


# ---------------------------------------------


# Checking for missing values
# Strategy: Impute missing values with median
missings_count <- sum(is.na(data))
cat("  Missings Count:", missings_count, "\n")

if (anyNA(data)) {
  for (col in names(data)) {
    if (any(is.na(data[[col]]))) {
      data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
    }
  }
}


# ---------------------------------------------


# Checking for duplicates
# Strategy: Remove duplicates iteratively
duplicated_count <- sum(duplicated(data))
cat("Duplicated Count:", duplicated_count, "\n")

if (anyDuplicated(data)) {
  data <- data[!duplicated(data), ]
}


# ---------------------------------------------


# Checking for outliers
# Strategy: Remove outliers using IQR method
numeric_data <- data[, sapply(data, is.numeric)]
q1 <- apply(numeric_data, 2, quantile, probs = 0.25, na.rm = TRUE)
q3 <- apply(numeric_data, 2, quantile, probs = 0.75, na.rm = TRUE)
iqr <- q3 - q1

lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

outliers_count <- 0
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    outliers <- data[[col]] < lower_bound[col] | data[[col]] > upper_bound[col]
    outliers_count <- outliers_count + sum(outliers)
    data <- data[!outliers, ]
  }
}

cat("  Outliers Count:", outliers_count, "\n")


# ---------------------------------------------


# Splitting the data
# Strategy: 80 training, 20 testing
set.seed(123)
train_percent <- 0.8
train_index <- createDataPartition(data$median_house_value,
                                   p = train_percent,
                                   list = FALSE)
train <- data[train_index, ]
test <- data[-train_index, ]


# ---------------------------------------------


# Exporting the preprocessed data
save(data, train, test, file = "./src/classification/preprocessing.rdata")


# ---------------------------------------------
