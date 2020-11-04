#### Preamble ####
# Purpose: Prepare and clean the 2018 American census data downloaded from 
#          https://usa.ipums.org/ base on our interested variable.
# Author: Zhengyu Ren - 1003802735 & Zhiyuan Liu - 1001439678
# Data: 1 Novemeber 2020
# Contact: zhengyu.ren@mail.utoronto.ca & zhiyuan.liu@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)
# Read in the raw data.
setwd("D:/Problem Set 3")
raw_data <- read_dta("inputs/usa_00002.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest
names(raw_data)
head(raw_data)

reduced_data <- raw_data %>% 
  select(region,
         stateicp,
         sex, 
         age,
         race,
         citizen,
         empstat,
         inctot,
         incwelfr,
         poverty,
         educ,
         migrate1)

rm(raw_data)

head(reduced_data)

reduced_data <- reduced_data %>%
  count(age, sex, race, empstat, inctot, educ, stateicp) %>%
  filter(age != 17) %>% 
  rename(state = stateicp) %>%
  rename(race_ethnicity = race) %>% 
  rename(household_income = inctot) %>% 
  rename(education = educ)
  group_by(age) 

head(reduced_data)

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "census_data.csv")



         