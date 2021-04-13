# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 8: OLS in R

# Run this code to get started.
library(tidyverse)
library(gapminder)
install.packages("broom")
library(broom)

#-------------------------------------------------------------------------

# 1. Simple linear regression: When gdpPercap increases by 1 unit, how much
# do we expect lifeExp to increase by?
# formula: lifeExp ~ \beta_0 + \beta_1 * gdpPercap + error
# First, we'll do a visualization to get a sense of how well our model
# fits our data:
gapminder %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm")

# Run the model using the function `lm()`
model1 <- lm(lifeExp ~ gdpPercap, data = gapminder)
# `tidy()` will give you the most important information in a tibble:
tidy(model1)
# `summary()` will give you lots more information about your model,
# including summaries of residuals and your R-squared.
summary(model1)

# Fill in the blanks with the interpretation:
# When gdpPercap increases by $1, we expect life expectancy to increase by 
# __ years (or __ hours). This result is significant at the __ level.

#-------------------------------------------------------------------------

# 2. The line in (1) doesn't look like a terrific fit. See what happens
# when we take the log of gdpPercap:
gapminder %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10(labels = scales::comma) +
  geom_point() +
  geom_smooth(method = "lm")
# OLS looks much more reasonable with this specification.

# New model: lifeExp ~ \beta_0 + \beta_1 * log(gdpPercap) + error
model2 <- lm(lifeExp ~ log(gdpPercap), data = gapminder)

tidy(model2)
summary(model2)

# Interpretation: When gdpPercap increases by 1%, we expect life expectancy 
# to increase by __ years. This result is significant at the __ level.

#-------------------------------------------------------------------------

# Multiple regression in R is done with `+`:
  # lm(y ~ x1 + x2 + x3, data = .)
# Interaction terms are done with `:` or `*`. These are equivalent:
  # lm(y ~ x1 + x1:x2 + x2, data = .) == lm(y ~ x1*x2, data = .)

# 3. Adding a variable for the number of years since 1950:
# formula: lifeExp ~ \beta_0 + 
#                    \beta_1 * log(gdpPercap) + 
#                    \beta_2 * (year - 1950) +
#                    error

# First, does lifeExp seem to increase linearly with time? Yes, a linear
# model seems to do a fairly good job.
gapminder %>%
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  stat_summary(geom = "point", formula = "median", color = "red") +
  geom_smooth(method = "lm")

# Write the formula to regress `year` and `log(gdpPercap)` on `lifeExp`.
model3 <- gapminder %>%
  mutate(year = year - 1950) %>% 
  lm(__, data = .)

tidy(model3)
summary(model3)

# Interpretation: When gdpPercap increases by 1% in 1970, we expect life 
# expectancy to increase by __ years. 
# This result is significant at the __ level.

#-------------------------------------------------------------------------

# 4. Interactions between variables:
gapminder %>%
  ggplot(aes(x = gdpPercap,  y = lifeExp, color = continent)) +
  scale_x_log10(labels = scales::comma) +
  geom_point(alpha = .2) +
  geom_smooth(method = "lm", se = F)

# formula: lifeExp ~ \beta_0 + 
#                    \beta_1 * log(gdpPercap) + 
#                    \beta_2 * continent + 
#                    \beta_3 * continent:log(gdpPercap) + 
#                    \beta_4 * (year - 1952) +
#                    error
# Actually, the interaction between `continent` and `log(gdpPercap)` 
# really includes an interaction between *every* category of continent
# and the variable `log(gdpPercap)`. So we'll have an estimate for
# continentAmericas:log(gdpPercap), continentAsia:log(gdpPercap),
# etc. R will drop one continent (Africa) to avoid perfect 
# multicollinearity.

model4 <- gapminder %>%
  mutate(year = year - 1950) %>% 
  lm(lifeExp ~ log(gdpPercap)*continent + year, data = .)

tidy(model4)
summary(model4)

# Interpretation: consider a country with a gdpPercap of $10k in 1970.
# What will we predict is its lifeExp to be if it's in Africa? 
#   6.4 + 4.85*log(10,000) + .248*20 = 
#   6.4 + 44.67 + 5 = 56.07 years.
# What if it's in the Americas? __ years.
# What if it's in Asia? __ years.
# What if it's in Europe? __ years.
# What if it's in Oceania? __ years.

#-------------------------------------------------------------------------

# Great work! You've finished the lessons for Lab 3. You should now have
# all the knowledge you need to do a wonderful job on Problem Set 1!
# We'll skip the challenge for this week to give you some extra time to
# work on that assignment.
