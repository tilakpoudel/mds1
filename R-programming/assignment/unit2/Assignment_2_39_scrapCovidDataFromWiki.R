library(rvest)
library(jsonlite)

# set the working directory
getwd()
setwd("~/projects/tilak/mds1/R-programming")

# Define the Wikipedia URL
url <- "https://en.wikipedia.org/wiki/COVID-19_pandemic_by_country_and_territory"
webpage <- read_html(url)

# Function to get the table by xpath and caption and modify it (skip first column, last row)
get_table_by_caption <- function(page, captionText, trimFirstColumn = FALSE, trimLastRow = FALSE) {
  # Step 1: Find the table by caption using XPath
  # paste0(): Since we don’t need any spaces between the parts of the XPath query,
  # it is appropriate because it directly concatenates the strings without adding a space.
  table_node <- page %>%
    html_node(xpath = paste0("//table[caption[contains(., '", captionText, "')]]"))
  
  if (is.null(table_node)) {
    stop(paste("Table with caption containing '", captionText, "' not found!", sep = ""))
  }
  
  # Step 2: Convert table node to a data frame
  table_df <- html_table(table_node, fill = TRUE)
  
  # Step 3: Skip the first column and last row
  if (trimFirstColumn) {
    table_df <- table_df[, -1]   # Remove the first column
  }
  
  if (trimLastRow) {
    table_df <- table_df[-nrow(table_df), ]  # Remove the last row
  }
  
  return(table_df)
}

# Table1
# Get the vaccine table
vaccine_table <- get_table_by_caption(webpage, "COVID-19 vaccine distribution", trimFirstColumn = TRUE, trimLastRow = TRUE)
# print(head(vaccine_table))
# Save the data as csv
write.csv(vaccine_table, "output/vaccine_distribution_table.csv", row.names = FALSE)

# Table2
death_and_rates_by_location <- get_table_by_caption(webpage, "COVID-19 cases, deaths, and rates by location", trimLastRow = TRUE)
# print(head(death_and_rates_by_location))
# Save the data as csv
write.csv(death_and_rates_by_location, "output/deaths_table.csv", row.names = FALSE)

# Table3
monthly_2022_cumm_deaths <- get_table_by_caption(webpage, captionText = "2022 monthly cumulative COVID-19 deaths", trimFirstColumn = TRUE)
print(head(monthly_2022_cumm_deaths))
# Save the data as csv
write.csv(monthly_2022_cumm_deaths, "output/monthly_2022_cumm_deaths.csv", row.names = FALSE)

cat("Tables scraped and saved!")

