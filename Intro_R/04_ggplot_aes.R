# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 4: `ggplot()` aesthetic mappings (`aes`)
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
#    using `facet_wrap`. The tilde `~` can be read as "by". So by adding
#    a facet layer, we "facet by continent". Make sure to take a look at the plot.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  facet_wrap(~ continent)

# 1. Change the plot above to facet by `year` instead of faceting by `continent`.

__

# 2. Instead of faceting, change the plot to use `color` to differentiate the 
#    `continent`. So all the points in Africa will be red, Europe will be blue, 
#    etc. This is an `aes`thetic mapping because we're taking a variable 
#    `continent` and mapping it to the visual element of `color`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = __)) +
  geom_point()

# 3. `color` is a very useful aesthetic mapping which changes the outline color.
#   Another useful aesthetic mapping is `fill`, which changes the fill color.
#   To see both the `color` and the `fill` of a point, I'll use `shape = 21`: points
#   with outlines.
#   Use `color` and `fill` to represent different variables in the dataset:
#   try `continent`, `year`, and `pop`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = __, fill = __)) +
  geom_point(shape = 21)

# 4. A third aesthetic mapping is `shape`. We actually just used `shape` in 3., 
# outside of the `aes` call. That set the shape of the points to a fixed value 
# (shape 21: points with outlines). Observe what happens when you map `shape` 
# to `continent` *inside* of the `aes()` call.
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(shape = __))

#-------------------------------------------------------------------------

# In the last example, we specified an `aes` in the `ggplot()` call *and*
#   in the `geom_point()` call. It turns out that all layers will *inherit*
#   data and aesthetic mappings from the `ggplot()` call, so all of these plots
#   do the same thing:
# You can put all information in the `ggplot()` call:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, shape = continent)) +
  geom_point()
# Put some information in the `ggplot()` call and some in the `geom_point()` call:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(shape = continent))
# Put all information in the `geom_point()` call:
ggplot() +
  geom_point(data = gapminder, aes(x = gdpPercap, y = lifeExp, shape = continent))
# But warning: if you have multiple `geom`s and put all information in one of them,
# the other `geom` won't inherit that information.
# In this example, the `geom_smooth()` doesn't get drawn because it doesn't inherit
# any of the information it needs from `ggplot()`.
ggplot() +
  geom_point(data = gapminder, aes(x = gdpPercap, y = lifeExp, shape = continent)) +
  geom_smooth()
# A fix: give geom_line() the information it needs by way of `ggplot()`:
#   I leave the shape aesthetic mapping in `geom_point()` because `geom_smooth()`
#   can't make different shapes based on continent.
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(shape = continent)) +
  geom_smooth()

#-------------------------------------------------------------------------

# 5. So far we have 3 aesthetic mappings other than x and y axis: 
#    they are `color`, `fill`, and `shape`.
#    The last `aes` we'll talk about is `size`, which adjusts point size.
#    Add 2 `aes` to this plot: map `continent` to `color`, and map `pop` to `size`.
#    How many legends are there now?
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(__)
