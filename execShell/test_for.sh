#!/bin/bash
list="/mnt/hgfs/additionFolder/shell/*"
for file in $list
do
	if [ -d "$file" ]
	then
		echo "$file is a directory"
	elif [ -f "$file" ]
	then
		echo "$file is a file"
	fi
done
