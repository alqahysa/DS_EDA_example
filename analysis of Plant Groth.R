# An analysis of Plant Groth
# Sarah AlQahtani
# 28.09.2020
# The first case study

# Load packages
library(tidyverse)


# Obtain our data ----
PlantGrowth
PlantGrowth <- as_tibble(PlantGrowth)
nlevels(PlantGrowth$group)
levels(PlantGrowth$group)
# Explore our data ----

# Descriptive Analysis
# mean, standared deviation


# Data Visualization ----
# 1-way ANOVA
