# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 5: `ggplot()` `geom`s
#   In this chapter, we'll practice using some of the most commonly used 
#   `geom`s, one by one. Keep in mind that you can use multiple `geoms` at 
#   a time by layering them on top of each other.

# Run this code to get started and to view the data:
library(tidyverse)
library(gapminder)
View(gapminder)

#-------------------------------------------------------------------------

# Use these `geom`s when you want to look at the distribution of one 
# variable.

# 1. Draw a histogram using `geom_histogram()`. It will use stacking 
# with multiple groups. Change this stacking behavior with 
# `geom_histogram(position = "identity")`. Experiment with different binwidths.
ggplot(data = gapminder, 
       aes(x = lifeExp, color = continent, fill = continent)) +
  __(binwidth = __)

# 2. `geom_freqpoly()` is just like a histogram, but it uses lines 
# instead of bars to communicate the number of observations in each
# bin. Experiment with binwidth.
ggplot(data = gapminder, aes(x = lifeExp, color = continent)) +
  __(binwidth = __)

# 3. You can make a filled frequency polygon using an area plot:
#`geom_area()`. Change the default stacking behavior as you did in 1.
# Experiment with alpha.

ggplot(data = gapminder, aes(x = lifeExp, fill = continent)) +
  __(stat = "bin", binwidth = 5, alpha = .7)

# 4. Draw a dotplot for `lifeExp` using `geom_dotplot()`. Experiment
# with using `fill = continent` and leaving it out.
ggplot(data = gapminder, aes(__)) +
  __

# 5. `geom_density()`: An alternative to bin visualizations is 
# density visualizations. They smooth out the distributions and 
# account for factors like the fact that there are so many fewer 
# observations from Oceania, but the y-axis is less intuitive than 
# `count`. Experiment with color` and `fill`.
ggplot(data = gapminder, aes(x = lifeExp, __)) +
  __(alpha = .3)

# Next we'll quickly practice using some graphical primitives:
# You can add a vertical line to your plot with `geom_vline()`,
# a horizontal line with `geom_hline()`,
# a line segment with `geom_segment()`,
# a rectangle with `geom_rect()`,
# and you can even annotate your plot with `annotate()`.

# 6. Add a vertical line to this plot with `xintercept = 75`.
ggplot(data = gapminder, aes(x = lifeExp, 
                             color = continent, 
                             fill = continent)) +
  geom_density(alpha = .3) +
  __

# 7. Take the plot above and annotate it by adding a label for 70 years.
ggplot(data = gapminder, aes(x = lifeExp, 
                             color = continent, 
                             fill = continent)) +
  geom_density(alpha = .3) +
  __ +
  __("text", x = __, y = __, label = "70 years", angle = 90)

# Next we'll practice some `geom`s for plots with 2 variables.

# 8. You've already seen a basic scatterplot. Try to recall how to
# draw a `ggplot` that plots gdpPercap on the x-axis and lifeExp
# on the y-axis, and maps continent to color.

__

# 9. There are 2 outstanding issues with the basic scatterplot here.
# The first: the data is fanned out for `gdpPercap` 
# (heteroskedasticity). Quick fix: apply a log transformation.
# You can use `x = log(gdpPercap)` or add the layer `scale_x_log10()`.
# I prefer the second, because it keeps the numbers on the x-axis
# in normal units, not log units. I also like to use 
# `labels = scales::comma` which suppresses scientific notation.
# The second issue: overplotting. We'd like to see how dense the
# points are in the center. For that, you can use `geom_hex()`.
# Experiment with `geom_hex(bins = __)`.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10(labels = scales::comma) +
  geom_hex()

# 10. Draw a line plot using `geom_line`. Compare US `gdpPercap` over 
# time to two other countries of your choice.

ggplot(data = filter(gapminder, country %in% c("United States", 
                                               __, 
                                               __)), 
       aes(x = year, y = gdpPercap, color = country)) +
  geom__

# 11. Draw a boxplot with `geom_boxplot()` that compares the 
# gdpPercap (on the y-axis) of different continents (on the x-axis, 
# also using color). Experiment with applying a log transformation
# to gdpPercap (now on the y-axis).

ggplot(data = gapminder, aes(x = __, y = __, color = __)) +
  __

# 12. Change the plot from 11. to be a violin plot using `geom_violin`.
# Also include `fill`.

ggplot(data = gapminder, aes(x = __, y = __, color = __, fill = __)) +
  scale__ +
  __

# Finally, check out how simple it is to change your `facet_wrap` to 
# a slick animation with `gganimate`!
# The `facet_wrap` version:
ggplot(data = gapminder, 
       aes(x = log(gdpPercap), y = lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_density2d(color = "grey", alpha = .5) +
  facet_wrap(~ year)
# The animated version (this may take a second to render)
install.packages("gganimate")
library(gganimate)
ggplot(data = gapminder, 
       aes(x = log(gdpPercap), y = lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_density2d(color = "grey", alpha = .5) +
  gganimate::transition_time(year) +
  labs(title = "Year: {frame_time}")

# This lesson is only the tip of the iceburg when it comes to `ggplot`!
# If you want to become a `ggplot()` pro, check out https://ggplot2-book.org/introduction.html
