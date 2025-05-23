library(httr)
library(jsonlite)

getwd()
setwd("~/projects/tilak/mds1/R-programming")

# API URL
url <- "https://api2.waqi.info/api/feed/@10493/aqi.json"

# Make the GET request to the API
response <- GET(url, query = list())

# Check if the response was successful (status code 200)
if (status_code(response) == 200) {
  # Parse the response content
  data <- content(response, "text")
  parsed_data <- fromJSON(data)
  
  # Save the data to a file (JSON format)
  output_file <- "output/kathmandu_aqi_data.json"
  write_json(parsed_data, output_file, pretty = TRUE)
  
  cat("Data saved to", output_file, "\n")
} else {
  cat("Error: Unable to fetch data. Status code:", status_code(response), "\n")
}
