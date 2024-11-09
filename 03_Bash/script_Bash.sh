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

for i in {A..Z}
do
	echo "$i"
	grep "^$i" "PoD.txt" | wc -l  # or LCP_students.csv to count everyone
	echo ""
done
