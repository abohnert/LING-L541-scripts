###################################################
#######                                    ########
#######         Intro to ggplot 2!         ########
#######                                    ########
###################################################

# Made by Amanda Bohnert, Spring 2022, updated Fall 2024

# Last week we learned the basics of R: how to do basic calculations, how to 
# write functions, how to import datasets, and how to do some basic plotting.

# The plotting functions of stock R are somewhat limited, but because R 
# allows you to use packages to add new features, we can use a different
# package to make better plots--ggplot2.

# First, we need to install & load ggplot2 into our script with the following 
# commands:
install.packages("ggplot2")
library(ggplot2)

# You only need to install a package once, but you will need to use library()
# to load it in each individual script you want to use it in.

# We also need to load a dataset, so let's use the one from last week so that
# we can see how much better we can make our plots.

# Import the same RussianExam.xlsx dataset and attach it.
attach(RussianExam)

# When you make a plot with ggplot2, you always start with the same command:
ggplot(data, aes())

# 'data' specifies the dataset you want to use (RussianExam).
# 'aes' stands for aesthetics. This argument specifies various things about
# *everything* in your plot: what goes on the x axis, what goes on the y axis, 
# how color, shapes, size, is assigned to data points, etc. I say 'everything in
# the plot' because what ggplot2 allows you to do is to keep adding *layers*. If
# something is specified in aes, it will carry on through *all* the layers.


#### Histograms ####

# Let's first make a histogram of these students' scores.

# First, we need our basic command. We're using the 'RussianExam' dataset, so
# we enter that in first. In 'aes' we just need one basic thing: what goes on
# the x axis. We're plotting scores, so put 'x = Score' here.
ggplot(RussianExam, aes(x = Score))

# This doesn't quite work yet--we've got the basic elements, but we need to add
# a layer with the type of plot we want. To add layers, you need to add a '+'
# to link the layers together.

# Inside the parentheses in each layer, there are arguments specific to just that
# layer. For a histogram, we want to specify the bin width, or how wide the bars
# are. Let's make the bin width 5 (i.e, it will count the frequency of scoring
# 61-75, 76-80, etc.)
ggplot(RussianExam, aes(x = Score)) +
  geom_histogram(binwidth = 5)

# This works, but doesn't look great. Let's add some things to make it look nice.
# To change the formatting, you also use layers.
ggplot(RussianExam, aes(x = Score)) +
  geom_histogram(binwidth = 5,
                 fill = 'darkslategray3',     # Specifies the fill color of the bars
                 color = 'white') +           # Specifies the outline color
  theme_bw() +                                # There are many themes you can use
  #theme_minimal() +                          # for your plots--remove the # signs
  #theme_light() +                            # to try out the other two.
  labs(title = "Score distribution",          # Adds titles
       y = "Frequency")

# This is looking good! There are other formatting things we could do, but let's
# move on and make some box plots. We'll start with the score distribution
# broken down by L1, just like we did last week.


#### Boxplots ####

# We start with the same base command. For aes, we want to specify what goes on
# each axis. For a boxplot, we want a categorical variable on the x axis and a
# continuous variable on the y axis. 

# So here, we want Score on the y axis and L1 on the x axis. In aes, we can also 
# indicate color coding--here, let's have each L1 box plot be a different color.
ggplot(RussianExam, aes(x = L1, y = Score, fill = L1)) +
  geom_boxplot(show.legend = F) +
  theme_bw() +
  labs(title = "Scores by L1")


#### Scatter plots ####

# Let's make a scatter plot of to see if score correlates with years of exposure. 
# Start with the same base command. Let's add some extra detail and make the shape
# and color of the data points change based on the student's proficiency level.
ggplot(RussianExam, aes(x = Exposure, y = Score, shape = Proficiency, 
                        color = Proficiency)) +
  geom_point(size=3) +
  theme_bw() +
  labs(title = "Scores vs. exposure")


# If we want to add a trend line, we have to shift the shape and color specifications
# to only the relevant layer (otherwise we get trend lines for every proficiency).
# So, let's get rid of the shape argument and color argument in the first line,
# and add it to just geom_point.
# Note that we have two layers here -- the points (geom_point) and the line (geom_smooth).
ggplot(RussianExam, aes(x = Exposure, y = Score)) +
  geom_point(aes(color = Proficiency, shape = Proficiency), 
             size = 3) +
  geom_smooth(method = "lm",              # adds a linear trend line (lm = linear model)
              color = "black",            # sets the color of the line
              se = FALSE) +               # makes it not show a confidence interval
  theme_bw() +
  labs(title = "Scores vs. exposure")
