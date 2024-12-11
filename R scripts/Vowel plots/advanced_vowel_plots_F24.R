# Amanda Bohnert, L541 F24

library(ggplot2)
library(dplyr)

# Make sure you import measurements.txt (or your data).

attach(measurements)

# First we need to generate the mean F1 and F2 measurements (like what we did
# in the Tables section of the simple vowel plots script) so that we can plot
# them.

vowel_means <- measurements %>%
  group_by(Vowel) %>%
  summarize(F1 = mean(F1),
            F2 = mean(F2))

# We can plot the means by themselves.
ggplot(vowel_means, aes(x=F2, y=F1, color=Vowel))+
  geom_text(label=vowel_means$Vowel, size=8, show.legend=F)+
  scale_x_reverse("F2 (Hz)")+
  scale_y_reverse("F1 (Hz)")+
  theme_bw(base_size=15)


# We can also plot the means AND the individual tokens.
ggplot(measurements, aes(x=F2, y=F1, color=Vowel))+
  geom_point(alpha=0.3, show.legend=F)+  # alpha is transparency (0 = transparent, 1 = opaque)
  geom_text(data=vowel_means, aes(label=Vowel), size=8, show.legend=F)+
  scale_x_reverse("F2 (Hz)")+
  scale_y_reverse("F1 (Hz)")+
  theme_bw(base_size=15)

# We can also add ellipses representing one standard deviation from the mean.
ggplot(measurements, aes(x=F2, y=F1, color=Vowel))+
  geom_point(alpha=0.5,show.legend=F)+
  stat_ellipse(geom = "polygon", level = .67, aes(fill=Vowel), alpha=0.2, 
               show.legend = F, size = NA)+  # can change outline with size
  geom_text(data=vowel_means, aes(label=Vowel), size=10, show.legend=F)+
  scale_x_reverse("F2 (Hz)")+
  scale_y_reverse("F1 (Hz)")+
  theme_bw(base_size=15)
