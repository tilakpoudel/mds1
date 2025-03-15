# Load necessary libraries
suppressWarnings({
  library(RSelenium)
  library(rvest)
  library(netstat)
  library(jsonlite)
})

# Start Selenium server and browser
browserDriver <- rsDriver(browser = "firefox", verbose = FALSE, port = free_port())
# verbose = FALSE: Hides unnecessary output logs.
# port = free_port(): Finds an available port automatically using netstat::free_port() (avoids port conflicts).

remDr <- browserDriver[["client"]] #browser client that interact and navigate with the website

# Navigate to the target website
remDr$navigate("https://aqicn.org/forecast/kathmandu/")

# Wait a bit to ensure the page loads (helps if data loads via JavaScript)
Sys.sleep(5)

# Get the full page source
aqi_html <- read_html(remDr$getPageSource() %>% unlist())

# Extract the forecast table data
forecast_table <- aqi_html %>%
  html_element(".forecast-body-table") %>%  # Selects the main table container
  html_nodes("table") %>%                    # Finds the table inside
  html_table()                                # Converts table to a data frame

# Check if the table is successfully extracted
if (length(forecast_table) == 0) {
  stop("AQI data table not found!")
}

# Display the scraped data
print(forecast_table)

# Convert to JSON for easier use or storage
forecast_json <- toJSON(forecast_table, pretty = TRUE, auto_unbox = TRUE)
print(forecast_json)

# Define output path
output_path <- "output/kathmandu_aqi_forecast.json"

# Ensure output folder exists
if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# Save data to JSON file
write(forecast_json, file = output_path)

# Close the Selenium browser and stop server
remDr$close()
rD$server$stop()

print("AQI data successfully scraped and saved!")
