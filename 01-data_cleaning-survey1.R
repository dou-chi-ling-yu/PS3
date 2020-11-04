#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from
#          https://www.voterstudygroup.org/publication/nationscape data set
# Author: Zhengyu Ren 1003802735 & Zhiyuan Liu - 1001439678
# Data: 1 November 2020
# Contact: zhengyu.ren@mail.utoronto.ca & zhiyuan.liu@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("D:/Problem Set 3")
raw_data <- read_dta("inputs/ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)

names(raw_data)

# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(right_track,
         economy_better,
         pres_approval, #is trump doing well?
         vote_intention, #are u going to vote?
         vote_2020,
         consider_trump,
         not_trump,
         cand_favorability_trump, 
         cand_favorability_biden,
         trump_biden,
         employment,
         gender, #is_male
         census_region,
         race_ethnicity,
         household_income,
         education,
         age,
         state)


head(reduced_data)

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(trump_biden =="Donald Trump", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(vote_Biden = 
           ifelse(vote_2020 =="Joe Biden", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(economy_better = 
           ifelse(economy_better =="Better", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(is_male = 
           ifelse(gender =="Male", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(right_track= 
           ifelse(right_track=="Generally headed in the right direction", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(vote_Biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0))

rm(raw_data)

summarise(reduced_data)

ggplot(reduced_data)

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

