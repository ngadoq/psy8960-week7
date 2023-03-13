# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read.csv(file = "../data/week3.csv") |>
  rename(Gender=gender, Condition=condition) |>
  mutate(across(starts_with("time"), as.POSIXct)) |>
  mutate(Gender = factor(Gender, levels=c("M","F"),
                         labels = c("Male","Female"))) |>
  mutate(Condition=factor(Condition, levels=c("A", "B", "C"),
                           labels=c("Block A", "Block B", "Control"))) |> 
  filter(q6 == 1) |>
  select(-q6) |>
  mutate(timeSpent= as.integer(difftime(timeEnd, timeStart)))


# Visualization
(ggpairs(week7_tbl, 
        columns = 5:13)) |> 
  ggsave(filename="../figs/fig0.png")
(ggplot(week7_tbl, aes(timeStart, q1))+
    geom_point() +
    xlab("Date of Experiment") +
    ylab("Q1 Score") ) |> 
  ggsave(filename="../figs/fig1.png", width = 5, height = 3)

(ggplot(week7_tbl, aes(q1,q2, color=Gender))+
  geom_point() +
  geom_jitter() +
  scale_color_discrete(name="Participant Gender")) |> 
  ggsave(filename="../figs/fig2.png",width = 5, height = 3)    
(ggplot(week7_tbl, aes(q1,q2))+
  geom_point() +
  geom_jitter() +
  facet_grid(cols = vars(Gender))+
  labs(x="Score on Q1", y="Score on Q2") )|> 
  ggsave(filename="../figs/fig3.png", width = 5, height = 3)  

(ggplot(week7_tbl, aes(Gender,timeSpent))+
  geom_boxplot()+
  labs(y="Time Elapsed (mins)")) |> 
  ggsave(filename="../figs/fig4.png",width = 5, height = 3)


(ggplot(week7_tbl, aes(q5, q7, color=Condition)) +
  geom_point()+
  geom_jitter()+
  geom_smooth(method = "lm", se = FALSE)+
  scale_color_discrete(name="Experimental Condition") +
  labs(x="Score on Q5", y="Score on Q7") +
  theme(legend.position = "bottom",
        legend.background = element_rect(fill = "#E0E0E0"))) |> 
  ggsave(filename="../figs/fig5.png",width = 5, height = 3)




