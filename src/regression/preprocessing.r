# ---------------------------------------------


# Importing the libraries
library("A3")
library(caret)

# Loading the data
data(housing)
data <- as.data.frame(housing)


# ---------------------------------------------


# Checking for missing values
# Strategy: Impute missing values with median
missings_count <- sum(is.na(data))
cat("  Missings Count:", missings_count, "\n")

for (col in names(data)) {
  if (anyNA(data[[col]])) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]])
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
# Strategy: Remove outliers using Cook's distance
model <- lm(data$MED.VALUE ~ ., data = data)
cooks_distance <- cooks.distance(model)
influential <- cooks_distance > (4 / nrow(data))
outliers_count <- sum(influential)
cat("  Outliers Count:", outliers_count, "\n")

if (any(influential)) {
  data <- data[!influential, ]
}


# ---------------------------------------------


# Splitting the data
# Strategy: 80 training, 20 testing
set.seed(123)
train_percent <- 0.8
train_index <- createDataPartition(data$MED.VALUE,
                                   p = train_percent,
                                   list = FALSE)
train <- data[train_index, ]
test <- data[-train_index, ]


# ---------------------------------------------


# Exporting the preprocessed data
save(data, train, test, file = "./src/regression/preprocessing.rdata")


# ---------------------------------------------
