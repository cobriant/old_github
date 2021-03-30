# Intro to the Tidyverse by Colleen O'Briant

  # Chapter 1 and 2 were all about vectors and tibbles: the structures
  # that hold your data in R.
  # This short challenge will introduce you to visualizing data from a 
  # tibble.

#------------------------------------------------------------------------

# Challenge 1: visualize the data with `qplot()`!

# Run this code to get started:
library(tidyverse)
US_data <- tibble(year      = c(1957, 1977, 1997, 2017),
                  gdpPercap = c(14847, 24073, 35767, 60062),
                  lifeExp   = c(69.5, 73.4, 76.8, 78.5))

# To visualize how US GDP per capita has grown over the past 50 years,
# we can use `qplot()`, which stands for "quick plot".

qplot(x = year, y = gdpPercap, data = US_data)

# You could also visualize how US life expectancy has increased, or
#       how GDP per capita is correlated with life expectancy.

# Look over the help docs for `qplot()` with this:
?qplot

# You'll find that `qplot()` takes many arguments, including: 
#    `x` and `y` (which variable goes on which axis), 
#    `data` (a tibble),
#    `geom` (a character vector specifying what geom to draw, see below),
#    `xlab`, `ylab`, and `main` (labels for the axis and main title).

# Your task: do 3 nice visualizations of `US_data`: one for GDP per capita
#    over time, one for life expectancy over time, and one comparing
#    GDP per capita and life expectancy.
#    The plot details are totally up to you, but your plots must have:
#    At least 2 geoms:
#    (a complete list is here: https://ggplot2.tidyverse.org/reference/),
#    labels for the x and y axis, 
#    and a title for the plot.
#    Submit the code for your final plot here before Thursday.
#         https://forms.gle/TPpXvMYpbM8ymbQp8
#    Have fun and be creative :)

# Note: try not to google examples of `qplot()` until you've given it an
#   honest try. If you do that and still want some extra inspiration, then
#   this is an instance where googling is OK.
