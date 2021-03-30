# Intro to the Tidyverse by Colleen O'Briant

  # In order to progress, all you need to do is fill in the blanks: __.
  # Then run the code (command + enter on a mac) to make sure you're
  # getting the desired result.

#-------------------------------------------------------------------------

# Chapter 2: tibble()
  
  # In the previous chapter, we learned how to hold data in vectors.
  # This chapter is all about holding data in 2-d tables.
  # These are called "tibbles" in the tidyverse.
  
  # Run this code to get started:

install.packages("tidyverse", dependencies = T)
library(tidyverse)
US_data <- tibble(year      = c(1957, 1977, 1997, 2017),
                  gdpPercap = c(14847, 24073, 35767, 60062),
                  lifeExp   = c(69.5, 73.4, 76.8, 78.5))

# Here's what this tibble tells us:
  # In 1957, US GDP per capita was $14,847 and life expectancy was 69.5 years.
  # In 1977, US GDP per capita was $24,073 and life expectancy was 73.4 years.
  # In 1997, US GDP per capita was $35,767 and life expectancy was 76.8 years.
  # In 2017, US GDP per capita was $60,062 and life expectancy was 78.5 years.
  
#-------------------------------------------------------------------------
  
# 1. Two ways to see the tibble:
#    The first way is to print the tibble to the console.

US_data

# A tibble: 4 x 3
#    year  gdpPercap lifeExp
#    <dbl>    <dbl>    <dbl>
# 1  1957     14847    69.5
# 2  1977     24073    73.4
# 3  1997     35767    76.8
# 4  2017     60062    78.5

#    The second way is to use `View()` to look at the data in a separate tab.

View(US_data)

#-------------------------------------------------------------------------

# 2. How many rows and columns does the tibble have?

nrow(US_data) == __
ncol(US_data) == __

#-------------------------------------------------------------------------
  
# 3. You can select an element of a tibble using square brackets.
#    For instance, the element in the third row and first column is
#    selected like this: US_data[3, 1].

US_data[__, __] == 35767

US_data[__, __] == c(69.5, 73.4, 76.8, 78.5)

#-------------------------------------------------------------------------

# 4. Note that `US_data` has column names. You can get the column names
#    of a tibble using `colnames()`

colnames(US_data) == c("year", "gdpPercap", __)

#-------------------------------------------------------------------------

# 5. You can select elements of `US_data` by referring to the column name
#    instead of the position.
#    For instance, `US_data[1, "year"]` will get you the first element of `year`.

US_data[__, "__"] == 60062

# The dollar sign `$` syntax lets you select entire columns by name, 
# without any quotes required: 

US_data$year == c(1957, 1977, 1997, __)

#-------------------------------------------------------------------------

# 6. Fill in the blanks:

#  The average GDP per capita in the data is:
mean(__$__) == __

# The median life expectancy is:
median(__$__) == __

# The maximum year is:
max(__$__) == __

