#!/bin/bash
while true
do
	sleep 1s
	nowTime=`date +%Y%m%d%H%M%S`
	connUser=`netstat -antp |grep 22 | grep ESTABLISHED | wc -l`
	usedCpu=`top -b -n 1 |grep Cpu |awk '{print $2}'`
	usedMem=`awk '/MemTotal/{total=$2}/MemFree/{free=$2}/Buffers/{buffers=$2}/^Cached/{cached=$2}END{print(total-free-cached-buffers)/total}' /proc/meminfo`
	echo "$nowTime:$connUser|$usedCpu|$usedMem" >> netstat.log
	echo "$nowTime:$connUser|$usedCpu|$usedMem" >> GetAve
	echo "$nowTime:$connUser|$usedCpu|$usedMem"
done
