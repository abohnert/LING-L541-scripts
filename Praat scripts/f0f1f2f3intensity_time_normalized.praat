# This script will get time-normalized F0, F1, F2, F3, and Intensity measurements for all labeled intervals in a TextGrid.
# You must open and select one sound and one TextGrid before running the script.
#
# Created by Amanda Bohnert, Dec 2024. 

Text writing preferences: "UTF-8"
form Get time-normalized F0, F1, F2, F3, and intensity measurements across the duration of labeled segments in file
	comment Full path of the resulting text file:
	text resultfile measurements.txt
	comment Which tier do you want to analyze?
	integer tier 1
	comment Number of timepoints
	integer timepoints 10
	comment Formant analysis parameters
	integer maximum_number_of_formants 5
	positive maximum_formant_(Hz) 5500_(=adult female)
endform

if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete 'resultfile$'
endif

titleline$ = "Label,Time,Timepoint,F0,F1,F2,F3,Intensity'newline$'"
fileappend "'resultfile$'" 'titleline$'

soundname$ = selected$: "Sound"
sound = selected: "Sound"
gridfile = selected: "TextGrid"

select sound
To Intensity... 100 0
select sound
To Pitch... 0 75 600
select sound
To Formant (burg)... 0 maximum_number_of_formants maximum_formant 0.025 50
select sound

procedure rename_und: var
	if var = undefined
		var$ = "NA"
	endif
endproc

select gridfile
numberOfIntervals = Get number of intervals... tier
ntimepoints = timepoints - 2
for interval to numberOfIntervals
	label$ = Get label of interval... tier interval
	resultline$[1] = label$
	if label$ <> ""
		for n to timepoints
			start = Get starting point... tier interval
			end = Get end point... tier interval
			inttime = (end-start)/(timepoints-1)
			time = start + (inttime * (n-1))
			resultline$[2] = string$(time)
			resultline$[3] = string$(n)
			select Pitch 'soundname$'
			f0 = Get value at time... time Hertz Linear
			if f0 = undefined
				resultline$[4] = ""
			else
				resultline$[4] = string$(f0)
			endif
			select Intensity 'soundname$'
			intensity = Get value at time... time cubic
			if intensity = undefined
				resultline$[5] = ""
			else
				resultline$[5] = string$(intensity)
			endif
			select Formant 'soundname$'
			f1 = Get value at time... 1 time Hertz Linear
			if f1 = undefined
				resultline$[6] = ""
			else
				resultline$[6] = string$(f1)
			endif
			f2 = Get value at time... 1 time Hertz Linear
			if f2 = undefined
				resultline$[7] = ""
			else
				resultline$[7] = string$(f2)
			endif
			f3 = Get value at time... 1 time Hertz Linear
			if f3 = undefined
				resultline$[8] = ""
			else
				resultline$[8] = string$(f3)
			endif
			for i from 1 to 7
				appendFile: resultfile$,resultline$[i],","
			endfor
			appendFile: resultfile$,resultline$[8],newline$
			select gridfile
		endfor
	endif
endfor

select Pitch 'soundname$'
Remove
select Intensity 'soundname$'
Remove
select Formant 'soundname$'
Remove