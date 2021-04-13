# Intro to the Tidyverse by Colleen O'Briant

# In order to progress, all you need to do is fill in the blanks: __.
# Then run the code (command + enter on a mac) to make sure you're
# getting the desired result.

#-------------------------------------------------------------------------

# Chapter 7: Tidied data

library(tidyverse)

#-------------------------------------------------------------------------
# 1. Download the problem set 1 data from Canvas in .csv format and put the
# file path below. See last week's challenge for more information about
# file paths.
ipums <- read_csv("__")
View(ipums)

# This dataset looks a lot different from `gapminder`. In particular, 
# categorical data like "race" is broken up into several columns with 1's 
# and 0's. This format is useful for some workflows, but doesn't play well 
# with `tidyverse` functions including `ggplot`. For example:

# This ggplot draws just one boxplot, not two for males and females. 
# In this chapter, we'll find out why.
ggplot(data = ipums, 
       aes(x = i_male, y = personal_income, color = i_married)) +
  geom_boxplot() +
  geom_point()

# This ggplot won't run at all, telling us that "a continuous variable can 
# not be mapped to shape". R considers `i_white` to be continuous. We know
# it only takes 1's and 0's. Clearly, the data format is not correct.
ggplot(data = ipums, 
       aes(x = age, y = personal_income, color = i_male, shape = i_white)) +
  geom_point() +
  theme_bw()

# This plot runs, but looking at the legend, `ggplot` indicates i_male 
# can be any number between 0 and 1 inclusive, which is not the case.
ipums %>%
  ggplot(aes(x = age, y = personal_income, color = i_male)) +
  geom_point()

# The issue with all these plots is that the data doesn't have the right
# format. In this section, we'll try to get `ipums` to look more like
# `gapminder` and hopefully play better with `ggplot()`.

#------------------------------------------------------------------------

# 2. The rules for tidied data are simple: each observation is a row and 
# each variable is a column. For `ipums`, verify that each observation 
# (individual in the survey) is represented by exactly one row.

View(ipums)

# Is every variable represented by exactly one column? Not quite. Look
# at `i_asian`, `i_black`, `i_indigenous`, and `i_white`. All these
# express one variable: race. Fill in the blanks in this code to figure out
# if there is anyone who is biracial or multiracial in the dataset.

ipums %>%
  mutate(number_of_races_selected = __ + __ + __ + __) %>%
  filter(number_of_races_selected > 1) %>%
  nrow()

#------------------------------------------------------------------------

# 3. Repeat the same process above to figure out if there is anyone who
# identified both as `i_male` and `i_female`, or if these two variables
# can be easily combined into a categorical variable `gender` which can
# either be "male" or "female".

__

# We'll stop here for now, but you could keep on going: I also have a 
# feeling that there may not be any multilingual people in the dataset, 
# so `i_only_english` and `i_noenglish` could be easily combined.
# And if everyone who graduated college also graduated high school, 
# then `i_grad_college` and `i_grad_highschoool` could be easily collapsed 
# into one variable 'education' with 3 categories: "college", "high school", 
# or "no degree".

#------------------------------------------------------------------------

# 4. To tidy our data, first we'll need to learn about two more useful 
# `dplyr` functions: `if_else()` and `case_when()`.

# The basic usage for `if_else()` is `if_else(condition, true, false)`.
# `if_else()` works on vectors like this:
i_male <- c(1, 1, 0, 0)
if_else(i_male == 1, "male", "female")

# Your turn: take `i_married` and make it more descriptive using `if_else`.
i_married <- c(1, 0, 1, 0)
if_else(__)

# `case_when()`:
# `case_when` is just like `if_else`, but for more than just 2 cases. 
# For instance, suppose for the variable `education`:
# a "0" means the person has no degree, 
# a "1" means they have a high school diploma only, 
# a "2" means they have a bachelor's degree, 
# a "3" means they have a master's,
# and a "4" means they have a PhD.
education <- c(2, 4, 1, 0, 3, 0, 2, 1)
case_when(education == 0 ~ "no degree",
          education == 1 ~ "high school", 
          education == 2 ~ "bachelors",
          education == 3 ~ "masters",
          education == 4 ~ "PhD")

# `if_else` and `case_when` are great to use as helper functions for
# `mutate`:

# Here I create an example tibble:
ipums_example <- tibble(married = c(0, 1, 0, 1, 1, 1),
                        education = c(0, 2, 4, 4, 3, 1))

# Print the tibble for inspection:
print(ipums_example)

# Tidy the data by mutating the variables to be more descriptive,
# and assign it a new name:
ipums_example_tidy <- ipums_example %>%
  mutate(married = if_else(married == 1, "married", "single"),
         education = case_when(education == 0 ~ "no degree",
                               education == 1 ~ "high school", 
                               education == 2 ~ "bachelors",
                               education == 3 ~ "masters",
                               education == 4 ~ "PhD"))

# Does `ipums_example` look more like `gapminder` now?
print(ipums_example_tidy)

#------------------------------------------------------------------------

# 5. In this step, you'll work on tidying `ipums` using `mutate` with
# `if_else()` and `case_when()`, just like in (4).

ipums_tidy <- ipums %>%
  mutate(gender = if_else(i_male == 1, __, __),
         race = case_when(i_white == 1 ~ __,
                          i_black == 1 ~ __,
                          i_indigenous == 1 ~ __,
                          i_asian == 1 ~ __)) %>%
  # In the next line, I remove the variables we no longer need with "-".
  select(-c(i_male, i_female, i_black, i_white, i_indigenous, i_asian))

# Scroll all the way to the right to see the 2 new variables we created.
View(ipums_tidy)

#------------------------------------------------------------------------

# 6. How does `ggplot()` play with our tidied variables? Pretty nicely!

ggplot(ipums_tidy, aes(x = race, y = personal_income, color = gender)) +
  geom_boxplot()

ggplot(ipums_tidy, aes(x = age, y = personal_income, color = gender)) +
  geom_smooth(se = FALSE)

ggplot(ipums_tidy, aes(x = age, y = personal_income, color = race)) +
  geom_smooth(se = FALSE)

#------------------------------------------------------------------------