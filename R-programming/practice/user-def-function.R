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
