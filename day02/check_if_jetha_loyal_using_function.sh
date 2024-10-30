#!/bin/bash
#
# This script will demonstract IF ELSE conditional statemnt and this is just for infoTainment Purpose
#

#this is function definition
function is_loyal(){

read -p "$1 ne mud ke kise dekha: " bandi
read -p "$1 ka pyar in %: " pyaar

if [[ $bandi == "daya bhabhi" ]];
then
	echo "$1 is loyal"

elif [[ $pyaar -ge 100  ]]
then
	echo "$1 is loyal"

else
	echo "$1 is not loyal"
fi

}


#this is function call
is_loyal "tom"


