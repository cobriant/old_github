# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 6: dplyr part 1
#  `dplyr` is a package for data manipulation included in the tidyverse.
#  We'll cover a few of the basic `dplyr` functions in this chapter, and 
#  follow up with the rest later.

# In this chapter, you'll learn:
# `filter()`
# `%>%` the pipe operator 
# `select()`
# `mutate()`

# Run this code to get started and to view the data:
library(tidyverse)
library(gapminder)
View(gapminder)

#-------------------------------------------------------------------------

# 1. `filter()`
# In chapter 2, you learned that you can select certain rows from a tibble
# using square brackets like this:
gapminder[1, 1:6]
# But what if you wanted to select all the rows of the tibble that satisfy
# some condition, like all the observations from Asia in the year 1952?
# You can use `filter()` for that. Just like in lesson 1, character strings
# need quotes but numbers don't.
filter(.data = gapminder, continent == "Asia", year == 1952)
# `filter()` will always expect the first argument to be the tibble. So
# typing `.data =` is unnecessary. Functions match arguments positionally
# as well as by name like this:
filter(gapminder, continent == "Asia", year == 1952)
# Your turn: `filter()` `gapminder` for all the observations from Europe 
# in 2007.
__

#-------------------------------------------------------------------------

# 2. Logical Operators
# The operator `==` reads "is equal to".
# That's not the only logical operator you can use with `filter()`.
# `!=`: "not equal to"
# `>`, `>=`, `<`, `<=`: "greater than", "greater than or equal to", etc.
# `&`, `|`: means "and", "or"
# `%in%`: means "in"

# 2.1 `filter()` gapminder for a short list of the richest countries in 
# Asia.
filter(gapminder, continent == __, gdpPercap __ 30000)

# 2.2 `filter()` gapminder for observations in the United States, Germany,
# and Brazil:
filter(gapminder, country __ c("United States", "Germany", "Brazil"))

# 2.3 `filter()` gapminder for the largest countries by population in 1952 
# and in 2007. If a country had one of the largest populations in 2007,
# was it likely to have one of the largest populations in 1952?
filter(gapminder, year == __ | year == __, pop __ 100000000)

#-------------------------------------------------------------------------

# 3. The pipe operator: `%>%`
  # Oftentimes, we need to compose several functions like this:
head(filter(gapminder, continent == "Asia", year == 1952), n = 20)
  # This will `filter()` `gapminder` on countries in Asia in the year 1952,
  # and then `head()` will select only the first few rows (we've
  # specified we want 20 rows with `n = 20`).
  # The more functions we need to compose, the more confusing it will look.
  # We should always strive to write code that's readable and clear.
  # Piping helps with that.

  # This is the pipe operator: `%>%`
  # You put it at the end of a line.
  # The pipe takes whatever came before it and composes it into the next
  # function, in place of the period: `.`

# So this code:
head(filter(gapminder, continent == "Asia", year == 1952), n = 20)
# does the same thing as this:
gapminder %>%
  filter(., continent == "Asia", year == 1952) %>%
  head(., n = 20)
# If you don't put a period `.` anywhere, the pipe will assume you want
# it as the first argument. So this also does the same thing:
gapminder %>%
  filter(continent == "Asia", year == 1952) %>%
  head(n = 20)

# Notice piping allows us to read the code top to bottom instead of 
# inside out. You can pronounce the pipe as "then". As in, "take gapminder,
# then filter it, then take the first 20 rows of the tibble with head."

# 3.1 Use pipes to find the number of observations in Asia.
__ %>%
  filter(__ == __) %>%
  nrow()

# 3.2 Use pipes to view all the data with life expectancies greater than 80.
__ %>%
  filter(__) %>%
  View()

# 3.3 Use pipes and `head()` to select the first 15 observations with 
# life expectancies greater than 80.
__ %>%
  filter(__) %>%
  head(n = __)

# 3.4 Use pipes and `tail()` instead of `head()` to select the last 5 
# observations with life expectancies greater than 80.
__ %>%
  filter(__) %>%
  tail(n = __)

#-------------------------------------------------------------------------

# 4. `select()`
# The function `select()` lets you select columns (variables) of a tibble
# by name. No quotes are necessary.
gapminder %>%
  select(country, continent, year)

# 4.1: Select the last 3 variables of `gapminder` by name:
gapminder %>% 
  select(__, __, __)

# Previously we learned that you can select a single column by name using
# the `$` syntax. This will output a *vector*.
gapminder$gdpPercap
# But using `select()` will output a *tibble*, even if it's only a tibble
# with a single variable.
gapminder %>%
  select(gdpPercap)
# This distinction matters because many `tidyverse` functions (like `ggplot`)
# will only accept tibbles, not vectors.
# For example, this code works because `select(gapminder, gdpPercap)` is a 
# tibble:
gapminder %>%
  select(gdpPercap) %>%
  ggplot(aes(x = gdpPercap)) +
  geom_histogram()
# But this code *doesn't work* because `gapminder$gdpPercap` is a vector.
gapminder$gdpPercap %>%
  ggplot(aes(x = gdpPercap)) +
  geom_histogram()

# Check out `?select` for more information on `select` functionalities.

#-------------------------------------------------------------------------

# 5. `mutate()`
# Use `mutate()` to create new variables that are transformations of other
# variables in your tibble. For example, we can create a variable called
# `total_gdp` that is the product of `pop` and `gdpPercap`.
# I've piped it into `View()` so you can verify that it worked.
gapminder %>%
  mutate(total_gdp = pop*gdpPercap) %>%
  View()

# You may want to re-assign `gapminder` to be the mutated version, like this:
gapminder <- gapminder %>%
  mutate(total_gdp = pop*gdpPercap)

# Now check to make sure `total_gdp` is added to `gapminder`:
View(gapminder)

# 5.1 Use `mutate()` to create a new variable `pop_in_thousands`. So if the
# observation has population = 97,462, then pop_in_thousands will be 97.462.
gapminder %>%
  mutate(__)

# 5.2 Assign `gapminder_pop` to be a version of `gapminder` with 
# `pop_in_thousands` in it.
__ <- __ %>%
  mutate(__)

# Check out `?mutate` for more information on `mutate` functionalities.

#-------------------------------------------------------------------------