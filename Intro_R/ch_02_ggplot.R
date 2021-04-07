# Intro to the Tidyverse by Colleen O'Briant

# Chapters 3, 4, and 5 taught you a little about using `ggplot()` with the 
#  `gapminder` dataset.
# This short challenge will give you practice using `ggplot()` on a dataset
#   similar to the one you'll use in problem set 1 (due April 24).

#------------------------------------------------------------------------

# Challenge 2: using `ggplot()`

# Run this code to get started:
library(tidyverse)

#------------------------------------------------------------------------

# 1. Make sure you've downloaded the data for the exercise.
# Then read the data into R by entering the absolute path of the data 
# on your computer in the blank below:

ipums <- read_csv("__")

# You can find the absolute path by right-clicking on the file.
# For me on a mac, assuming I downloaded the file into my Downloads folder,
#   the absolute path is this: "~/Downloads/ipums_tidy.csv"
# If you're on a windows computer, it may look something like this:
#   "C:/Users/your_username_here/Downloads/ipums_tidy.csv"

# I'll call the dataset "ipums" because that's the database the data
# came from: https://en.wikipedia.org/wiki/IPUMS

# 2. Take a look at your data:
View(ipums)

# 3. Your task: make 3 plots using `ggplot()` to visualize data about 
# the gender wage gap or the racial wage gap.
# Questions to explore:
#  * Do these wage gaps increase or decrease with age?
#  * Is the wage gap larger or smaller for married people?
#  * Is the wage gap larger or smaller for college graduates?
#  * Is the wage gap larger in urban areas versus rural?
#  * Is the wage gap larger for non-citizens as opposed to citizens?
#  * What about different combinations of any of the above factors?
     
# Requirements:
#  * Use at least 4 different `geom`s across your 3 plots
#  * For at least one plot, use `color` or `fill` as an aesthetic mapping
#  * Give your plots titles or subtitles to explain your main findings.
#  * Be creative and have fun!

# When you're done, submit them here: https://forms.gle/GKyuV9kn4JWCTKBy9
