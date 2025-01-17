#!/bin/bash

# Removing metadata and commas
#grep -v "^#" "data.csv" | sed -e "s/,/ /g" > "data.txt"


# Counting even numbers in file
echo 'Even numbers:' $(grep -oP '[02468]\b' data.txt | wc -w)


# Distinguishing entries
les=0
gre=0
thr=$(echo "scale=3;100*sqrt(3)/2" | bc)
for i in $(grep -oE "[0-9]+" data.txt); do  # grep method, I don't know if more efficient than cat
	if [[ $(echo "scale=5;$i < $thr" | bc) == 0 ]]; then ((les++))
	else ((gre++)); fi
done
echo "Numbers lesser than $thr: $les"
echo "Numbers greater than $thr: $gre"


les=0
gre=0
for i in $(cat data.txt); do  # cat method, cleaner to code
	if [[ $(echo "scale=5;$i < $thr" | bc) == 0 ]]; then ((les++))
	else ((gre++)); fi
done
echo "Numbers lesser than $thr: $les"
echo "Numbers greater than $thr: $gre"


# Copy n times dividing by n each iteration (It isn't much of a copy, since the lines aren't preserved
# to do that we can use awk...)
for i in $(seq 1 $1); do
	for j in $(cat data.txt); do echo "scale=2; $j / $i" | bc >> data_$i.txt
       	done
done

for i in $(seq 1 $1); do
	awk -v div=$i '{for (j=1; j<=NF; j++) $j /= div}1' data.txt > edata_$i.txt; done
