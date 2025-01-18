#!/bin/bash

# Make directory at $HOME
#mkdir ~/students


# Download file if it doesn't exist (I used another directory for the exercise)
if [[ ! -f students/LCP_students.csv ]]; then
	wget -O 'LCP_students.csv' 'https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv'
	cp "LCP_students.csv" "students/LCP_students.csv"
else echo "The file already exists: it won't be downloaded nor copied in the students directory"; fi


# I assume we want to work in the students directory
cd "students"


# Separate students of PoD from Physics
grep "PoD" "LCP_students.csv" > "PoD.csv"
grep "Physics" "LCP_students.csv" > "Physics.csv"


echo 'Letter count:'
nummax=0; res=''
for i in {A..Z}; do
	# tail ensures we skip the header which would count an additional F
	count=$(tail -n +2 LCP_students.csv | grep -c "^$i")
	echo "$i: $count"
	if (( $count == $nummax )); then res+=" $i"
	elif (( $count > $nummax )); then
		nummax=$count
		res="$i"
	fi
done
echo "The letter\s with most counts over all students is\are: $res"


# Create groups modulo 18 (seq starts at 2 to avoid headerline)
for i in $(seq 2 19); do 
	sed -n "$i~18p" "LCP_students.csv" > "group_$(($i-1)).csv"
done
