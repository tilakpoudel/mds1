# Load necessary libraries
suppressWarnings({
  library(RSelenium)
  library(rvest)
  library(jsonlite)
})

# .........fire fox set up--------------

library(RSelenium)

# Create a remote driver object with more defined capabilities
remDr <- remoteDriver(
  remoteServerAddr = "172.18.0.2",   # Ensure this is correct (use container IP if necessary)
  port = 4444L,
  browserName = "firefox",          # Ensure 'firefox' is specified as the browser
  extraCapabilities = list(
    "moz:firefoxOptions" = list(
      args = list("--headless")     # If you want headless mode, keep this, else remove it
    )
  )
)

# Open the browser
remDr$open()

# Navigate to a website
url <- "https://www.google.com"
remDr$navigate(url)

# Wait for the page to load
Sys.sleep(3)

# Get the title of the page
page_title <- remDr$getTitle()
print(page_title)

# Extract the page source (for further scraping)
page_source <- remDr$getPageSource()
print(page_source)

# Close the browser and the Selenium server
remDr$close()



# ............ chrome setup ...............

library(RSelenium)

# Define Chrome capabilities
chrome_capabilities <- list(
  browserName = "chrome",
  "goog:chromeOptions" = list(
    args = list("--headless", "--disable-gpu", "--no-sandbox", "--disable-dev-shm-usage")
  )
)

remDr <- remoteDriver(
  remoteServerAddr = "localhost",  # or the Docker host IP
  port = 4444L,
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


# Connect to the running Docker container
# remDr <- remoteDriver(
#   remoteServerAddr = "localhost",
#   port = 4444L,
#   browserName = "chrome"
#   extraCapabilities = chrome_capabilities
# )

# Open browser
remDr$open()

# Navigate and interact
remDr$navigate("https://www.google.com")
Sys.sleep(3)

# Get title to ensure connection works
page_title <- remDr$getTitle()
print(page_title)

# Close browser
remDr$close()


# Take a screenshot to verify visually (optional)
remDr$screenshot(display = TRUE)

# Close the browser and session
remDr$close()












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
if (is.null(webElem)) stop("AQI table still didn't load!")

# Now retry getting the page source
page_source <- remDr$getPageSource()[[1]]
aqi_html <- read_html(page_source)


aqi_html <- read_html(remDr$getPageSource() %>% unlist())
aqi_html %>%
  html_element(".forecast-body-table") %>%
  html_nodes("table") %>%
  html_table() -> forecast_table
forecast_table







# Navigate and wait for the AQI table to render
# Navigate and wait briefly
remDr$navigate("https://aqicn.org/city/kathmandu/")
Sys.sleep(3)

# Simulate scrolling (triggers lazy-loading JS)
remDr$executeScript("window.scrollTo(0, document.body.scrollHeight)")
Sys.sleep(3)

# Simulate a click (forces data to reload)
tryCatch({
  button <- remDr$findElement(using = "css selector", ".some-refresh-button")
  button$click()
}, error = function(e) cat("No refresh button found — continuing...\n"))

# Wait and re-check the table
webElem <- tryCatch({
  remDr$findElement(using = "css selector", ".forecast-body-table")
}, error = function(e) NULL)

if (is.null(webElem)) stop("Table still didn't load after interactions!")

# Extract the content
page_source <- remDr$getPageSource()[[1]]
cat(substr(page_source, 1, 1000))


aqi_html <- read_html(remDr$getPageSource() %>% unlist())
print(aqi_html)
# Wait for a specific element to appear
webElem <- tryCatch({
  remDr$findElement(using = "css selector", ".forecast-body-table")
}, error = function(e) NULL)

if (is.null(webElem)) {
  stop("Failed to load AQI table!")
}

# Extract updated page source after table loads
page_source <- remDr$getPageSource()[[1]]
aqi_html <- read_html(page_source)

# Extract the table data
forecast_table <- aqi_html %>%
  html_element(".forecast-body-table") %>%
  html_nodes("table") %>%
  html_table()

print(forecast_table)

# Handle missing or empty tables gracefully
if (length(forecast_table) == 0) {
  stop("Error: AQI data table not found or failed to load!")
}

# Display the scraped data for verification
print(forecast_table)

# Convert the extracted table to JSON for easy storage and processing
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

print("✅ AQI data successfully scraped and saved!")
