# ---------------------------------------------


# Importing the libraries
library(caret)
library(kernlab)

# Loading the data
data(spam)
data <- as.data.frame(spam)

# Counting all samples
samples_count <- nrow(data)
cat("   Samples Count:", samples_count, "\n")


# ---------------------------------------------
# Missings
# ---------------------------------------------


# Strategy: Impute missing values with median
missings_count <- sum(is.na(data))
cat("  Missings Count:", missings_count, "\n")

for (col in names(data)) {
  if (anyNA(data[[col]])) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]])
  }
}


# ---------------------------------------------
# Duplicates
# ---------------------------------------------


# Strategy: Remove duplicates iteratively
duplicates_count <- sum(duplicated(data))
cat("Duplicates Count:", duplicates_count, "\n")

if (anyDuplicated(data)) {
  data <- data[!duplicated(data), ]
}


# ---------------------------------------------
# Outliers
# ---------------------------------------------


# Strategy: Impute outliers using Standardization
numeric_data   <- data[, sapply(data, is.numeric)]
outliers_count <- 0

for (col in names(numeric_data)) {
  if (is.numeric(numeric_data[[col]])) {
    z_scores       <- scale(numeric_data[[col]], center = TRUE, scale = TRUE)
    outliers       <- abs(z_scores) > 3
    outliers_count <- outliers_count + sum(outliers)
    numeric_data[[col]][outliers] <- median(numeric_data[[col]], na.rm = TRUE)
  }
}

cat("  Outliers Count:", outliers_count, "\n")


# ---------------------------------------------
# Data Splitting
# ---------------------------------------------


# Strategy: 80 training, 20 testing
set.seed(123)
train_percent <- 0.8
train_index   <- createDataPartition(data$type,
                                     p = train_percent,
                                     list = FALSE)
train         <- data[train_index, ]
test          <- data[-train_index, ]


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/classification/preprocessing.log"
log_msg  <- paste("Preprocessing:")
log_msg  <- paste(log_msg, "\n    -    Samples Count:", samples_count)
log_msg  <- paste(log_msg, "\n    -   Missings Count:", missings_count)
log_msg  <- paste(log_msg, "\n    - Duplicates Count:", duplicated_count)
log_msg  <- paste(log_msg, "\n    -   Outliers Count:", outliers_count)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)

# Exporting the preprocessed data
save(data, train, test, file = "./src/classification/preprocessing.rdata")


# ---------------------------------------------
