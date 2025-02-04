# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Neural Network, Cross-Validation, Hyperparameter Tuning
nnet_n_folds       <- 10
nnet_train_control <- trainControl(method = "cv", number = nnet_n_folds)
nnet_grid          <- expand.grid(size = c(10), decay = c(0.5))

nnet_model         <- train(type ~ .,
                            data = train,
                            method = "nnet",
                            trControl = nnet_train_control,
                            tuneGrid = nnet_grid,
                            linout = FALSE)
nnet_predictions   <- predict(nnet_model, newdata = test)

print(nnet_model$bestTune)
print(nnet_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(nnet_predictions, test$type)
nnet_acc          <- confusion_matrix$overall["Accuracy"]
nnet_prec         <- confusion_matrix$byClass["Pos Pred Value"]
nnet_rec          <- confusion_matrix$byClass["Sensitivity"]
nnet_f1           <- confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(nnet_acc, 3)))
print(paste("Precision:", round(nnet_prec, 3)))
print(paste("   Recall:", round(nnet_rec, 3)))
print(paste("       F1:", round(nnet_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(nnet_model, file = "./models/classification/nnet.rdata")

# Exporting the metrics
log_file <- "./log/classification/nnet.log"
log_msg  <- paste("Multi-Layer Perceptron:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", nnet_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", nnet_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", nnet_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", nnet_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
