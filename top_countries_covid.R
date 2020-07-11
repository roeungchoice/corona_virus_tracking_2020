#import packages
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(gganimate)
library(gifski)
library(ggthemes)

#read csv file
data_by_country <- read_csv(file = 'owid-covid-data.csv')

#select countries from data_by_country
top_countries <- c('United States', 'China', 'Japan', 'United Kingdom', 'Germany', 'India', 'Australia', 'Canada', 'France', 'Italy')

#creating graph 'p'
p <- data_by_countries %>% filter(location %in% top_countries) %>%
  ggplot(aes(date, total_cases, color = location)) +
  geom_line() +
  labs(title = 'Total Cases of COVID-19 in the Richest Countries of the World', 
       subtitle = 'How are the richest countries in the world dealing with this pandemic?',
       x='Time', 
       y='Total Cases',
       color = 'Country') +
  theme_fivethirtyeight() +
  theme(axis.title = element_text()) +
  facet_wrap(~ location)

#animating graph 'p'
p <- p + transition_reveal(date)
animate(p, height = 461, width = 644)

file_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)
