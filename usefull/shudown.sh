#!/bin/bash

# 停止应用
JAR_NAME=server_name
ps -ef |grep ${JAR_NAME} | awk '{print $2}' |xargs -r kill
sleep 5
ps -ef |grep ${JAR_NAME} | awk '{print $2}' |xargs -r kill -9
echo "========= Application shudown ========"
