# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 3: `qplot()` to `ggplot()`

  # The tidyverse ecosystem has 2 great ways to do plots: they are
  # `qplot()` and `ggplot()`. You've already made some qplots.
  # `ggplot()` is just like `qplot()`, but it gives you a little more
  # control.

# Run this code to get started and to take a look at the data:
library(tidyverse)
install.packages("gapminder")
library(gapminder)
US_data <- filter(gapminder, country == "United States")
View(US_data)

#-------------------------------------------------------------------------

# First, we'll review `qplot()`:
# Plot A: basic scatterplot
qplot(data = US_data, x = gdpPercap, y = lifeExp)

# Plot B: basic scatterplot with main title and axis labels
qplot(data = US_data, 
      x = gdpPercap, 
      y = lifeExp, 
      main = "As GDP per capita increases, so does life expectancy",
      xlab = "GDP per capita",
      ylab = "Life expectancy")

# Plot C: scatterplot with titles and 3 `geom`s
qplot(data = US_data, 
      x = gdpPercap, 
      y = lifeExp, 
      main = "As GDP per capita increases, so does life expectancy",
      xlab = "GDP per capita",
      ylab = "Life expectancy",
      geom = c("point", "line", "smooth"))

# Your task: replicate Plot A-C using `ggplot()`.
# 1. Plot A: basic scatterplot
ggplot(data = __, aes(x = __, y = __)) +
  geom_point()

# 2. Plot B: basic scatterplot with main title and axis labels
ggplot(data = __, aes(x = __, y = __)) +
  geom_point() +
  labs(x = __, y = __, title = __)

# 3. Plot C: scatterplot with titles and 3 `geom`s
ggplot(data = __, aes(x = __, y = __)) +
  geom_point() +
  geom_line() +
  geom_smooth() +
  labs(x = __, y = __, title = __)

# 2 important things to notice about `ggplot()`:
#   1. `aes()`: we'll talk about what this means in the next chapter
#   2. layers like `labs()` and `geom_point()` are added using `+`.
