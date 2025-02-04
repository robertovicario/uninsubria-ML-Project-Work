# ---------------------------------------------


# Importing the libraries
library(ggplot2)
library(pROC)

# Loading the model
load("./src/classification/preprocessing.rdata")
load("./models/classification/nnet.rdata")


# ---------------------------------------------


# Plotting the visualizations
# Strategy: Confusion Matrix, ROC-AUC
confusion_matrix      <- table(Actual = test$type, Predicted = nnet_predictions)
hm                    <- as.data.frame(as.table(confusion_matrix))
confusion_matrix_plot <- ggplot(hm,
                                aes(x = Predicted,
                                    y = Actual,
                                    fill = Freq)) +
  ggtitle("Neural Network Performance") +
  geom_tile() +
  theme_bw() +
  coord_equal() +
  scale_fill_distiller(palette = "Blues", direction = 1) +
  guides(fill = FALSE) +
  geom_text(aes(label = Freq), size = 10) +
  theme(
    plot.title = element_text(size = 24, margin = margin(t = 20, b = 32)),
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 20, margin = margin(t = 20, b = 20)),
    axis.title.y = element_text(size = 20, margin = margin(r = 20))
  )
print(confusion_matrix_plot)


# ---------------------------------------------


# Exporting the visualizations
ggsave("./docs/plots/nnet/confusion-matrix.png",
       plot = confusion_matrix_plot,
       device = "png",
       width = 10,
       height = 8,
       dpi = 300)

#ggsave("./docs/plots/nnet/roc-auc.png",
#       plot = roc_plot,
#       device = "png",
#       width = 10,
#       height = 8,
#       dpi = 300)


# ---------------------------------------------
