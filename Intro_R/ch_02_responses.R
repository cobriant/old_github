# Some challenge 2 responses
library(tidyverse)
# Replace the file path with your own:
ipums <- read_csv("~/Downloads/ipums_tidy.csv")

# Marriage premium boxplot
ggplot(data = ipums, 
       aes(x = gender, 
           y = personal_income, 
           color = married)) +
  geom_boxplot() +
  labs(title = "Men earn a larger marriage premium than women", 
       x = "Gender",
       y = "Personal Income (US$)")

# A tweak: `reorder()` `married` by `personal_income` to get
# "unmarried" on the left and "married" on the right.
ggplot(data = ipums, 
       aes(x = gender, 
           y = personal_income, 
           color = reorder(married, personal_income))) +
  geom_boxplot() +
  labs(title = "Men earn a larger marriage premium than women", 
       x = "Gender",
       y = "Personal Income (US$)",
       color = "Marital Status")



# Scatterplot for gender and race across age:
ggplot(data = ipums, 
       aes(x = age, 
           y = personal_income, 
           color = gender, 
           shape = race)) +
  geom_point() +
  labs(title = "White men make the most throughout life", 
       x = "Age in years",
       y = "Personal Income (US$)") +
  theme_bw()




# Area plot for racial wage gap:
ggplot(data = ipums, aes(x = personal_income, fill = race)) +
  geom_area(stat = "bin", binwidth = 25000, alpha = .7) +
  labs(title = "Wage Gap based on race", x = "Income (US$)", y = "Count") +
  theme_minimal()

# A tweak: filter out NAs, xlim() to zoom in, reorder, facet
# by race, add vertical lines and labels for median incomes.
ipums_summary <- ipums %>% 
  filter(!is.na(race)) %>%
  group_by(race) %>%
  summarize(personal_income = median(personal_income))

ipums %>%
  filter(!is.na(race)) %>%
  ggplot(aes(x = personal_income, 
             fill = reorder(race, personal_income), 
             color = reorder(race, personal_income))) +
  xlim(0, 150000) +
  geom_density(alpha = .4) +
  geom_vline(data = ipums_summary, 
             aes(xintercept = personal_income, color = race)) +
  geom_text(data = ipums_summary, 
            aes(label = personal_income, color = race),
                x = 100000, y = 0.000015) +
  labs(title = "Wage Gap based on race", 
       x = "Income (US$)",
       fill = "race",
       color = "race") +
  theme_minimal() +
  facet_wrap(~reorder(race, personal_income))

# Personal income by age
ggplot(data = ipums, aes(x = age, y = personal_income)) +
  geom_smooth() +
  labs(x = "Age", y ="Personal Income", 
       title = "Personal income on average peaks at around 70 years old")

# Marriage premium
ggplot(data = ipums, aes(y = personal_income, color = married)) +
  geom_density(alpha=.5)+
  ylim(0,250000)+
  labs(x = "Density", y ="Personal Income", 
       title = "Personal income is on average higher in married couples")

# A tweak: violin plot with labels
ipums_summary <- ipums %>% 
  group_by(married) %>%
  summarize(personal_income = median(personal_income))

ggplot(data = ipums, aes(y = personal_income, x = married, fill = married)) +
  geom_violin(alpha = .5) +
  ylim(0,250000) + 
  labs(x = "Density", y ="Personal Income", 
       title = "Personal income is on average higher in married couples") +
  geom_hline(data = ipums_summary, aes(yintercept = personal_income,
                                       color = married)) +
  geom_text(data = ipums_summary, aes(y = personal_income,
                                      label = personal_income,
                                      color = married))

# Education premium
mean_inc <- mean(ipums$personal_income)
ggplot(data = ipums, aes(x = education, y = personal_income-mean_inc, color=education)) +
  geom_point()+
  geom_count()+
  ylim(-65000,650000)+
  labs(x = "education", 
       y ="Personal Income - Avg Income", 
       title = "Lower wage gap in college graduates")

# A tweak: geom_jitter and alpha, also medians labeled
ipums_summary <- ipums %>% 
  group_by(education) %>%
  summarize(personal_income = median(personal_income))

ggplot(data = ipums, aes(x = reorder(education, personal_income), 
                         y = personal_income, 
                         color = education)) +
  ylim(0, 150000) +
  geom_jitter(alpha = .1) +
  labs(x = "education", y ="Personal Income") +
  geom_hline(data = ipums_summary, aes(yintercept = personal_income,
                                       color = education)) +
  geom_label(data = ipums_summary, aes(y = personal_income,
                                      label = personal_income,
                                      color = education))

# median incomes by race and gender
ipums %>%
  ggplot(aes(x = race %>% reorder(personal_income), 
             y = personal_income, 
             fill = gender)) +
  stat_summary(geom = "col", fun = "median", pos = "dodge") +
  labs(y = "Median personal income",
       x = "Race",
       title = "Gender Wage Gaps by Race")

# median incomes by race, gender, and education
ipums %>%
  ggplot(aes(x = race %>% reorder(personal_income), 
             y = personal_income, 
             fill = gender)) +
  stat_summary(geom = "col", fun = "median", pos = "dodge") +
  facet_wrap(~ education) +
  labs(y = "Median personal income",
       x = "Race",
       title = "Gender Wage Gaps by Race and Education")
