# Amanda Bohnert, F24 L541
#
# This script will generate plots dealing with F0. There are several different
# options depending on what type of plot you want. The sample dataset I used to
# generate these is called data.xlsx and can be found in the GitHub folder.

library(ggplot2)
library(dplyr)

##### Plot F0 contours (one panel) #####
#
# If you want to plot one F0 contour (e,g,, F0 across the duration of a vowel),
# use this script. At minimum, your dataset should have columns for: the target 
# (IPA), timepoint, and F0. You can also have additional columns for any variables
# you want to use to group your measurements, such as voicing, etc.
#
# For this example, I'm plotting the F0 of vowels following different types of
# consonants. You could also plot the F0 of different tones, etc.
#
# This changes the order that things appear in in the legend. If you
# don't need to change the order, you don't need to run this. If you do, change
# data$Voicing so that it is (dataset)$(grouping variable), and within 
# levels = c(), put the order you want the labels in the legend to appear in, 
# using the exact values in your dataset.

data$Voicing <- factor(data$Voicing, levels=c('voiced', 'plain', 'aspirated'))

# - data: change to the name of your dataset
# - x and y: change to the name of the columns where you have the timepoints and
#   F0 measurements
# - color in aes: swap Voicing with whatever variable you want to group by
# - geom_path vs geom_smooth: geom_path will plot all tokens, while geom_smooth
#   will just plot the average contour for each value in your grouping variable
# - group in geom_path: set to something unique for each token. I used rowLabel,
#   which is the label in the TextGrid.
# - se in geom_smooth: if you want shading to indicate standard error, change
#   this to TRUE
# - n.breaks in scale_x_continuous makes it so that every timepoint (1-10) shows
#   up on the x axis. If you have 20 timepoints, change this to 20.
# - base_size in theme_bw: change this to make the font size look good on your
#   display

ggplot(data, aes(x=NormalizedTime, y=F0, color = Voicing))+
  #geom_path(aes(group=rowLabel), linewidth = 1)+
  geom_smooth(se=FALSE)+
  scale_x_continuous(n.breaks=10, expand = c(0,0))+
  theme_bw(base_size=15)+
  labs(x = "Timepoint",
       y = "F0 (Hz)",
       title = "")


##### Plot F0 contours surrounding some other sound #####
#
# This will plot two contours surrounding a consonant, for instance, on the same
# plot. First, it will change the way the timepoints are labeled so that the
# contour appear on the correct position on the graph. Your data will need a
# variable indicating position in addition to the time points. I used the name 
# Position, and all data points of the vowel before the consonant, in my case, 
# were marked 'pre', and all data points of the following vowel were marked 'post'.
#
# This creates a new data frame that changes the way the timepoints are labeled 
# so that the contour appears on the correct position on the graph. It basically
# changes the first set of timepoints to be negative so that they appear to the
# left of the second set instead of on top.
#
# - data: change to the name of your dataset
# - all instances of NormalizedTime: change the variable to wherever your timepoints are
# - Position == "pre": change Position to the variable that indicates which section
#   the data points are from, and change pre to the value of that variable that
#   should appear on the left.
# - 11: this works if you have 10 timepoints. If you have 20, change this to 21.

data_new_time <- data %>%
  mutate(NormalizedTime = case_when(
    Position == "pre" ~ NormalizedTime - 11,
    TRUE ~ NormalizedTime
  ))

# This changes the order that things appear in in the legend. If you
# don't need to change the order, you don't need to run this. If you do, change
# data$Voicing so that it is (dataset)$(grouping variable), and within 
# levels = c(), put the order you want the labels in the legend to appear in, 
# using the exact values in your dataset.

data_new_time$Voicing <- factor(data_new_time$Voicing, levels=c('voiced', 'plain', 'aspirated'))

# - data: change to the name of your dataset
# - x and y: change to the name of the columns where you have the timepoints and
#   F0 measurements
# - color in aes: swap Voicing with whatever variable you want to group by
# - geom_path vs geom_smooth: geom_path will plot all tokens, while geom_smooth
#   will just plot the average contour for each value in your grouping variable
# - filter(data...): change Position to the variable that indicates which section
#   the data points are from, and change pre to the value of that variable that
#   should appear on the left and post to the value that should appear on the right.
# - group=rowLabel: set to something unique for each token. I used rowLabel,
#   which is the label in the TextGrid.
# - se in geom_smooth: if you want shading to indicate standard error, change
#   this to TRUE
# - n.breaks in scale_x_continuous makes it so that every timepoint (-10-10) shows
#   up on the x axis. If you have 20 timepoints, change this to 40.
# - base_size in theme_bw: change this to make the font size look good on your
#   display

ggplot(data_new_time, aes(x=NormalizedTime, y=F0, color = Voicing))+
  #geom_path(data = filter(data_new_time, Position == "pre"), aes(group=rowLabel), linewidth = 1)+
  #geom_path(data = filter(data_new_time, Position == "post"), aes(group=rowLabel), linewidth = 1)+
  geom_smooth(data = filter(data_new_time, Position == "pre"), se=FALSE)+
  geom_smooth(data = filter(data_new_time, Position == "post"), se=FALSE)+
  geom_vline(xintercept = 0, linewidth = 1)+
  scale_x_continuous(expand = c(0,0), n.breaks=20)+
  theme_bw(base_size=15)+
  labs(x = "Timepoint",
       y = "F0 (Hz)",
       title = "")

# This will plot the same this but in two different plots side-by-side.

# This changes the order that things appear in in the legend. If you
# don't need to change the order, you don't need to run this. If you do, change
# data$Voicing so that it is (dataset)$(grouping variable), and within 
# levels = c(), put the order you want the labels in the legend to appear in, 
# using the exact values in your dataset.

data$Voicing <- factor(data$Voicing, levels=c('voiced', 'plain', 'aspirated'))

# This changes the order that the panels appear in. If you don't need to change 
# the order, you don't need to run this. If you do, change data$Position so that
# it is (dataset)$(positioning variable), and withinlevels = c(), put the order 
# you want the panels to appear in using the exact values in your dataset.

data$Position <- factor(data$Position, levels=c('pre', 'post'))

# - data: change to the name of your dataset
# - x and y: change to the name of the columns where you have the timepoints and
#   F0 measurements
# - color in aes: swap Voicing with whatever variable you want to group by
# - geom_path vs geom_smooth: geom_path will plot all tokens, while geom_smooth
#   will just plot the average contour for each value in your grouping variable
# - filter(data...): change Position to the variable that indicates which section
#   the data points are from, and change pre to the value of that variable that
#   should appear on the left and post to the value that should appear on the right.
# - group=rowLabel in geom_path: set to something unique for each token. I used 
#   rowLabel, which is the label in the TextGrid.
# - se in geom_smooth: if you want shading to indicate standard error, change
#   this to TRUE
# - n.breaks in scale_x_continuous makes it so that every timepoint (-10-10) shows
#   up on the x axis. If you have 20 timepoints, change this to 40.
# - base_size in theme_bw: change this to make the font size look good on your
#   display
# - Position in facet_grid: change Position to the variable that indicates which
#   section the data points are from
# - labeller in facet_grid: changes panel labels. Within the vector, change pre
#   and post to whatever the values in your dataset are, and then change Pre-stop
#   and Post-stop to whatever you want the labels to be.

ggplot(data, aes(x=NormalizedTime, y=F0, color = Voicing))+
  #geom_path(aes(group=rowLabel),linewidth = 1)+
  geom_smooth(se=FALSE)+
  scale_x_continuous(expand = c(0,0), n.breaks = 10)+
  theme_bw(base_size=15)+
  labs(x = "Timepoint",
       y = "F0 (Hz)",
       title = "")+
  facet_grid(cols = vars(Position), labeller = as_labeller(c(pre="Pre-stop", post="Post-stop")))+
  theme(panel.spacing.x = unit(1.5, "lines"))
