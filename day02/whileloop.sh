#!/bin/bash
#
# This is to demostrate WHILE LOOP
#



num=0

echo "Print even numbers only"

while [[ $((num%2))==0 && $num -le 10 ]]
do
	echo $num
	num=$((num+1)) 
done

