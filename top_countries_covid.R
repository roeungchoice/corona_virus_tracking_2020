#import library
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(gganimate)
library(gifski)
library(ggthemes)

#import data from csv file
data_by_country <- read_csv(file = 'owid-covid-data.csv')

#select countries of interest
top_countries <- c('United States', 'China', 'Japan', 'United Kingdom', 'Germany', 'India', 'Australia', 'Canada', 'France', 'Italy')

#create graph
p <- data_by_country %>% filter(location %in% top_countries) %>%
  ggplot(aes(date, total_cases, color = location, axes=FALSE)) +
  geom_line() +
  scale_y_continuous(breaks = seq(0, 3e+06, by = 5e+05)) +
  labs(title = 'Total Cases of COVID-19 in the Richest Countries of the World', 
       subtitle = 'Richest countries based on private wealth in USD (2018)',
       x='Time', 
       y='Total Cases',
       color = 'Country') +
  theme_fivethirtyeight() +
  theme(axis.title = element_text()) +
  facet_wrap(~ location, scales = 'free_x') + 
  theme(panel.spacing = unit(2, "lines"))

#animate graph
p <- p + transition_reveal(date)
animate(p, height = 500, width = 644)

file_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)
