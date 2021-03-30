# Intro to the Tidyverse by Colleen O'Briant

  # In order to progress, all you need to do is fill in the blanks: __.
  # Then run the code (command + enter on a mac) to make sure you're
  # getting the desired result.

#-------------------------------------------------------------------------

# Chapter 1: vectors

  # In R, data is held in vectors.
  # One way to construct a vector is to use the function 'c()'.
  # 'c()' is short for "combine": you can combine elements into a vector.

#-------------------------------------------------------------------------
  
# 1. Make the first element of this numeric vector '6'.

c(__, 4, 5, 2, 3)

#-------------------------------------------------------------------------

# 2. Make the third element of this character vector 'economics'.

c("apple", "banana", __)

#-------------------------------------------------------------------------

# 3. You can do all kinds of calculations on vectors.
#    If you fill in the blank correctly, when you run these lines,
#    R will print TRUE.

min(c(6, 3, 2)) == __

sum(c(6, 3, 2)) == __

c(6, 3, 2) + c(3, 2, 1) == c(__, __, __)

2 * c(6, 3, 2) == c(__, __, __)

c(6, 3, 2) * c(0, 0, 1) == c(__, __, __)

#-------------------------------------------------------------------------

# 4. We can use square brackets to select certain elements of a vector.
#    So c(4, 5, 6)[1] == 4.
  
c(6, 3, 2)[1] == __

c(6, 3, 2)[3] == __

#-------------------------------------------------------------------------

# 5. If you want to create a vector of consecutive numbers like 
#    `c(1, 2, 3)`, the shorthand is `1:3`.

c(1, 2, 3) == 1:3

c(1, 2, 3, 4) == __:__

c(6, 3, 2, 5, 5)[2:4] == c(__, __, __)
