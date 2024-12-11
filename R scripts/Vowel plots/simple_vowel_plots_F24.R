# Amanda Bohnert, L541 F24

library(ggplot2)
attach(measurements)

##### F2 F1 Vowel plot #####

ggplot(measurements, aes(x = F2, y = F1, color = Vowel)) +
  #geom_point() +                                          # adds data points as dots
  geom_text(label = Vowel, size = 8) +                     # adds data points as the vowel
  #geom_label(label = Vowel, size = 7) +                   # adds data points with the vowel in a separate label
  scale_x_reverse() +                                      # reverses x axis
  scale_y_reverse() +                                      # reverses y axis
  labs(title = "Amanda's Vowel Space",                     # main title and axis labels
       x = "F2 (Hz)",
       y = "F1 (Hz)") +
  theme_bw(base_size=15) +                                 # theme and base font size
  theme(legend.position = "none",                          # no legend
        plot.title = element_text(hjust = 0.5))            # centers plot title (0.5 = center)



##### Duration #####

ggplot(measurements, aes(x=Duration*1000, y = Vowel, fill = Vowel))+             # *1000 converts to ms
  geom_bar(stat="summary", fun="mean")+                                          # makes bars the mean value
  scale_y_discrete(limits=c("ɑ", "ɔ", "ʊ", "u", "ʌ", "ɜ˞", "æ", "ɛ", "ɪ", "i"))+ # reorders the y axis (labels are reversed)
  scale_x_continuous(expand = expansion(mult = c(0, .1)))+                       # optional: removes blank space at left edge
  theme_bw(base_size = 15)+
  theme(legend.position = "none",
        axis.text.y = element_text(size = 20),                  # increases size of vowel labels
        axis.title.y = element_text(margin = margin(r=-30)))+   # optional: for some reason the y axis title 
  labs(title = "Vowel Duration",                                # was way too far to the left
         x = "Duration (ms)")


##### Tables ######

install.packages("dplyr")  # only run this the first time you use it
library(dplyr)
attach(measurements)

# summarize() collapses all the rows with the same value of the variable
# specified in group_by() into one row. This can be the mean, max, min, median,
# etc. -- really any stat you want.

summary_table_vowel <- measurements %>%
  group_by(Vowel) %>%  # whatever category you're interested in
  summarize("Mean F1" = mean(F1),
            "Mean F2" = mean(F2),
            "Mean F3" = mean(F3),
            "Mean duration" = mean(Duration*1000), # *1000 to convert to ms
            "Mean F0" = mean(F0))

# Example of a different table
summary_table_coda <- measurements %>%
  group_by(Coda) %>%
  summarize("Mean duration" = mean(Duration*1000))
