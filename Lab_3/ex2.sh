#!/bin/bash

if [[ -z $1 ]]; then echo "./ex2.sh: make sure to pass an input, it must be an integer value."; exit 1; fi

# Removing metadata and commas
grep -v "^#" "data.csv" | tr -d ',' > "data.txt"


echo 'Even numbers:' $(grep -oP '[02468]\b' data.txt | wc -w)


# Distinguishing entries
les=0; gre=0
thr=$(echo "100*sqrt(3)/2" | bc -l)
while read x y z _ _ _; do
	num=$(echo "sqrt($x^2 + $y^2 + $z^2)" | bc -l)
	if [[ $(echo "$num < $thr" | bc -l) == 0 ]]; then ((les++))
	else ((gre++)); fi
done < data.txt

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
