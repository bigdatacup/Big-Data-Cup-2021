
## SET UP ##

# Load packages
library(tidyverse)
library(gganimate) # For turning ggplot's into animations


# Load the data directly from github
# To get this URL go to our GitHub repository then click "TrackingData/<game name>/<powerplay name.csv>", click "Raw", then copy the url once the raw data loads
tracking_data = read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/TrackingData/2022-02-14%20Finland%20at%20USA/2022-02-14%20Finland%20at%20USA%20P3%20PP6.csv")



## DATA WRANGLING WITH NEST AND MAP ##

# The nest and map functions are a huge help in making sense of tracking data and performing frame-by-frame operations

# Using group_by and nest in R allows us to split data into smaller more manageable sub-data frames
tracking_data_nested = tracking_data %>%
  group_by(frame_id) %>%
  nest()


# We can perform transformations on the nested data using mutate and map
tracking_data_player_count = tracking_data_nested %>%
  mutate(num_players = map(.x = data, .f = ~nrow(.x)))




## ANIMATED PLOTS ##

# Set the specs for the gif we want to create (lower res to make it run quicker)
options(gganimate.dev_args = list(width = 10, height = 6, units = 'in', res = 320))

# Source in the plot_rink function
source("Code/plot_rink.R")

# Create a gif of this play
p = plot_rink(ggplot(tracking_data)) +
  geom_point(aes(x = x_ft, y = y_ft, fill = team_name), shape = 21, size = 6) +
  geom_text(aes(x = x_ft, y = y_ft, label = jersey_number, colour = team_name), size = 3) +
  scale_colour_manual(values = c("USA" = "white", "Finland" = "navy")) +
  scale_fill_manual(values = c("USA" = "blue", "Finland" = "grey90")) +
  transition_time(frame_id) +
  labs(fill = "Team") +
  guides(colour = "none")


# Get the maximum and minimum frame number (so we know how long the gif should be)
max_frame = max(tracking_data$frame_id)
min_frame = min(tracking_data$frame_id)


# Render the animation
p2 = animate(p, renderer = ffmpeg_renderer(), fps = 30, duration = (max_frame - min_frame)/30 + 1)


# Save as an mp4
anim_save("Figures/demo.mp4", p2)


