#!/bin/bash
#
# This is to demostrate FOR and WHILE Loop
#


<< Task

1 is argument 1 which is folder name
2 is start range
3 is end range

Task

read -p "Do you want to create folder [yes/no]?" folders

if [[ $folders == "yes" ]]
then

for ((i=$2; i<=$3; i++));
do
	mkdir "$1$i"
done

else
	echo "No Folders created"
fi


