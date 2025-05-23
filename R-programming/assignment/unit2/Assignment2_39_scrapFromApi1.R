library(httr)
library(jsonlite)

setwd("~/projects/tilak/mds1/R-programming")

# Define the API endpoint
url <- "https://api.rootnet.in/covid19-in/stats/latest"

# Make the GET request to fetch data
response <- GET(url)

# Check if the request was successful (HTTP status 200)
if (status_code(response) == 200) {
  
  # Parse the JSON content from the response
  data <- content(response, "text")
  parsed_data <- fromJSON(data)
  
  # Define output file name
  output_file <- "output/covid19_in_latest.json"
  
  # Save the parsed data into a JSON file (formatted nicely)
  write_json(parsed_data, output_file, pretty = TRUE)
  
  cat("Data successfully saved to:", output_file, "\n")
  
} else {
  # If the request fails, print an error message
  cat("Error: Failed to fetch data. Status code:", status_code(response), "\n")
}
