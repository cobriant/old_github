# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 4: `ggplot()` aesthetic mappings (aes)
#   Aesthetic mappings take variables in your data and map them to
#   visual elements in your plot.

# Run this code to get started and to view your data:
library(tidyverse)
library(gapminder)
View(gapminder)

#-------------------------------------------------------------------------

# When you declare which variable should be represented on each axis,
#    you're using an *aesthetic mapping*. That's why `x = ` and `y = ` are
#    wrapped in `aes()`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Each point in the scatterplot above represents a certain country in a 
#    certain year. We can easily create different plots for each `continent`
#    using `facet_wrap`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  facet_wrap(~ continent)

# 1. Change the plot above to draw different plots for each `year` in the data.

# 2. If we wanted to compare all continents on the same plot, we could use
#    `color` to differentiate between the continents. For example, all the 
#    points in Africa will be red, Europe will be blue, etc.
#    This is also an `aes`thetic mapping because we're taking a variable in
#    our dataset (`continent`), and mapping it to the visual element of `color`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, __ = __)) +
  geom_point()

# 3. Some `geom`s also accept the `aes` `fill` as well as `color`.
#    Enter `color` and then enter `fill` in the blank spot below and observe
#    what happens. Try both at the same time. 
#    Note, I've specified `alpha = .5`, which reduces transparency to 50%.

ggplot(data = gapminder, aes(x = lifeExp, __ = continent)) +
  geom_density(alpha = .5)

# 4. For some `geom`s like `geom_point()`, `shape` is another aesthetic mapping.
#    Observe what happens when you make `continent` map to `shape`.
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(__ = __))

# 5. The last aesthetic mapping we'll talk about is `size`. For `geom_point()`,
#    `size` will adjust the point size.
#    Add 2 `aes` to this plot: map continent to color, and map pop to size.
#    How many legends are there now?
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(__), alpha = .5)
