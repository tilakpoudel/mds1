age <- 1:99

check_age <- function(age) {
  if (age <= 15) {
    print("Children")
  } else {
    if (age <= 65) {
      print("Working group")
    } else {
      print("Senior citizen")
    }
  }
}

check_age(10)
check_age(52)
check_age(70)

check_age1 <- function(age) {
  if (age <= 15) {
    print("Children")
  } else if(age > 15 && age <= 65) {
      print("Working group")
  } else {
    print("Senior citizen")
  }
}

check_age1(101)
check_age1(52)
check_age1(70)

check_age12 <- function(age) {
  result <- ifelse(
    age<=15, "child", 
    ifelse(
      (age > 15 && age <= 65), "Working", "senior")
    )
  print(result)
}

check_age12(101)
check_age12(52)
check_age12(70)
