#!/bin/bash
#
# This script will demonstract IF ELSE conditional statemnt and this is just for infoTainment Purpose
#

read -p "Jetha ne mud ke kise dekha: " bandi
read -p "Jetha ka pyar in %: " pyaar

if [[ $bandi == "daya bhabhi" ]];
then
	echo "Jetha is loyal"

elif [[ $pyaar -ge 100  ]]
then
	echo "Jetha is loyal"

else
	echo "Jetha is not loyal"
fi
