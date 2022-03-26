
## SET UP ##

# Load the data directly from github
olympic_data = read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/pxp_womens_oly_2022_v2.csv")


# Load the tidyverse, a set of packages that can help with data cleaning and analysis in R
install.packages("tidyverse")
library(tidyverse)



## SELECTING COLUMNS AND FINDING DISTINCT ROWS ##

# What types of events are available?
olympic_data %>% 
  select(event) %>% 
  distinct()

# Same code, without the pipe :(
distinct(select(olympic_data, event))



## FILTERING TO CERTAIN EVENTS ##

# Natalie Spooner passes
spooner_passes = olympic_data %>%
  filter(event == "Play") %>%
  filter(player_name == "Natalie Spooner")



## CREATING NEW VARIABLES ##

# Find pass distances
pass_data = olympic_data %>%
  filter(event == "Play") %>%
  mutate(pass_distance = sqrt((x_coord - x_coord_2)^2 + (y_coord - y_coord_2)^2))



## AGGREGATING DATA ##

# How many passes did each player make?
pass_counts = olympic_data %>%
  filter(event == "Play") %>%
  group_by(player_name) %>%
  count()


# What was their completion rate on these passes?
pass_counts = olympic_data %>%
  filter(event == "Play") %>%
  mutate(event_successful = ifelse(event_successful == "t", TRUE, FALSE)) %>%
  group_by(player_name) %>%
  summarize(event_successful = mean(event_successful), count = n())


## PLOTTING THE DATA ##

# # Install packages to run the plot_rink function if you haven't already
# install.packages("ggforce")
# install.packages("cowplot")


# Source in function to create the rink plot in ggplot
source("Code/plot_rink.R")


# Let's plot Alina Muller's shots throughout the 2022 Olympics
muller_shots = olympic_data %>%
  filter(event %in% c("Shot", "Goal")) %>%
  filter(player_name == "Alina Muller") %>%
  mutate(event_successful = ifelse(event_successful == "t", "Goal", "Shot"))

plot_rink(ggplot(muller_shots)) +
  geom_point(aes(x = x_coord, y = y_coord, fill = event_successful), shape = 21, size = 3.5)


# What if we return to Natalie Spooner's passes, can we plot that?
plot_rink(ggplot(spooner_passes)) +
  geom_segment(aes(x = x_coord, xend = x_coord_2, y = y_coord, yend = y_coord_2, colour = situation_type), alpha = 0.6, arrow = arrow(length = unit(0.07, "inches")))



