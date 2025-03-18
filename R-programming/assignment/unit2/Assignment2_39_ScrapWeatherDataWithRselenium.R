# Load necessary libraries
suppressWarnings({
  library(RSelenium)
  library(rvest)
  library(jsonlite)
})

remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4445L,
  browserName = "chrome",
  extraCapabilities = list(
    chromeOptions = list(
      args = list(
        '--no-sandbox',            # Disable sandbox (required in some environments)
        '--disable-dev-shm-usage'  # Disable /dev/shm usage
        # '--headless'  # Make sure headless is not included
      )
    )
  )
)


# Open a connection
remDr$open()
url <- "https://aqicn.org/city/kathmandu/"

# Navigate to a AQI Website
remDr$navigate(url)

# Explicit wait for the table element (15 seconds max)
webElem <- tryCatch({
  remDr$findElement(using = "css selector", ".forecast-body-table")
}, error = function(e) NULL)

# Check if the table appears
if (is.null(webElem)) stop("AQI table didn't load!")

# Now retry getting the page source
page_source <- remDr$getPageSource()
aqi_html <- read_html(page_source)

aqi_html <- read_html(remDr$getPageSource() %>% unlist())

forecast_table <- aqi_html %>%
  html_element(".forecast-body-table") %>%
  html_nodes("table") %>%
  html_table()

# Convert the extracted table to JSON
forecast_json <- toJSON(forecast_table, pretty = TRUE, auto_unbox = TRUE)
print(forecast_json)

# Define the output path and ensure the folder exists
output_path <- "output/kathmandu_aqi_forecast.json"

if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# Save the data to JSON format
write(forecast_json, file = output_path)

# Close Selenium browser and stop the server
remDr$close()

print("AQI data successfully scraped and saved!")
