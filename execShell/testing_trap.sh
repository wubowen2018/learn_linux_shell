#!/bin/bash
#testing trap
trap "echo 'I have traped Ctrl-C' " SIGINT
count=1
while [ $count -le 10 ]
do 	
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

trap -- SIGINT
echo I just removed SIGINT

count=1
while [ $count -le 10 ]
do
	echo "Second loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done
	
	
	
	
