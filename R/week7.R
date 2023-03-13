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





# Visualization
fig0 <- week7_tbl 


(ggplot(week7_tbl, aes(timeStart, q1))+
    geom_point() +
    xlab("Date of Experiment") +
    ylab("Q1 Score") ) |> 
  ggsave(filename="../figs/fig1.png", width = 5, height = 3)

(ggplot(week7_tbl, aes(q1,q2, color=Gender))+
  geom_point() +
  geom_jitter() +
  scale_color_discrete(name="Participant Gender", labels=c("Female", "Male"))) |> 
  ggsave(filename="../figs/fig2.png",width = 5, height = 3)    
ggplot(week7_tbl, aes(q1,q2))+
  geom_point() +
  geom_jitter() +
  labs(color = "Participant Gender") 


#ggsave(filename="../figs/fig3.png")  
ggplot(week7_tbl, aes(q1,q2))+
  geom_point() +
  geom_jitter() +
  labs(color = "Participant Gender") 

#ggsave(filename="../figs/fig4.png")


