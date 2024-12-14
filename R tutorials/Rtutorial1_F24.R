###################################################
#######                                    ########
####### Exploring R for the first time : ) ########
#######                                    ########
###################################################

# Original by Chien-Han Hsiao, Spring 2020
# Updated by Amanda Bohnert, Spring 2022 & Fall 2024

# Welcome to R!  In this tutorial, you will get to explore
# the basics of the R programming language.  We'll learn that
# R can be used as a calculator and that it can store information 
# in variables, and then we'll learn how to load data files, and how
# to make a few different types of plots.  


###### R can calculate stuff #######

# Let's see how R can be used as a calculator. Below is 
# a simple math problem. As you can see, the numbers are
# just sitting there.  How do you tell R what to do?
# You'll need to tell R to run the script. If you are 
# using RStudio, highlight the equation and click "Run"
# at the top of this window.

1+1

# You'll notice that the following text appeared in the Console
# window, probably right below this window:

# > 1+1
# [1] 2

# The first line 'echos' the command.
# The second line is the output of the command.
# You can ignore the [1] for now, and you will find the 
# output of the equation next to it.

# Run the following commands and see what happens.
# Also, feel free to try your own commands!

13 + 7

10 - 3

12*12

48/8

5^2

# At this point, I want to mention that the pound symbol --> #
# can be used to include comments in your code (as I've done throughout).
# When R comes to a pound symbol, it stops reading that line.
# In the scripts we'll look at later, you'll see how comments
# can be very helpful in organizing scripts and telling the user
# what the code does.

###### Variables #######

# Now run the next three lines and see what happens!

a = 2
b = 5
a + b 

# When you ran this code, you told R to store the numbers
# as variables.  Variables are very important in R.  Let's 
# see more about what variables can store.

a <- 7
b <- 3
a + b 

# The three lines above show you two things.  First, you 
# use the 'less than' sign followed by a dash instead of the
# equals sign.  Second, you can reassign the values 
# associated with a variable.

# Variables don't just have to be single numbers, though.

a = c(1, 2, 3, 4, 5)

# What we've done here is create a 'vector'.
# Look in the top right window of RStudio and you'll
# see a list of values for any variables.  You'll notice
# that a has the value 'num [1:5] 1 2 3 4 5'
# This means that a is a series of numbers occupying
# slots 1-5 in a vector and that the contents of
# those slots are 1 2 3 4 and 5.

# What can we do with a vector?

b = 2
a^b

# Running the above two lines sets the variable b to 2 and 
# then asks R to raise each value in a to the 2nd power.

# You can also easily create a variable that contains 
# the output of a formula.

c = a^b
show(c)

# You'll notice that just declaring the value of c
# doesn't cause R to output the results of the formula
# in the Console window.  You can see the contents of c
# in the Values window, but in order to see the contents of 
# c in the console, you have to ask R to show you c.

# You can also store text in a variable!

myText = "Hello World!"
show(myText)


###### Computations #######

# You can easily calculate descriptive statistics in R.
# Below, we've set the variable randomData to be a vector containing
# 200 numbers with a mean of 5 and a standard deviation of 10. 

randomData = rnorm(n=200, mean=5, sd=10)

# We can calculate the mean, median, and standard deviation of a number
# or a vector using the commands below.

mean(randomData)
median(randomData)
sd(randomData)

###### Functions #######

# If you need to perform a more complex calculation multiple times, you
# can make a function to more easily plug in values.

# Let's make a function to convert a temperature in Fahrenheit to Celsius.
# First, we need to tell R that we are making a function and we need to
# give our function a name. 
# Type in the name of your function ('tempConvert'), and then = function().
# In the parentheses, put in the name of the input variable(s) you are going to
# use within the function ('f'). After that goes a set of curly brackets.
# Inside the curly brackets is where you put the calculation you want to
# perform. 

tempConvert = function(f) {  # This function takes one variable, f.
  c = (f-32)*(5/9)           # This line performs the conversion calculation and stores it as an internal variable c.
  return(c)                  # This line tells R to show us the resulting number.
}

# You will see that the function now appears in the window on the top right.

# To run your function, type in the name of the function followed by
# parentheses. Inside the parentheses goes whatever you want to run
# through the function.

tempConvert(98.6)
tempConvert(c(32, 72, 98.6, 212)) # You can also input a vector to perform
                                  # multiple calculations at once!



##############################
###### The Main Event! #######
######     Plotting    #######
##############################



### Click on File > Import Dataset > From Excel
### Browse > find the file named 'Rtutorial1-Russian exam'
### When you import data, set Student to character, 
### Proficiency to character, Score to numeric, 
### L1 to character, Age to numeric, and Exposure to numeric.


attach(RussianExam) # Attach the dataset so you can use the column names in R.
View(RussianExam)   # To look at the data, use the view command (or you can
                    # double click on it in the window on the right.)

# In this data file, the first column is the student's ID (in letters).
# The second column is the student's proficiency level.
# The third is the student's exam score.
# The fourth is the student's L1.
# The fifth is the student's Age.
# The sixth is the student's years of exposure to Russian.


# Now let's make some basic plots with this dataset!

# Dot plot
dotchart(x=Score,labels=Student, xlab='Score', ylab='Student', main='Scores of students')
# With the command above, we made a plot of each student's score.
# x is the data you are plotting. 
# labels are the labels you'd like to give to the data.
# xlab is the label of the x axis.
# ylab is the label of the y axis.
# main is the title of the plot


# Barplot
# The command below plots each student's age.
barplot(height=Age, xlab='Student', ylab='Age', main='Age', ylim=c(0,25), names.arg=Student)

# height is the data you want to use for the height of each bar.


# The command below gives you the frequency for the levels of whatever 
# variable you enter. Here, it will tell us how many students are of each age.
table(Age)

# The command below gives you the summary barplot of the student's age 
# (basically a histogram).
barplot(height=table(Age), xlab='Age', ylab='Number of students', main='Age')


# Histogram
# The command below plots the histogram of the student's scores. The x-axis has 3 breaks.
hist(x=Score, breaks=3, col='salmon', xlab='Score', ylab='Number of students', main='Score distribution')

#The command below plots the histogram of the student's years of exposure. The x-axis has 5 breaks.
hist(x=Exposure, breaks=4, col='salmon', xlab='Exposure (years)', ylab='Number of students', main='Exposure to Russian')



# Scatter plot
# The command below plots each student's score vs their age.
# This helps us see if there is a correlation between the student's age and exam score.
plot(x=Age,y=Score, xlab='Age', ylab='Score', main='Score vs Age')


# Below is the same code in a different layout. Some people (me) prefer to code this way.
plot(x=Age,
     y=Score,
     xlab='Age',
     ylab='Score',
     main='Score vs Age')

#The command below plots each student's Exposure vs score.
plot(x=Exposure,y=Score, xlab='Exposure (year)', ylab='Score', col='orange', main='Score vs Exposure')

# The command below adds a trendline to your scatter plot. 
# abline is what we use to plot lines. 
# lm stands for linear model.
# Score~Exposure (read: 'Score by exposure') is the formula we are feeding lm.
abline(lm(formula=Score~Exposure)) 



# Box plot
# The command below plots the student's score broken down by age. 
boxplot(formula=Score~Age, col='orange', xlab='Age', ylab='Score', main='Score by Age')
boxplot(formula=Score~L1, col='orange', xlab='L1', ylab='Score', main='Score by L1')

