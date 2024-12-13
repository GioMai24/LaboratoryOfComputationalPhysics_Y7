#sed  '/^#/d' "data.csv" | sed 's/,/ /g' > "data.txt"

for i in $(seq 1 $(wc -w < "data.txt")); do
echo $i; done

