# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
update.packages(ask=FALSE)
library(tidyverse)
library(GGally)
library(conflicted)


# Data Import and Cleaning
week7_tbl <- read.csv(file = "../data/week3.csv") |>
  mutate(timeStart = ymd_hms(timeStart),
         timeEnd = ymd_hms(timeStart),
         gender = factor(gender, levels=c("M","F"),
                         labels = c("Male","Female")),
         condition=factor(condition, levels=c("A", "B", "C"),
                           labels=c("Block A", "Block B", "Control")),
         timeSpent=as.integer(timeEnd - timeStart)) |> 
  dplyr::filter(q6 == 1) |>
  select(-q6) 


# Visualization
week7_tbl |>
  select(q1:q10) |> 
  ggpairs()

(ggplot(week7_tbl, aes(timeStart, q1))+
    geom_point() +
    xlab("Date of Experiment") +
    ylab("Q1 Score") ) |> 
    ggsave(filename="../figs/fig1.png", units = "px", width = 1920, height = 1080)

(ggplot(week7_tbl, 
        aes(q1,q2, color=gender))+
  geom_jitter() +
  scale_color_discrete(name="Participant Gender")) |> 
  ggsave(filename="../figs/fig2.png", units = "px", width = 1920, height = 1080)    
(ggplot(week7_tbl, 
        aes(q1,q2))+
  geom_jitter() +
  xlab("Score on Q1") +
  ylab("Score on Q2") +
  facet_grid(cols = vars(gender))) |> 
  ggsave(filename="../figs/fig3.png", units = "px", width = 1920, height = 1080)  

(ggplot(week7_tbl, aes(gender,timeSpent))+
  geom_boxplot()+
  labs(y="Time Elapsed (mins)")) |> 
  ggsave(filename="../figs/fig4.png", units = "px", width = 1920, height = 1080)


(ggplot(week7_tbl, 
        aes(q5, q7, color=condition)) +
  geom_jitter(width=.1)+
  geom_smooth(method = "lm", se = FALSE)+
  scale_color_discrete(name="Experimental Condition") +
  labs(x="Score on Q5", y="Score on Q7") +
  theme(legend.position = "bottom",
        legend.background = element_rect(fill = "#E0E0E0"))) |> 
  ggsave(filename="../figs/fig5.png", units = "px", width = 1920, height = 1080)




