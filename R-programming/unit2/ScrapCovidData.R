install.packages("rvest")
library(rvest)

url = "https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal"
covidDataWikiPage <- read_html(url)

str(covidDataWikiPage)

# get the title of the page
covidDataWikiPage %>%
  html_nodes("h1") %>%
  html_text()

covidDataTable <- covidDataWikiPage %>% 
  html_nodes(".COVID-19_pandemic_data_Nepal_medical_cases") %>% 
  html_table()
