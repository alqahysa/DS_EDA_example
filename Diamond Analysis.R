# Diamond Analysis
# Sarah AlQahtani
# 29.09.2020
# A small case study for EDA and Stat

# load package
library(tidyverse)
#Exercise 8.1 (Import and Examine) -----
# Read in the data (csv format)
# Newer methods from tidyr package
jems <- read_csv("Misk_Learn_R/data/diamonds.csv")

# Super convenient way
#library(rio)
#jems2 <- import("data/diamonds.csv")

#Exercise 8.2 (Examine structure) ----
# Get familiar with dataset
summary(jems)
names(jems)
glimpse(jems)

# Attributes
attributes(jems)
typeof(jems)

jems <- as_tibble(jems)
jems
# Exercise 8.3 (Counting individual groups) -----
# - How many diamonds with a clarity of category “IF” are present in the data-set? 
#indexing
nrow(jems[jems$clarity=='IF',])
sum(jems$clarity == 'IF')

count_if <- jems %>%
  filter(clarity=='IF') %>% 
  count()
IF_count <- count_if$n
IF_count

# - What fraction of the total do they represent?
#nrow(jems)

count_total <- jems %>%
  count()
Total_count <- count_total$n

fractionOfIF <- IF_count/Total_count

fractionOfIF

# Exercise 8.4 (Summarizing proportions) ----
# What proportion of the whole is made up of each category of clarity?
#1
jems%>%
  group_by(clarity) %>%
  count()%>%
  mutate(prop=n/nrow(jems))
#----------------
#2
count_clr <- jems %>%
  count(clarity)
p <- count_clr$n/Total_count
p

proportion <- data.frame(count_clr,p)
proportion
# Exercise 8.5 (Find specific diamonds prices)
# What is the cheapest diamond price overall? 
cheapestPrice <- jems %>%
  summarise(min(price))
cheapestPrice
# What is the range of diamond prices? 
rangePrice <- jems %>%
  summarise(range(price))
rangePrice


# What is the average diamond price in each category of cut and color?
jems %>%
  group_by(cut,color)%>%
  summarise(avg=mean(price))

# Exercise 8.6 (Basic plotting)----
# Make a scatter plot that shows the price of a diamond as described 
# by another continous variable, like the carat.
ggplot(jems,aes(carat,price)) +
  geom_point()
#Exercise 8.7 ----
#(Interpreting plots)
#**What can you say about the relationship between these two variables? 
##Do you think that you can use the carat weight of 
##a diamond to predict its price?


#Exercise 8.8 (Applying transformations) ----
#**Using the functions we discuss earlier, and in class, 
#apply a log10 transformation to both the price and carat.
#You can save these as new columns in the data set called`price_log10`and`
#carat_log10`.
carat_log10 <- log10(jems$carat)
carat_log10
price_log10 <- log10(jems$price)
price_log10
jems2 <- data.frame(jems,carat_log10,price_log10)
jems2
#-------
jems %>%
  mutate(carat_log10=log10(carat),
         price_log10=log10(price))
#Exercise 8.9 (Basic plotting) ----
#**Make a scatter plot that shows the price of a diamond as described by 
#*another continous variable, like the carat.
ggplot(jems2,aes(carat_log10,price_log10)) +
  geom_point()

#Exercise 8.10 (Viewing models) ----
#describes the relatioship shown in the plot?
jems_lm <- lm(price_log10 ~ carat_log10,data=jems2)
jems_lm

#Exercise 8.11 (Displaying models) ----
#Now that we’ve described the diamond price given a single variable, 
#can you display that on the plot?
ggplot(jems_lm,aes(carat_log10,price_log10)) +
  geom_point()+
  geom_smooth(method='lm', se=FALSE,colour='red')
# Extra Ex ----
jems %>%
  filter(clarity=='VVS2' & cut=='Good')

































