#/bin/bash
myarray=(1 2 3 4 5)
set ${myarray[*]}
#set -- ${myarray[*]}
atime=$1
b=$2
c=$3
d=$4
echo $atime
echo $b
echo $c
echo $d

