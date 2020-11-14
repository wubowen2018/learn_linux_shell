#!/bin/bash
#test for multi-function
name=$(basename $0)
if [ $name = "addem" ]
then
	total=$[ $1 + $2 ]
elif [ $name = "multem" ]
then
	total=$[ $1 * $2 ]
fi
echo The caculated value is $total
