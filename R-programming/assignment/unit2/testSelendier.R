url_aqi <- "https://aqicn.org/city/kathmandu/"

aqi_page <- read_html(url_aqi)

# Extract the AQI forecast data
aq_forecast <- aqi_page %>% html_nodes("table") %>% html_table(fill = TRUE)

# Clean the AQI data
aq_forecast_clean <- aq_forecast[[1]] %>%
  rename(Date = 1, AQI = 2) %>%
  filter(!is.na(Date)) %>%
  mutate(AQI = as.numeric(gsub("[, ]", "", AQI)))

# Save the cleaned AQI data
write.csv(aq_forecast_clean, "cleaned_aqi_data.csv", row.names = FALSE)