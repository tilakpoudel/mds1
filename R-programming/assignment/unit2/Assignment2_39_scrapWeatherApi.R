# Load required libraries
library(chromote)
library(rvest)
library(dplyr)
library(tibble)
library(lubridate)

setwd("~/projects/tilak/mds1/R-programming")

# Start a browser session
broswerSession <- ChromoteSession$new()

# Open the air quality forecast page
broswerSession$Page$navigate("https://aqicn.org/city/kathmandu")

# Wait for page to load
Sys.sleep(5)

# Get the rendered HTML
page_html <- broswerSession$Runtime$evaluate("document.documentElement.outerHTML")$result$value

# Parse HTML
document <- read_html(page_html)

# Extract table and convert to tibble
data_forecast_table <- document %>%
  html_node(".forecast-body-table table") %>%
  html_table() %>%
  as_tibble()

# Print the table
print(data_forecast_table)

# Close browser session
broswerSession$close()

# Transpose table for time-series format
data_forecast_table <- t(data_forecast_table)

# Convert to data frame
forecast_df <- data.frame(data_forecast_table)
print(forecast_df)

# Remove empty columns
empty_columns <- colSums(is.na(forecast_df)) == nrow(forecast_df)  
print(names(empty_columns[empty_columns]))

# Drop unnecessary columns
forecast_df <- forecast_df %>%
  select(-c("X1", "X2", "X6", "X10"))

# Rename columns
colnames(forecast_df) <- c("day", "hour", "wind_speed_m/s", "temperature", "relative_humidity", "barometric_pressure", "total_precipitation")
print(colnames(forecast_df))

# Remove rows with missing values
forecast_df <- na.omit(forecast_df)
forecast_df <- forecast_df[-1, ]  # Remove first row

# Reset row index
rownames(forecast_df) <- NULL

# Clean 'day' column
forecast_df$day_cleaned <- gsub("(st|nd|rd|th)", "", forecast_df$day)

# Create date-time column
forecast_df <- forecast_df %>%
  mutate(date_time = ymd_h(paste0("2025 March ", day_cleaned, " ", hour))) %>%
  select(-day_cleaned)

# Remove unnecessary symbol from temperature
forecast_df$temperature <- gsub("°", "", forecast_df$temperature)

# Extract day name
forecast_df$day <- gsub(" [0-9]+(st|nd|rd|th)?", "", forecast_df$day)

# Set date_time as index
rownames(forecast_df) <- forecast_df$date_time
forecast_df <- forecast_df %>%
  select(-date_time)
print(head(forecast_df))

# Save data to CSV
output_filename <- paste0("output/air_forecast_kathmandu_", format(Sys.time(), "%Y-%m-%d_%H-%M-%S"), ".csv")
write.csv(forecast_df, output_filename, row.names=TRUE)

# Print first six rows
head(forecast_df)