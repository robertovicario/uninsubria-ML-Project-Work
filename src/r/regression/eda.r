# ------------------------
# ----- Dependencies -----
# ------------------------

library(hexbin)

# ---------------------
# ----- Importing -----
# ---------------------

data <- read_csv("../../data/raw/california_housing.csv")

# ---------------
# ----- EDA -----
# ---------------

# Duplicates Handling
data <- unique(data)

# Missings Handling
for (col in names(data)) {
  if (any(is.na(data[[col]]))) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
  }
}

# Outliers Removal
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    Q1 <- quantile(data[[col]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[col]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    data[[col]][data[[col]] < lower_bound] <- lower_bound
    data[[col]][data[[col]] > upper_bound] <- upper_bound
  }
}

# Plotting for HBs
hb_colors <- colorRampPalette(c("blue", "red", "green", "yellow"))

# Plot 1
hb1 <- hexbin(data$total_rooms, data$median_house_value)
plot(hb1, xlab = "Total Rooms", ylab = "Median House Value", colramp = hb_colors)

# Plot 2
hb2 <- hexbin(data$total_bedrooms, data$median_house_value)
plot(hb2, xlab = "Total Bedrooms", ylab = "Median House Value", colramp = hb_colors)

# Plot 3
hb3 <- hexbin(data$population, data$median_house_value)
plot(hb3, xlab = "Population", ylab = "Median House Value", colramp = hb_colors)

# ---------------------
# ----- Exporting -----
# ---------------------

save(data, file = "../../data/models/eda.rdata")
