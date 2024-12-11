# This script will get the duration of all labeled intervals as well as F0-F3
# measurements at the midpoint of each interval.
# You must open and select one sound and one TextGrid before running the script.
#
# Created by Amanda Bohnert, Nov 2024. 
# Based on Mietta Lennes' collect_formant_data_from_files script.

form Get duration and F0-F3 measurements at midpoints from labeled segments in file
	comment Full path of the resulting text file:
	text resultfile measurements.txt
	comment Which tier do you want to analyze?
	integer tier 1
	comment Formant analysis parameters
	integer maximum_number_of_formants 5
	positive maximum_formant_(Hz) 5500_(=adult female)
endform

if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete 'resultfile$'
endif

titleline$ = "Segment label,Duration,F1,F2,F3,F0'newline$'"
fileappend "'resultfile$'" 'titleline$'

soundname$ = selected$: "Sound"
sound = selected: "Sound"
gridfile = selected: "TextGrid"

select sound
To Formant (burg)... 0 maximum_number_of_formants maximum_formant 0.025 50
select sound
To Pitch... 0 75 600

select gridfile
numberOfIntervals = Get number of intervals... tier
for interval to numberOfIntervals
	label$ = Get label of interval... tier interval
	if label$ <> ""
		start = Get starting point... tier interval
		end = Get end point... tier interval
		midpoint = (start + end) / 2
		duration = end - start
		# get the formant values at that interval
		select Formant 'soundname$'
		f1 = Get value at time... 1 midpoint Hertz Linear
		f2 = Get value at time... 2 midpoint Hertz Linear
		f3 = Get value at time... 3 midpoint Hertz Linear
		select Pitch 'soundname$'
		f0 = Get value at time... midpoint Hertz Linear
		# Save result to text file:
		resultline$ = "'label$','duration','f1','f2','f3','f0''newline$'"
		fileappend "'resultfile$'" 'resultline$'
		select gridfile
	endif
endfor

select Formant 'soundname$'
Remove
select Pitch 'soundname$'
Remove


