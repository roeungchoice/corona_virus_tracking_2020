library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(gganimate)
library(gifski)
library(ggthemes)

data_by_country <- read_csv(file = 'owid-covid-data.csv')

top_countries <- c('United States', 'China', 'Japan', 'United Kingdom', 'Germany', 'India', 'Australia', 'Canada', 'France', 'Italy')

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

p <- p + transition_reveal(date)
#animate(p, height = 461, width = 644)

file_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)
