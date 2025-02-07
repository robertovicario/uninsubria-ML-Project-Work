# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the models
load("./src/regression/preprocessing.rdata")
load("./models/regression/enet.rdata")
load("./models/regression/ols.rdata")
load("./models/regression/rf.rdata")


# ---------------------------------------------
# Heatmap
# ---------------------------------------------


# Building the visualization
corr_matrix <- cor(data)
corr_melted <- melt(corr_matrix)
print(ggplot(corr_melted, aes(x = Var1, y = Var2, fill = value)) +
  ggtitle("Heatmap of Boston Housing Prices Dataset") +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red") +
  theme_bw() +
  theme(
    plot.title = element_text(size = 16,
                              margin = margin(t = 20, b = 32),
                              hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ))

# Exporting the visualization
filename <- paste0("./docs/plots/regression/data-heatmap.png")
ggsave(filename,
       device = "png",
       width = 10,
       height = 6,
       dpi = 300)


# ---------------------------------------------
# Scatterplot
# ---------------------------------------------


plot_scatterplot <- function(title, model_name, model_predictions) {
  print(ggplot(data.frame(Actual = test$MED.VALUE,
                          Predicted = model_predictions),
               aes(x = Actual, y = Predicted)) +
          geom_point() +
          geom_abline(intercept = 0, slope = 1, color = "red") +
          labs(title = title, x = "Actual", y = "Predicted") +
          theme_bw() +
          theme(plot.title = element_text(size = 16,
                                          margin = margin(t = 20, b = 32),
                                          hjust = 0.5)))

  # Exporting the visualization
  filename <- paste0("./docs/plots/regression/",
                     model_name,
                     "-scatterplot.png")
  ggsave(filename,
         device = "png",
         width = 10,
         height = 6,
         dpi = 300)
}

# Building the visualization
plot_scatterplot("Elastic Net Scatterplot", "enet", enet_predictions)
plot_scatterplot("Linear Regression Scatterplot", "ols", ols_predictions)
plot_scatterplot("Random Forest Scatterplot", "rf", rf_predictions)


# ---------------------------------------------
