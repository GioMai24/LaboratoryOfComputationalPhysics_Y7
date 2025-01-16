#!/bin/bash


# Create students directory if it doesn't exist
if [ ! -d "students" ]; then mkdir students; fi


# Download file if it doesn't exist
if [ ! -f "students/LCP_students.csv" ]; then
	wget -O "LCP_students.csv" "https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
	cp "LCP_students.csv" "students/LCP_students.csv"
else echo "The file already exists: it won't be downloaded nor copied in the students directory"; fi



cd "students"


if [ ! -f "PoD.txt" ]; then touch "PoD.txt"; touch "Physics.txt"
	echo | grep "PoD" "LCP_students.csv" > "PoD.txt"
	echo | grep "Physics" "LCP_students.csv" > "Physics.txt"
fi


nummax=0; res=("None")
for i in {A..Z}; do
	temp=$(grep -c "^$i" "LCP_students.csv")
	echo "$i"; echo "$temp"; echo ""
	for x in ${res[@]}; do
		if [ $temp -eq $nummax ]; then res+=("$i")
		elif [ $temp -gt $nummax ]
		then
			nummax=$temp
			res="$i"
		fi
	done
done
echo "The letter with most counts over all students is $res"


n=1
for i in $(seq 2 19)  # Since it's modulo 18 u skip 18 names, hence you must span through the skipped ones to include everyone
do
	touch "group_$n.txt"
	echo | sed -n "$i~18p" "LCP_students.csv" > "group_$n.txt"
	((n++))
done
