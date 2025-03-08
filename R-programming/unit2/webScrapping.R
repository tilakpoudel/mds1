install.packages("rvest")
library(rvest)

simple <- read_html("https://dataquestio.github.io/web-scraping-pages/simple.html")
simple %>%
  html_nodes("p")%>%
  html_text()

# get page title
page_tilte <- simple%>%
  html_node("title")%>%
  html_text()