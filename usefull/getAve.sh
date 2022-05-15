#!/bin/bash
LNum=`cat GetAve |wc -l`
Cpu=`awk -F '[|]*' '{cpu=cpu+$2}END{print cpu}' GetAve`
Mem=`awk -F '[|]*' '{mem=mem+$3}END{print mem}' GetAve`
CpuAve=`echo "$Cpu $LNum" |awk '{printf("%0.2f",$1/$2)}'`
MemAve=`echo "$Mem $LNum" |awk '{printf("%0.2f",$1/$2)}'`
MemAve=`echo "$MemAve*100"|bc`
echo "The lines:$LNum,usedCpu:$CpuAve%,usedMem:$MemAve%"
rm -f GetAve


