# IUB LING-L541 script archive
This is an archive of Praat and R scripts I have written and used for LING-L541. 

## Organization
There are three folders here: Praat scripts, R tutorials, and R scripts.

R tutorials will walk you through the script, explaining the code along the way. The files in R scripts are intended to be templates that you can use to build your own scripts. Currently, as I am in the process of converting the files in the R scripts folder to be tutorials, most of the files still have a lot of explanation.

## Current contents
### Praat scripts
Remember to look at the instructions at the top when you open the script in Praat.
1. *duration-only.praat*: This will get the duration of all labeled intervals in a TextGrid.
2. *midpoint_duration_F0F1F2F3.praat*: This will get the *midpoint* F0, F1, F2, and F3 of all labeled intervals in a TextGrid. It will also get the duration.

### R scripts
Each of these is in a folder which contains the script and the dataset I used to write the script. You can use the dataset to figure out what data you need to generate the plot and how it needs to be organized.

#### F0
This will generate three types of F0 contour plots.
   1. The first will generate **one** contour plot.  
      <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/f0_1.png" width="400px">
   2. The second will generate **one** contour plot, but split at some point. This is useful for looking at F0 before and after a consonant, for example.  
      <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/f0_2.png" width="400px">
   3. The third will generate **two** contour plots, split by a point. This is the same as the last plot, but just presented differently.  
      <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/f0_3.png" width="400px">

#### VOT
This will generate a bar plot for showing VOT.  
<img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/VOT.png" width="400px">

#### Vowel plots: 
This folder has several scripts in it.
1. *simple_vowel_plot_and_duration.R*: This will generate a simple vowel plot, with data points as IPA symbols, and a bar plot for duration.  
   <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/vowel1.png" width="300px">
   <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/vowel2.png" width="300px">
2. *advanced_vowel_plot.R*: This will also generate a vowel plot, but \~fancier\~. It will plot the individual tokens, the vowel means, and an ellipse representing one standard deviation from the mean.  
   <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/vowel5.png" width="300px">
3. *Simple vowel plots R notebook (see note at bottom)*: This will fairly automatically generate the same vowel plot and duration plot as in (1). The difference is that in this script, all you have to do is specify the column names that store the IPA, F1, F2, and duration information and it will generate from there. I.e., you don't have to wade through the script changing all the variable names.
4. *Advanced vowel plot R notebook (see note at bottom)*: Similarly, this will generate the same plot as in (2) but with much less effort on your part.
  
### R tutorials
The sample data sets used in some of these tutorials can be found in the Sample data sets folder.
1. *Rtutorial1_F24.R*: This is a tutorial introducing you to R/RStudio. It covers the basics of what R does, as well as some plotting within stock R.
2. *ggplot2_tutorial1.R*: This is a tutorial introducing you to the plotting package ggplot2. It covers histograms, box plots, and scatter plots.
3. *Grouped bar plot tutorial (see note at bottom)*: This will go through how to generate a grouped box plot in ggplot2.  
   <img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/barplot1.png" width="400px">

## Note on R notebooks
Some of these scripts are in R notebooks--these are the files with the file extension .rmd. These are different from regular R scripts, which have the file extension .R. 

R notebooks are more like a document with interactive chunks of script. I think these are particularly useful for tutorials and more automated scripts, as the explanations are much easier to read and you can segment out different parts of the code quite nicely.

You should be able to double-click these and have them open in RStudio. When you open them, they might look like the image on the left. If you click "Visual" (circled), it will look much prettier, like on the right.  
<img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/rnotebook1.png" width="300px">
<img src="https://github.com/abohnert/LING-L541-scripts/blob/main/src/images/rnotebook2.png" width="300px">

There is also a .html file in each folder with a notebook. This is because everytime you save an R notebook file, it will generate an html document of the file. You can basically just ignore this; they're just in there because it's a pain to keep deleting them.
