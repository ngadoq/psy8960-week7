# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)




# Data Import and Cleaning
week7_tbl <- read.csv(file = "../data/week3.csv") |>
  rename(Gender=gender, Condition=condition) |>
  mutate(across(starts_with("time"), as.POSIXct)) |>
  mutate(across(c(Condition, Gender), as.factor)) |>
  filter(q6 == 1) |>
  select(-q6) |>
  mutate(timeSpent= difftime(timeEnd, timeStart))
