#!/bin/bash
ServerIP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
ServerUser=`whoami`

echo $ServerIP
echo $ServerUser

