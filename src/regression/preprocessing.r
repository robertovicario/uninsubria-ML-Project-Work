# ---------------------------------------------


# Importing the libraries
library("A3")
library(caret)

# Loading the data
data(housing)
data <- as.data.frame(housing)

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


# Strategy: Remove outliers using Cook's distance
model          <- lm(data$MED.VALUE ~ ., data = data)
cooks_distance <- cooks.distance(model)
influential    <- cooks_distance > (4 / nrow(data))
outliers_count <- sum(influential)
cat("  Outliers Count:", outliers_count, "\n")

if (any(influential)) {
  data <- data[!influential, ]
}


# ---------------------------------------------
# Data Splitting
# ---------------------------------------------


# Strategy: 80 training, 20 testing
set.seed(123)
train_percent <- 0.8
train_index   <- createDataPartition(data$MED.VALUE,
                                     p = train_percent,
                                     list = FALSE)
train         <- data[train_index, ]
test          <- data[-train_index, ]


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/regression/preprocessing.log"
log_msg  <- paste("Preprocessing:")
log_msg  <- paste(log_msg, "\n    -    Samples Count:", samples_count)
log_msg  <- paste(log_msg, "\n    -   Missings Count:", missings_count)
log_msg  <- paste(log_msg, "\n    - Duplicates Count:", duplicated_count)
log_msg  <- paste(log_msg, "\n    -   Outliers Count:", outliers_count)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)

# Exporting the preprocessed data
save(data, train, test, file = "./src/regression/preprocessing.rdata")


# ---------------------------------------------
