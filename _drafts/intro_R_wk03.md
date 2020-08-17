---
title: "Week 3"
subtitle: "Data Visualization with ggplot2"
output: html_document
author: 
 - name: Colleen O'Briant
   affiliation: University of Oregon
date: "`r format(Sys.time(), '%B %d %Y')`"
---<style>
  .col2 {
    columns: 2 200px;         /* number of columns and width in pixels*/
    -webkit-columns: 2 200px; /* chrome, safari */
    -moz-columns: 2 200px;    /* firefox */
  }
  .col3 {
    columns: 3 100px;
    -webkit-columns: 3 100px;
    -moz-columns: 3 100px;
  }
</style>
`ggplot2` is a package included in the `tidyverse` that’s great for data
visualization.

Today we’ll learn `ggplot2` basics:

-   take data and build a scatterplot
-   customize the plot with titles, labels, and themes
-   fit a line to the data
-   work with things called aesthetic mappings, scales, and more!

<!-- -->

    library(gapminder)
    library(tidyverse)

<br><br>

Basic plot: `ggplot() + geom_point()`
-------------------------------------

Take some data and build a scatterplot.

    ggplot(data = gapminder) +
      geom_point(mapping = aes(x = gdpPercap, y = lifeExp))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-2-1.png)

<br>

Run `?ggplot` in your console to see the help docs for ggplot. There’s a
lot of info there. We learn:

-   `ggplot()` initializes a ggplot object.
-   the argument `data` needs a `"data.frame`" object. We’re in luck,
    because `gapminder` is a `"tbl"` and a `"data.frame"`.

Then we’ll add `+` `geom_point()` to draw a scatterplot:

-   We could have used lots of other `geoms`: there’s `geom_line()`,
    `geom_boxplot()`, `geom_histogram()`, etc. We’ll get to those later.
-   The first `aes`thetic mapping we’ll do is to map the variable
    `lifeExp` to the **x-axis** and `gdpPercap` to the **y-axis** of our
    plot.
-   An `aes`thetic mapping takes a variable in the `data` and maps it to
    an `aes`thetic in the plot.

<!-- -->

    # Note: I'll take advantage of positional matching 
    # to make my code easier to read sometimes:
    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp))

### Exercise 1

> **Exercise 1**: Draw a scatterplot that plots `year` on the x-axis and
> `lifeExp` on the y-axis. Does it seem like countries have had higher
> life expectancies over time?

### Answer

    # Exercise 1 answer
    ggplot(gapminder) +
      geom_point(aes(x = year, y = lifeExp))

    # Actually using `geom_boxplot()` makes more sense and is more visually informative. Note that we have to set `x = as.factor(year)` instead of just `x = year`.
    ggplot(gapminder) +
      geom_boxplot(aes(x = as.factor(year), y = lifeExp))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-5-1.png)

<br><br><br><br>

Add labels: `+ labs()`
----------------------

Next we’ll add a title and adjust the labels on the x- and y-axis.

    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(
        title = "GDP per capita correlates with life expectancy", 
        x = "GDP/capita", 
        y = "life expectancy"
        ) +
      theme(text = element_text(size = 10))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-6-1.png)

Check out `?labs`:

-   `labs()` arguments:
    -   `...` : a list of name-value pairs where name is an `aes`thetic.
        We use the fact that `x` and `y` are plot `aes`thetics, and we
        give them values `"GDP/capita"` and `"life expectancy"`.
    -   `title`: we set as
        `"GDP per capita correlates with life expectancy"`
    -   `subtitle`
    -   `caption`
    -   `tag`

Good titles explain something about what your plot means. However, that
oftentimes leads to long titles. Since my title was running off the
page, I decided to adjust the global font size. I did that with the
`theme()` call.

See the next section for more info on `theme()`!

### Exercise 2

> **Exercise 2**: Take the `life expectancy over year` boxplot from the
> answer to Exercise 1 and add a title, caption, and tag.

### Answer

    # Exercise 2 answer
    ggplot(gapminder) +
      geom_boxplot(aes(x = as.factor(year), y = lifeExp)) +
      labs(title = "Global life expectancy is leveling off", caption = "data: gapminder", tag = "Week 3")

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-7-1.png)

<br><br><br><br>

More `theme()`
--------------

    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(
        title = "GDP per capita correlates with life expectancy", x = "GDP/capita", y = "life expectancy") +
      theme(
        text = element_text(size = 10, color = "purple"),
        rect = element_rect(fill = "pink"),
        line = element_line(color = "black", size = 3),
        panel.background = element_rect(fill = "green")
        )

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-8-1.png)

What else can we do with `theme()`? Check out `?theme`

-   There’s a *ton of arguments*.
-   The main ones are the first 3: `line`, `rect`, and `text`.
    -   Other arguments inherit elements from these first arguments.
    -   For example, we made all the text in our plot purple and point
        size 10 when we did this:
        `text = element_text(size = 10, color = "purple")`
    -   If you only wanted to make the title size 10 and purple, you
        could instead do this:
        `plot.title = element_text(size = 10, color = "purple")`.
    -   But if `plot.title` is left unspecified, it will inherit
        elements from `text`.
-   The exception is that `panel.background` doesn’t inherit like it
    should from `rect`. It’s a
    [bug](https://github.com/tidyverse/ggplot2/issues/880).
-   As you can see, it’s easy to create some **awful** looking things.
    So for now we’ll use a preset theme. Type in your console `theme_`
    to see the options `ggplot2` has.

<br><br><br><br>

Presets: `theme_*`
------------------

    # `theme_bw()`
    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_bw() # 👈 😀 👈 

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-9-1.png)

    # `theme_minimal()`
    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_minimal() # 👈 🙂 👈 

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-10-1.png)

    # `theme_void()`
    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_void() # 👈 😶 👈 

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-11-1.png)

<br><br><br><br><br>

Fit a line: `+ geom_smooth()`
-----------------------------

    ggplot(gapminder) +
      geom_point(aes(x = gdpPercap, y = lifeExp)) +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_minimal() +
      geom_smooth(aes(x = gdpPercap, y = lifeExp)) # 👈 😑 👈 

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-12-1.png)

`geom_smooth()` does smoothed conditional means. Here, it adds another
layer of graphics on top of the scatterplot.

-   Check out `?geom_smooth`
-   Use `geom_smooth(method = lm)` to get a straight line (OLS)

The `geom` will inherit `data` and also `aes`thetic mappings from the
`ggplot` call. So for cleaner looking code I can write this:

    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point() +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_minimal() +
      geom_smooth() # 👈 😮 👈 

<br><br><br><br>

Scales: `scale_x_log10()`
-------------------------

The scatterplot is fan-shaped, which is a sign you might want to take
the log of one (or both) of the axes. Here are 2 techniques that will
lead to almost the same result.

    # Take the log of the variable: aes(log10(gdpPercap))
    ggplot(gapminder, aes(x = log10(gdpPercap), y = lifeExp)) + # 👈 😀 👈 
      geom_point() +
      labs(x = "log GDP/capita", y = "life expectancy") +
      theme_minimal() +
      geom_smooth(method = lm)

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-14-1.png)

<br>

    # Rescale with `+ scale_x_log10()`
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point() +
      labs(x = "GDP/capita", y = "life expectancy") +
      theme_minimal() +
      geom_smooth(method = lm) +
      scale_x_log10(labels = scales::comma) # 👈 😀 👈 use labels = scales::comma to suppress scientific notation here

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-15-1.png)

> Note the difference in the breaks on the x-axis. log10(1000) = 3, but
> log GDP/cap = 3 is harder to decipher than GDP/cap = 1,000.

<br><br><br><br>

Color to represent `continent`
------------------------------

Next I want to color the points by continent. That’s another `aes`thetic
mapping. Just like `gdpPercap` is mapped to `x` and `lifeExp` is mapped
to `y`, we can map `continent` to `color`.

    # geom_point(aes(color = continent))
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent)) + # 👈 😍 👈 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm) + 
      scale_x_log10(labels = scales::comma)

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-16-1.png)

### Exercise 3

> **Exercise 3**: Instead of mapping `continent` to `color`, map
> `continent` to `shape`. What’s the default `shape` scale?

### Answer

    # Exercise 3 answer
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(shape = continent)) + # 👈 😍 👈
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm) + 
      scale_x_log10(labels = scales::comma)

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-17-1.png)

<br><br>

Color to fixed value
--------------------

Suppose instead of mapping `continent` to `color`, I wanted to color
**all the dots pink**. That’s not an `aes`thetic mapping because you’re
not taking information in the data and representing it with `aes`thetics
in the plot. You’ll implement this by writing `color = "pink"` in the
`geom_point()` call, but not wrapped with `aes()`.

    # geom_point(color = "pink")
    # color also takes hexadecimal colors like "#4fc4ab"
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(color = "pink") + # 👈 😜 👈
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "gray") + 
      scale_x_log10(labels = scales::comma)

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-18-1.png)

<br><br><br><br>

Adjust color scale: `scale_color_manual()`
------------------------------------------

Go back to mapping continent to color. Say I don’t like this default
color scale. That’s another `scale` I can adjust.

    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent)) +
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "black") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#699e4a", "#db502a", "#3b3078")) # 👈 🤓 👈

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-19-1.png)

`continent` is a `factor` variable with 5 `levels`, so I’ll need to pick
out 5 colors.

    class(gapminder$continent)

    ## [1] "factor"

    gapminder$continent %>% levels() 

    ## [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"

Go [here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) to pick
out colors by name, like `"ivory3"`.

I prefer to just google “color picker” and use the widget thing there to
get hex codes like “\#553469”.

### Exercise 4

> **Exercise 4**: Instead of using `aes(color = continent)` and
> adjusting the color scale, use
> `aes(color = continent, shape = continent)` and adjust the shape scale
> along with the color scale. Try `scale_shape_manual()`.

### Answer

    # Exercise 4 answer
    ## Instead of `color`, I did `fill`!
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(fill = continent, shape = continent)) +  # 👈 🤓 👈
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "black") + 
      scale_x_log10(labels = scales::comma) +
      scale_fill_manual(values = c("#e3a446", "#6187cf", "#699e4a", "#db502a", "#3b3078")) +  # 👈 🤓 👈
      scale_shape_manual(values = c(21, 22, 23, 24, 25)) # 👈 🤓 👈

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-21-1.png)

<br><br><br><br>

Adjust transparency: `alpha`
----------------------------

Whenever points overlap a lot like this, it’s a good idea to try
adjusting the transparency of the points. We can do that by setting
`alpha`. `alpha` must be a number between 0 and 1. The default is 1, and
the closer it is to 0, the more transparent the points are.

    # Since we want alpha to be set the same for all points, we put it outside the aes() call.

    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent), alpha = .6) + # 👈 😀 👈 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078"))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-22-1.png)

Point `size`
------------

Now I want to adjust the size of the points. Let’s make all the points
larger then smaller. To affect all points, I’ll put `size` outside of
the `aes()` call.

    # huge: size = 3
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent), alpha = .6, size = 3) + # 👈 🙃 👈 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078"))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-23-1.png)

    # tiny: size = .5
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent), alpha = .6, size = .5) + # 👈 🙃 👈 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078"))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-24-1.png)

<br><br>

Map `pop` to `size`
-------------------

I can also map population to size, so big countries get big points and
small countries get small points. To do that, I’ll put `size = pop` in
the `aes()` call!

    # Notice: now we have 2 legends, one for each extra `aes`thetic mapping.
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent, size = pop), alpha = .6) + # 👈 😏 👈 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078"))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-25-1.png)

Faceting: `facet_wrap()`
------------------------

We’re nearly done for today! One of the last things we’ll talk about is
faceting. Notice we have all the years of data mashed into one plot
here? Suppose I wanted to draw a different plot for each `year` in the
dataset. There’s a way to quickly do that, and it’s called faceting.

    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = continent, size = pop), alpha = .6) + 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078")) +
      facet_wrap(facets = vars(year)) # 👈 😲 👈

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-26-1.png)

### Exercise 5

> **Exercise 5**: Use `facet_wrap()` to facet by `continent` instead of
> `year`. If you wanted to see growth in GDP/capita and life expectancy
> over time, how would you visualize it here?

### Answer

    # Exercise 5 answer
    ## I mapped `year` to `color`: light blue dots are more recent. Life expectancy has increased significantly in the Americas and Asia.
    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_point(aes(color = year, size = pop), alpha = .6) + # 👈 😲 👈
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      facet_wrap(facets = vars(continent)) # 👈 😲 👈

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-27-1.png)

<br><br>

Animation: `gganimate::transition_states()`
-------------------------------------------

Finally, instead of breaking out into many plots, we overlay the plots
and create an animation! I use `gganimate::transition_time` here, and I
also decided to replace `geom_point()` with `geom_text()`.

    library(gganimate)
    library(transformr)

    ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
      geom_text(aes(label = country, color = continent, size = pop), alpha = .6) + 
      labs(x = "GDP/capita", y = "life expectancy") + 
      theme_minimal() +
      geom_smooth(method = lm, color = "darkgray") + 
      scale_x_log10(labels = scales::comma) +
      scale_color_manual(values = c("#e3a446", "#6187cf", "#83b543", "#db502a", "#3b3078")) +
      transition_time(year) + # 👈 🤯 👈
      labs(title = "Year: {frame_time}")

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-28-1.gif)

Review
------

We’ve covered a lot of ground! Here are the things we’ve learned:

-   `ggplot()` takes `data` and `aes`thetic mappings like x, y, color,
    and size, and uses `geom`s to draw plots
-   We saw these `geom`s:
    -   `geom_point()`
    -   `geom_boxplot()`
    -   `geom_smooth()`
    -   `geom_text()`
-   We learned how to change titles and labels using `labs()`
-   We learned how to adjust scales, like the x-axis scale with
    `scale_x_log10()` and the color scale with `scale_color_manual()`
-   We learned some extra customization using `theme()`, faceting using
    `facet_wrap()`, and animation using `gganimate`!

Resources
---------

-   [Find the full list of geoms
    here](https://ggplot2.tidyverse.org/reference/)

-   [A Layered Grammar of
    Graphics](https://vita.had.co.nz/papers/layered-grammar.pdf)

-   [R4DS on Data
    Visualization](https://r4ds.had.co.nz/data-visualisation.html)

Assignment 3: get to know more `geom`s
--------------------------------------

#### 3.1 `geom_line()`

Use the `gapminder` package to draw a **line plot** showing how
`lifeExp` has changed over time for a few different countries.

### Hints

Use this as a guide:

    # Hints
    gapminder %>%
      filter(country %in% c("___", "___", "___")) %>%
      ggplot(aes(x = year, y = ___, color = ___)) +
      geom_line()

### Answer

    # Assignment 3.1 Answer
    ## I wanted the legend to be in the same order as the lines, so I
    ## used `fct_reorder2()`. It reorders the factor `gapminder$country` 
    ## so that levels reflect the magnitude of the last pair of 
    ## (year, lifeExp) coordinates. You can also try `first2`.
    gapminder %>%
      filter(country %in% c("Singapore", "Spain", "Iceland", "Italy", "Isreal", "Korea, Rep.")) %>%
      ggplot(aes(x = year, y = lifeExp, color = country %>% fct_reorder2(.x = year, .y = lifeExp, last2))) +
      labs(color = "country") +
      geom_line()

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-30-1.png)

#### 3.2 `geom_bar()` and `geom_histogram()`

Use `geom_bar()` to make a bar plot, then use `geom_histogram()` to make
a histogram.

What’s the difference? Bar plots take **categorical** data like
`country` and `continent`, while histograms take **continuous** data
like `gdpPercap` and `lifeExp`.

For your bar plot, compare the number of observations in the data for
each continent.

For your histogram, compare the frequency of observations with gdpPercap
inside some intervals. Use only data from 2007.

### Hints

Use these as guides:

    # Bar plot hint:
    gapminder %>%
      ggplot() +
      geom_bar(aes(x = ___)) # No `y = ` here: y will be `count`.

    # Histogram hint:
    gapminder %>%
      filter(___) %>%
      ggplot() +
      geom_histogram(aes(x = ___)) # No `y = ` here: y will be `count`.

### Answer

    # Assignment 3.2 Answer
    ## Bar plot
    ### I used `fct_infreq()` to rearrange the bars by frequency and also added color using `fill`.
    gapminder %>%
      ggplot() +
      geom_bar(aes(x = fct_infreq(continent), fill = continent))

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-32-1.png)

    ## Histogram
    ### rescale the x-axis when working with the `gdpPercap` variable
    ### to see more detail, as we did above
    gapminder %>%
      filter(year == 2007) %>%
      ggplot() +
      geom_histogram(aes(x = gdpPercap, fill = continent), bins = 10) +
      scale_x_log10()

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-32-2.png)

    ## `geom_density()` does something similar with the argument `y = ..count..`
    gapminder %>%
      filter(year == 2007) %>%
      ggplot() +
      geom_density(aes(x = gdpPercap, fill = continent, y = ..count..), alpha = .3) +
      scale_x_log10()

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-32-3.png)

#### 3.3 `geom_abline()`, `geom_vline()`, and `geom_hline()`

You can use these three `geom`s to add straight lines to your plot. Take
the histogram you drew in 3.2 and add a vertical line with
`geom_vline()` at the international poverty line, currently set at $1.90
per day ($693.50 per year).

### Hints

Use this as a guide:

    gapminder %>%
      filter(___) %>%
      ggplot() +
      geom_histogram(aes(x = ___)) +
      geom_vline(xintercept = ___)

### Answer

    # Assignment 3.3 Answer
    ## I also used `annotate()` to label the poverty line
    gapminder %>%
      filter(year == 2007) %>%
      ggplot() +
      geom_histogram(aes(x = gdpPercap, fill = continent), bins = 10) +
      scale_x_log10() +
      geom_vline(xintercept = 693.5) +
      annotate("text", x = 693.5 - 170, y = 12.5, label = "International Poverty Line", angle = 90)

![]({{site_url}}/img/blog_images/introRweek03_files/figure-markdown_strict/unnamed-chunk-34-1.png)
