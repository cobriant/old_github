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
# Plot A: a basic scatterplot with `qplot()`:
qplot(data = US_data, x = gdpPercap, y = lifeExp)

# 1. Replicate plot A using `ggplot()`:
ggplot(data = __, aes(x = __, y = __)) +
  geom_point()
# Notice `ggplot()` wraps x and y in `aes`. We'll talk more about
# that in the next chapter.

#-------------------------------------------------------------------------

# Plot B: a basic scatterplot with a main title and axis labels in `qplot()`:
qplot(data = US_data, 
      x = gdpPercap, 
      y = lifeExp, 
      main = "As GDP per capita increases, so does life expectancy",
      xlab = "GDP per capita",
      ylab = "Life expectancy")

# 2. Replicate plot B with `ggplot()`:
ggplot(data = __, aes(x = __, y = __)) +
  geom_point() +
  labs(x = __, y = __, title = __)
# Notice that with `ggplot()`, to add titles you add `+` a `lab()` label layer.

#-------------------------------------------------------------------------

# Plot C: scatterplot with multiple `geom`s in `qplot()`
qplot(data = US_data, 
      x = gdpPercap, 
      y = lifeExp, 
      geom = c("point", "line", "smooth"))

# 3. Replicate plot C with `ggplot()`:
ggplot(data = __, aes(x = __, y = __)) +
  geom_point() +
  geom_line() +
  geom_smooth()
# Notice that with `ggplot()`, to add multiple `geom`s, you add `+` layers.
