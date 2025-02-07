# ---------------------------------------------

# Importing the libraries
library(ggplot2)

# Loading the models
load("./src/regression/preprocessing.rdata")

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
