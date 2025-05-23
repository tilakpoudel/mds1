library(rvest)
library(jsonlite)

# set the working directory
getwd()
setwd("~/projects/tilak/mds1/R-programming")

# web page url
url = "https://data.covid19india.org/"
webpage <- read_html(url)

# observe the structure of the web page
str(webpage)

# get the title of the page
h3_elements <- webpage %>%
  html_nodes("h3") %>%
  html_text()

# get all the h3 elements for table title
str(h3_elements)

# Get first h3 for first table
highestCovid19DeathTitle <- h3_elements[[1]]
highestCovid19DeathTitle

# Get the data from the table
table_nodes <- webpage %>% html_nodes("table.has-fixed-layout")

# Part1 : First table with no of death info
death_table = table_nodes[[1]]

# Extract rows and cells
rows <- death_table %>% html_nodes("tr")
data_list <- list()

# Loop through each row and extract the key-value pairs
for (row in rows) {
  cells <- row %>% html_nodes("td") %>% html_text(trim = TRUE)

  if (length(cells) == 2) {
    # Clean up the key (convert to lowercase, replace spaces with underscores)
    key <- gsub("\\s+", "_", tolower(cells[1])) 
    data_list[[key]] <- trimws(cells[2])
  }
}

# Wrap the entire data_list inside a new key called "data"
final_data <- list(data = data_list)

# Convert list to JSON — ensure no arrays for single values
json_data <- jsonlite::toJSON(final_data, pretty = TRUE, auto_unbox = TRUE)

# Save to file
output_path <- "output/india_covid19_death_data.json"
write(json_data, file = output_path)

# Part2 : second table with number of recovered info
recovery_table = table_nodes[[2]]

# Extract the rows of the table
table <- recovery_table %>% 
  html_table(fill = TRUE)

table_data <- list()

# Skip the first row (header) and loop through the remaining rows
# Start from 2 to skip the header row
for (i in 2:nrow(table)) {
  # Extract and clean the row data
  year <- trimws(table[i, 1])  # First column: Year
  daily_cases <- trimws(table[i, 2])  # Second column: Daily Cases
  recovery_rate <- trimws(table[i, 3])  # Third column: Recovery Rate
  
  # Skip rows where all values are empty
  if (all(c(year, daily_cases, recovery_rate) == "")) {
    next
  }
  
  # Use gsub to clean data for both fields 
  daily_cases <- gsub("—", "", daily_cases)  # Replace em dash with empty string
  daily_cases <- gsub("[^0-9]", "", daily_cases)  # Keep only numeric characters
  
  # Clean recovery rate: replace "—" and "%" and convert to decimal if needed
  recovery_rate <- gsub("—", "", recovery_rate)  # Remove '—'
  recovery_rate <- gsub("%", "", recovery_rate)  # Remove '%'
  
  # Store the cleaned data in the list (index correctly)
  table_data[[length(table_data) + 1]] <- list(  # This ensures no duplication
    year = year,
    number_of_cases = daily_cases,
    recovery_rate = recovery_rate
  )
}

# Wrap the data in a top-level 'data' key
final_data <- list(data = table_data)

# Convert the list to JSON, ensuring no arrays for single values
json_data <- toJSON(final_data, pretty = TRUE, auto_unbox = TRUE)
print(json_data)

# Define the output file path
output_path <- "output/india_covid19_recovery_data.json"

# Ensure the output folder exists
if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# Save the JSON file
write(json_data, file = output_path)
