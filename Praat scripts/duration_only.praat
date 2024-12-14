# This script will get the duration of all labeled intervals.
# You must open and select one TextGrid before running the script.
#
# Created by Amanda Bohnert, Nov 2024. 
# Based on Mietta Lennes' collect_formant_data_from_files script.

form Get duration and F0-F3 measurements at midpoints from labeled segments in file
	comment Full path of the resulting text file:
	text resultfile measurements.txt
	comment Which tier do you want to analyze?
	integer tier 1
endform

if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete 'resultfile$'
endif

titleline$ = "Segment label,Duration'newline$'"
fileappend "'resultfile$'" 'titleline$'

gridfile = selected: "TextGrid"

select gridfile
numberOfIntervals = Get number of intervals... tier
for interval to numberOfIntervals
	label$ = Get label of interval... tier interval
	if label$ <> ""
		start = Get starting point... tier interval
		end = Get end point... tier interval
		midpoint = (start + end) / 2
		duration = end - start
		# Save result to text file:
		resultline$ = "'label$','duration''newline$'"
		fileappend "'resultfile$'" 'resultline$'
		select gridfile
	endif
endfor


