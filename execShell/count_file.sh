#!/bin/bash
count=0
IFS.OLD=$IFS
IFS=$'\n'
for file in $(lsof)
do
	if [ -f $file ];then
		count=$[ $count + 1 ]
	fi
done
echo Linux opened $count files.
IFS=$IFS.OLD

