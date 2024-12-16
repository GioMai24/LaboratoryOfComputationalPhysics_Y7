#!/bin/bash

# Removing metadata and commas
# grep -v "^#" "data.csv" | sed -e "s/,/ /g" > "data.txt"


# Counting numbers in file
#grep -oE "[1-9]+" data.txt


# Distinguishing entries
les=()
gre=()
thr=$(echo "100*sqrt(3)/2" | bc -l)
for i in $(grep -oE "[1-9]+" < data.txt); do
	if [ $(echo "$i < $thr" | bc -l) -eq 1 ]; then 
		les+=("$i")
	else 
		gre+=("$i")
	fi
done
echo "Numbers lesser than $thr: ${#les[@]}"
echo "Numbers greater than $thr: ${#gre[@]}"


# Copy n times dividing by n each iteration
for i in $(seq 1 $1); do
	echo "$(grep -oE "[1-9]+")/$i" | bc -l > data_$i.txt
done
