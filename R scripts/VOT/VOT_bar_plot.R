# Amanda Bohnert, F24 L541
#
# This script will make a nice VOT plot and VOT tables for you.
# You will need to get your data into a specific format for this to work. Look
# at the VOT_sample_data file to see the format. The IPA symbol goes on
# the left (can be anything), then the voicing (use whatever distinction makes
# sense for your language), then the place (again use whatever works), and then
# the VOT. Since you won't have too many tokens, I would just measure it manually.
# You should have one row per token--so if you have multiple repetitions, just
# make a new row. You can add a column for repetition if you want, but it won't
# matter for plotting.

library(dplyr)
library(ggplot2)

# Import your data in the correct format here.

# Inside the parentheses, indicate what order you want the consonants to appear
# in, in IPA. Make sure this matches *exactly* with their labels in the spreadsheet.
yorder = c("b", "p", "pʰ", "d", "t", "tʰ", "g", "k", "kʰ") %>% rev()


# Replace every instance of "VOT_sample_data" with the name of your data set.

attach(VOT_sample_data)
ggplot(VOT_sample_data, aes(x=VOT, y = IPA, fill = voicing, group = place))+
  geom_bar(stat="summary", fun = "mean")+
  theme_bw(base_size=14)+ # change the size to make it look right for your computer/paper
  scale_y_discrete(limits = yorder)+
  labs(title = "",
       x = "VOT (ms)",
       y = "Consonant",
       fill = "Type")


# This will make nice tables of the same data that you can use for your paper.
# Use whichever one is relevant for your data.

# Mean for individual consonants
vot_table_all <- VOT_sample_data %>%
  group_by(IPA) %>%
  summarize("Mean VOT" = round(mean(VOT), 2))

# Mean for individual consonants grouped by type
vot_table_all_with_type <- VOT_sample_data %>%
  group_by(voicing, IPA) %>%
  summarize("Mean VOT" = round(mean(VOT), 2))

# Groups all aspirated, all voiced, etc. together
vot_table_by_type <- VOT_sample_data %>%
  group_by(voicing) %>%
  summarize("Mean VOT" = round(mean(VOT), 2))



