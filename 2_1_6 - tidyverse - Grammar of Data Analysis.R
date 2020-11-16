# 2.1.6 tidyverse - Grammar of Data Analysis
# Misk Academy Data Science Immersive, 2020

# Using the tidy PlayData dataframe, try to compute an aggregation function 
# according to the three scenarios, e.g. the mean of the value.

# Scenario 1: Aggregation across height & width
PlayData_t %>%
  group_by(time,type) %>%
  summarise(avg=mean(values))



# Scenario 2: Aggregation across time 1 & time 2
PlayData_t %>%
  group_by(type,key) %>%
  summarise(avg1=mean(values))


# Scenario 3: Aggregation across type A & type B
PlayData_t %>%
  group_by(time,key) %>%
  summarise(avg2=mean(values))


