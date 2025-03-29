# Project: R Programming - Project 2, Part 1

# 1. Import covnep_252days.csv file into R studio as covnep_252days data frame
# 2. Covert the date (character date) variable as date variable (date2) using as.Date function (covnep_252days data frame) 
# 3. Create line chart of date2 and totalCases variables and interpret it carefully (covnep_252days data frame)
# 4. Create line chart of date2 and newCases variables and interpret it carefully (covnep_252days data frame)
# 5. Create line chart of date2 and totalDeaths variables and interpret it carefully (covnep_252days data frame)
# 6. Create line chart of date2 and newDeaths variable and interpret it carefully (covnep_252days data frame)
# 7. Compute summary measures of totalCases, newCases, totalRecoveries, newRecoveries, totalDeaths and newDeaths variables using an appropriate apply family of functions (covnep_252days data frame)
# 8. Import MR_Drugs.xlxs file into R studio as MR_Drugs data frame and create given table (Screenshot 10.55.06 AM) and interpret response percentage and percentage of cases carefully
# 9. Import SAQ.sav file into R studio as SAQ data frame and create given tables (e.g Screenshot 11.01.51 for Q1,Q2,Q3) and interpret each frequency table carefully

# install tinytex to generate the report in pdf
# install.packages("tinytex")
# tinytex::install_tinytex()  # Installs LaTeX distribution


getwd()

# load the csv as data frame
covnep_252days <- read.csv("covnep_252days.csv")

# Display the first few rows of the data frame
head(covnep_252days)

# Check the structure of the data frame
str(covnep_252days)

# Convert the date variable to Date type
covnep_252days$date2 <- as.Date(covnep_252days$date, format="%m/%d/%Y")

# Display the first few rows to check the conversion
head(covnep_252days$date2)
# Check the structure of the data frame again
str(covnep_252days)

# 3. Create line chart of date2 and totalCases variables and interpret it carefully (covnep_252days data frame)
Sys.setlocale("LC_TIME", "en_US.UTF-8")  # set locale to english 

plot(
    covnep_252days$date2, 
    covnep_252days$totalCases, 
    type="l",
    col="blue",
    lwd=2,
    xlab="Date", 
    ylab="Total cases", 
    main="Total COVID-19 cases over time",
    yaxt="n",  # Suppress y-axis labels
)
# Define y-axis labels at 10000 intervals
axis(2, at=seq(0, max(covnep_252days$totalCases), by=10000), las=1)

# 4. Create line chart of date2 and newCases variables and interpret it carefully (covnep_252days data frame)
plot(
    covnep_252days$date2, 
    covnep_252days$newCases, 
    type="l",
    col="red",
    lwd=1,
    xlab="Date", 
    ylab="New cases", 
    main="New COVID-19 cases over time",
)

# 5. Create line chart of date2 and totalDeaths variables and interpret it carefully (covnep_252days data frame)
plot(
    covnep_252days$date2, 
    covnep_252days$totalDeaths, 
    type="l",
    col="green",
    lwd=1,
    xlab="Date", 
    ylab="Total deaths", 
    main="Total COVID-19 deaths over time",
)
# 6. Create line chart of date2 and newDeaths variable and interpret it carefully (covnep_252days data frame)
plot(
    covnep_252days$date2, 
    covnep_252days$newDeaths, 
    type="l",
    col="purple",
    lwd=1,
    xlab="Date", 
    ylab="New deaths", 
    main="New COVID-19 deaths over time",
)

# 7. Compute summary measures of totalCases, newCases, totalRecoveries, newRecoveries, totalDeaths and newDeaths variables using an appropriate apply family of functions (covnep_252days data frame)
# Compute summary measures using sapply
summary_measures <- sapply(covnep_252days[, c("totalCases", "newCases", "totalRecoveries", "newRecoveries", "totalDeaths", "newDeaths")], function(x) {
  c(
    mean = mean(x, na.rm = TRUE),
    median = median(x, na.rm = TRUE),
    sd = sd(x, na.rm = TRUE),
    min = min(x, na.rm = TRUE),
    max = max(x, na.rm = TRUE)
  )
})

summary_measures

# 8. Import MR_Drugs.xlxs file into R studio as MR_Drugs data frame and create given table (Screenshot 10.55.06 AM) and interpret response percentage and percentage of cases carefully
# import the xlxs file
library(readxl)
suppressWarnings(library(summarytools))
getwd()
MR_Drugs <- read_excel("MR_Drugs.xlsx")

head(MR_Drugs)
tail(MR_Drugs)

# see the structure of the data frame
str(MR_Drugs)

# income columns
drugs_data <- MR_Drugs[, c("inco1", "inco2", "inco3", "inco4", "inco5", "inco6", "inco7")]
# get sum of every column
colSums(drugs_data)

# total sum of all columns
total_sum <- sum(colSums(drugs_data))
total_sum

# get percentage of each column across whole data
each_column_percentage_on_all_data <- round(as.numeric(colSums(drugs_data) / total_sum * 100), 1)
each_column_percentage_on_all_data

# get percentage of each column across whole data
round(as.numeric(colSums(!is.na(drugs_data)) / total_sum * 100), 1)

# column names
names(drugs_data)

colSums(!is.na(drugs_data))

levels <- c(names(drugs_data))
levels

income_frequencies <- data.frame(
  levels = c(names(drugs_data)),
  N = colSums(drugs_data),
  Percent = round(as.numeric(colSums(drugs_data) / (total_sum) * 100), 1),
  Percent_of_cases = round(as.numeric(colSums(drugs_data) / colSums(!is.na(drugs_data)) * 100), 1)
)

income_frequencies

row.names(income_frequencies) <- NULL
total <- c(
  "Total",
  sum(as.numeric(income_frequencies$N)),
  sum(as.numeric(income_frequencies$Percent)),
  sum(as.numeric(income_frequencies$Percent_of_cases))
)
income_frequencies <- rbind(income_frequencies, total)
income_frequencies

# 9. Import SAQ.sav file into R studio as SAQ data frame and create given tables (e.g Screenshot 11.01.51 for Q1,Q2,Q3) and interpret each frequency table carefully
library(haven)
# install.packages("summarytools")

suppressWarnings(library(summarytools))
SAQ8 <- read_sav("SAQ8.sav")
head(SAQ8)

# check the structure of the data frame
str(SAQ8)

# find the frequency of each column
freq(SAQ8$q01, cumul = TRUE, round.digits = 1)

freq(SAQ8$q02, cumul = TRUE, round.digits = 1)

freq(SAQ8$q03, cumul = TRUE, round.digits = 1)
