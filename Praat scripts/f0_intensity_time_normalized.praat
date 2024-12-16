# This script will get time-normalized F0 and Intensity measurements for all labeled intervals in a TextGrid.
# You must open and select one sound and one TextGrid before running the script.
# Any undefined F0 or intensity will be indicated "NA".
#
# Created by Amanda Bohnert, Dec 2024. 
# Update 12/16: Fixed issue causing F0/intensity to be imported to other programs as a string

Text writing preferences: "UTF-8"
form Get time-normalized F0 and intensity measurements across the duration of labeled segments in file
	comment Full path of the resulting text file:
	text resultfile measurements.txt
	comment Which tier do you want to analyze?
	integer tier 1
	comment Number of timepoints
	integer timepoints 10
endform

if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete 'resultfile$'
endif

titleline$ = "Label,Time,Timepoint,F0,Intensity'newline$'"
fileappend "'resultfile$'" 'titleline$'

soundname$ = selected$: "Sound"
sound = selected: "Sound"
gridfile = selected: "TextGrid"

select sound
To Intensity... 100 0
select sound
To Pitch... 0 75 600

select gridfile
numberOfIntervals = Get number of intervals... tier
ntimepoints = timepoints - 2
for interval to numberOfIntervals
	label$ = Get label of interval... tier interval
	if label$ <> ""
		for n to timepoints
			start = Get starting point... tier interval
			end = Get end point... tier interval
			inttime = (end-start)/(timepoints-1)
			select Pitch 'soundname$'
			time = start + (inttime * (n-1))
			f0 = Get value at time... time Hertz Linear
			if f0 = undefined
				f0$ = ""
				select Intensity 'soundname$'
				intensity = Get value at time... time cubic
				if intensity = undefined
					intensity$ = ""
					resultline$ = "'label$','time','n','f0$','intensity$''newline$'"
					fileappend "'resultfile$'" 'resultline$'
				else
					resultline$ = "'label$','time','n','f0$','intensity''newline$'"
					fileappend "'resultfile$'" 'resultline$'
				endif
			else
				select Intensity 'soundname$'
				intensity = Get value at time... time cubic
				if intensity = undefined
					intensity$ = ""
					resultline$ = "'label$','time','n','f0','intensity$''newline$'"
					fileappend "'resultfile$'" 'resultline$'
				else
					resultline$ = "'label$','time','n','f0','intensity''newline$'"
					fileappend "'resultfile$'" 'resultline$'
				endif
			endif
			select gridfile
		endfor
	endif
endfor

select Pitch 'soundname$'
Remove
select Intensity 'soundname$'
Remove
