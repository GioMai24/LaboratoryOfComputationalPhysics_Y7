#!/bin/bash

if [ ! -d "students" ]  # it will create a directory in the current directory, not in Home
then
	mkdir students
fi


if [ ! -f "LCP_students.csv" ]  # checks if the file exists in the current directory, starts the download and copies it in the students directory, doesn't check if students directory contains the file
then
	wget -O "LCP_students.csv" "https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
	cp "LCP_students.csv" "students/LCP_students.csv"
else
	echo "The file already exists: it won't be downloaded nor copied in the students directory"
fi


cd "students"


if [ ! -f "PoD.txt" ]
then
	touch "PoD.txt"
	touch "Physics.txt"
	echo | grep "PoD" "LCP_students.csv" > "PoD.txt"
	echo | grep "Physics" "LCP_students.csv" > "Physics.txt"
fi


nummax=0
res=("None")
for i in {A..Z}
do
	temp=$(grep -c "^$i" "LCP_students.csv")
	echo "$i"
	echo "$temp"
	echo ""
	for x in ${res[@]}
	do
		if [ $temp -eq $nummax ]
		then
			res+=("$i")
		elif [ $temp -gt $nummax ]
		then
			nummax=$temp
			res="$i"
		fi
	done
done
echo "The letter with most counts over all students is $res"


n=1
for i in $(seq 2 18 $(wc -l <  "LCP_students.csv"))
do
	touch "group_$n.txt"
	echo | sed -n "$i,$((($i+17)))p" "LCP_students.csv" > "group_$n.txt"
	((n++))
done
