# ---------------------------------------------


# Importing the libraries
library(readr)
library(reticulate)

# Loading the data
np <- import("numpy")
data <- np$load("./data/olivetti_faces.npy")
data <- as.data.frame(data)


# ---------------------------------------------


# Checking for missing values
# Strategy: Impute missing values with median
if (any(is.na(data))) {
  missing_count <- sum(is.na(data))
  cat("Missings Count:", missing_count, "\n")
  for (col in names(data)) {
    if (any(is.na(data[[col]]))) {
      data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
    }
  }
}


# ---------------------------------------------


# Checking for duplicates
# Strategy: Remove duplicates iteratively
if (any(duplicated(data))) {
  duplicated_count <- sum(duplicated(data))
  cat("Duplicated Values Count:", duplicated_count, "\n")
  data <- data[!duplicated(data), ]
}

# ---------------------------------------------


# Checking for outliers
# Strategy: Remove outliers using Cook's distance
model <- lm(median_house_value ~ ., data = data)
cooks_distance <- cooks.distance(model)
influential <- cooks_distance > (4 / nrow(data))
if (any(influential)) {
  outliers_count <- sum(influential)
  cat("Outliers Count:", outliers_count, "\n")
  data <- data[!influential, ]
}


# ---------------------------------------------


# Normalizing the data
# Strategy: Standardization
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    data[[col]] <- scale(data[[col]])
  }
}


# ---------------------------------------------


# Splitting the data
# Strategy: 80 training, 20 testing
set.seed(123)
train_percent <- 0.8 # training percentage
train_index <- createDataPartition(data$median_house_value,
                                   p = train_percent,
                                   list = FALSE)
train <- data[train_index, ]
test <- data[-train_index, ]


# ---------------------------------------------


# Exporting the preprocessed data
save(data, train, test, file = "./src/classification/preprocessing.rdata")


# ---------------------------------------------
