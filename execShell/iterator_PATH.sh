#!/bin/bash
IFS.OLD=$IFS
IFS=:
for folder in $PATH
do
	for file in $folder/*
	do
		if [ -x $file ]
		then
			echo "-->	$file"
		fi
	done
done > path.file

cat path.file
IFS=$IFS.OLD












