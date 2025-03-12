# TODO:: [TP 2025-03-12] Run the code, it has not been run due to failed duckdb installation

#install.packages("RSQLite")
library(dplyr)
library("RSQLite")
library(DBI)

# make connection
con <- dbConnect(
  RSQLite::SQLite(),
  ":memory:"
)
dbListTables(con)

# create tables
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)

# see the fields
dbListFields(con, "mtcars")

res <- dbSendQuery(
  con,
  "SELECT * FROM mtcars WHERE cyl = 4"
)

dbFetch(res)
dbClearResult(res)
dbDisconnect(con)

#install the packages if not install else no need so commented
install.packages("duckdb")
install.packages("ggplot2")

library(duckdb)
library(ggplot2)

# dplyr and DBI
# local db that comes with Rstudio i.e duckdb
con <- DBI::dbConnect(
  duckdb::duckdb()
)

# create table mpg from ggplot2 library
dbWriteTable(con, "mpg", ggplot2::mpg)
# create table diamonds from ggplot2 library
dbWriteTable(con, "diamonds", ggplot2::diamonds)

dbListTables(con)

cons %>%
  dbReadTable("diamonds")%>% 
  as_tibble()

# select data
sql <- "SELECT carart, cut, clarity, color, price, FROM diamonds WHERE price > 15000"

as_tibble(dbGetQuery(con, sql))


# use dbplyr package in sql
library(dbplyr)
diamonds_db <- tbl(con, "diamonds")
diamonds_db

diamonds_db <- tbl(
  con,
  sql("SELECT * FROM diamonds")
)

# apply filter
big_diamonds_db <- diamonds_db %>%
  filter(price > 15000) %>%
  select(carat:clarity, price)

big_diamonds_db
# see the corresponding sql query
show_query()

# usage with dplyr
# copy all the tables from ncyflights12, BE aware there may be many tables and loading can cause memory issue
dbplyr::copy_ncyflights12(con)
