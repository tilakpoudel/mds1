die <- 1:6
sample(x=die, size=1)
sample(x=die, size=1, replace = TRUE)

sample(x=die, size=2)
sample(x=die, size=2)
sample(x=die, size = 2, replace = TRUE)

read.csv("D:/Master's/I Semester/Statistical Computing with R/Practical/iris.csv")
set.seed(123)
tt_sample <- sample(c(TRUE,FALSE),nrow(iris),replace=T, prob = c(0.7,0.3))
train <- iris[tt_sample,]
train
test <- iris[!tt_sample,]
test

roll <- function()
{
  die <- 1:6
  dice <- sample(die,size =  2,replace =  TRUE)
  sum(dice)
}
roll()

best_practice <- c("Let", "the", "computer", "do", "the", "work")
print_words <- function(sentence)
{
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}
print_words(best_practice)
print_words(best_practice[-6])
best_practice[-6]

#using for loop
print_words1 <- function(sentence)
{
  for (word in sentence) {
    print(word)
  }
}
print_words1(best_practice)

if(y<20)
{
  x <- "Too low"
}
else
  {
  x <- "Too high"
}

check.y <- function(y)
{
  if(y<20)
  {
    print("Too low")
  }
  else
    {
    print("Too high")
  }
}
check.y(10)
check.y(30)


y <- 1:40
y
ifelse(y<20, "Too low", "Too high")


y <- 1:40
y
ifelse(y<20, 1, 0)


check.x <- function(x=1:99)
{
  if (x<20)
  {
    print("Less than 20")
  }
  else
  {
    if (x<40)
    {
      print("20-39")
    }
    else
    {
      if (x<100)
      {
        print("41-99")
      }
    }
  }
}
check.x(15)
check.x(30)
check.x(45)


x <- 1:99
x3 <- ifelse(x<20, 1, ifelse(x<40,2,3))
x3
table(x3)


iris <- within(iris,
               {
                 Petal.cat <- NA
                 Petal.cat[Petal.Length < 1.6] <- "Small"
                 Petal.cat[Petal.Length >= 1.6 & Petal.Length < 5.1] <- "Medium"
                 Petal.cat[Petal.Length >= 5.1] <- "Large"
               })
summary(iris$Petal.Length)
iris$Petal.cat
table(iris$Petal.cat)
head(iris)


if (temp <= O)
{
  "freezing"
}