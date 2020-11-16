# Irrigation Analysis
# Sarah AlQahtani
# 01.10.2020
# A small case study

# load package
library(tidyverse)
# Bring with wide "messy" format:
irrigation <- read.csv('Misk_Learn_R/data/irrigation_wide.csv')
irrigation  
# Examine the data:
glimpse(irrigation)

# In 2007, what is the total area under irrigation for only the Americas
irrigation %>%
  filter (year == 2007) %>%
  select(ends_with("erica"))

# To answer the following questions we should use tidy data

irrigation_t <- irrigation %>%
                pivot_longer(-c(year),
                names_to = "region")

# What is the total area under irrigation in each year across all region?

irrigation_t %>% group_by(year) %>%
                summarise(total = sum(value))

# Standardize against 1980 (relative change over 1980)

irrigation_t %>%
  group_by(region) %>%
  summarise(relative = value[year == 2007 & 2000 & 1990] - value[year == 1980])

# What is the lowest and highest?
irrigation_t %>% group_by(region) %>%
    summarise(low_high = range(value))

# Plot area over time for each region?
ggplot(irrigation_t, aes(x = year, y = region)) +
  geom_point()

# which regin increased the most from 1980 to 2007?
irrigation_t %>% group_by(region) %>%
                summarise( diff = value[year == 2007] - value[year == 1980])

# Which two regions increased the most from 1980 to 2007?

irrigation_t %>%
  group_by(region) %>%
  summarise( diff = value[year == 2007] - value[year == 1980]) %>%
  arrange(-diff) %>% #reorders from lowest to highest and with - it's the opposite ("descending")
  slice(1:2) #slice() takes specific row numbers


irrigation_t %>%
  group_by(region) %>%
  summarise( diff = value[year == 2007] - value[year == 1980]) %>%
  slice_max(diff, n = 2)


# What is the rate-of-change in each region?
#xx <-  c(1, 1.2, 1.6, 1.1)
#xx

#There are the absolute differences:
diff(0, value)
#How about the proportional?
irrigation_t <- irrigation_t %>% 
  arrange(region) %>%
  group_by(region) %>%
  mutate(rate = c(0, diff(value)/value[-length(value)]))

# Where is it the highest and lowest?

irrigation_t[which.max(irrigation_t$rate),]
irrigation_t[which.min(irrigation_t$rate),]

# This will give the max rate for EACH reegion
irrigation_t %>% 
  slice_max(rate, n = 1)
#Because ... the tibble is STILL a group_df
#so to get the global answer: ungroup()
irrigation_t %>%
  ungroup() %>%
  slice_max(rate, n =1)

# How about the lowest?
irrigation_t %>%
  ungroup() %>% 
  slice_min(rate, n = 1)
