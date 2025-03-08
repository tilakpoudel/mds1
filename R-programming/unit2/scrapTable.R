install.packages("rvest")
library(rvest)

url <- "https://www.w3schools.com/html/html_tables.asp"
w3school <- read_html(url)

# get the title of the page
w3school %>%
  html_nodes("h1") %>%
  html_text()

w3school %>%
  html_nodes("table")%>%
  html_table()