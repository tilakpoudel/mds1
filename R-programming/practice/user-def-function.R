# define function
roll <- function() {
  die <- 1:6
  # size = 2 => it means 2 dices are rolled
  dice <- sample(die, size = 2, replace=TRUE)
  
  # get the sum of result of 2 dice
  sum(dice)
}

# call function
roll()
roll()
roll()

# with parameter
roll2 <- function(die = 1:6) {
  # size = 2 => it means 2 dices are rolled
  dice <- sample(die, size = 2, replace=TRUE)
  
  # get the sum of result of 2 dice
  sum(dice)
}

roll2()


# with parameter
roll3 <- function(dice) {
  # size = 2 => it means 2 dices are rolled
  dice <- sample(dice, size = 2, replace=TRUE)
  
  # get the sum of result of 2 dice
  sum(dice)
}

roll3(dice = 1:6)
roll3(dice = 1:12)
roll3(dice = 1:24)


best_practice <- c("Let", "the", "computer", "do", "the", "work")
print_words <- function(sentence) {
  
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
  
}
print_words(best_practice) # [1] ”Let” [1] “the” [1] “computer” [1] “do” [1] “the” [1] “work”
print_words(best_practice[-6]) # [1] ”Let” [1] “the” [1] “computer” [1] “do” [1] “the” [1] “NA”
best_practice[-6]