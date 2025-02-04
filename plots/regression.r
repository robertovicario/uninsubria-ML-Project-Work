# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the model
load("./src/classification/preprocessing.rdata")
load("./models/classification/lr.rdata")
load("./models/classification/nb.rdata")
load("./models/classification/nnet.rdata")


# ---------------------------------------------


# Using an helper function
plot_confusion_matrix <- function(title, model_name, model_predictions) {
  # Strategy: Confusion Matrix
  confusion_matrix      <- table(Actual = test$type,
                                 Predicted = model_predictions)
  hm                    <- as.data.frame(as.table(confusion_matrix))
  confusion_matrix_plot <- ggplot(hm,
                                  aes(x = Predicted,
                                      y = Actual,
                                      fill = Freq)) +
    ggtitle(title) +
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

  # Strategy: Confusion Matrix
  # ...

  # Exporting the visualizations
  filename <- "./docs/plots/classification/" +
    model_name +
    "-confusion-matrix.png"
  ggsave(filename,
         plot = confusion_matrix_plot,
         device = "png",
         width = 10,
         height = 8,
         dpi = 300)
}

# Plotting the visualizations
plot_confusion_matrix("Logistic Regression", "lr", lr_predictions)
plot_confusion_matrix("Naïve Bayes Performance", "nb", nb_predictions)
plot_confusion_matrix("Neural Netowork Performance", "nnet", nnet_predictions)


# ---------------------------------------------
