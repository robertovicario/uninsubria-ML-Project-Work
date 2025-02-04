# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: MLP, Cross-Validation, Hyperparameter Tuning
mlp_n_folds       <- 10
mlp_train_control <- trainControl(method = "cv", number = mlp_n_folds)
mlp_grid          <- expand.grid(size = c(10), decay = c(0.5))

mlp_model         <- train(type ~ .,
                           data = train,
                           method = "nnet",
                           trControl = mlp_train_control,
                           tuneGrid = mlp_grid,
                           linout = FALSE)
mlp_predictions   <- predict(mlp_model, newdata = test)

print(mlp_model$bestTune)
print(mlp_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(mlp_predictions, test$type)
mlp_acc          <- confusion_matrix$overall["Accuracy"]
mlp_prec         <- confusion_matrix$byClass["Pos Pred Value"]
mlp_rec          <- confusion_matrix$byClass["Sensitivity"]
mlp_f1           <- confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(mlp_acc, 3)))
print(paste("Precision:", round(mlp_prec, 3)))
print(paste("   Recall:", round(mlp_rec, 3)))
print(paste("       F1:", round(mlp_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(mlp_model, file = "./models/classification/mlp.h5")

# Exporting the metrics
log_file <- "./log/classification/mlp.log"
log_msg  <- paste("Multi-Layer Perceptron:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", mlp_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", mlp_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", mlp_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", mlp_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
