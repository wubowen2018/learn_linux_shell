#!/bin/bash
today=$(date +%Y%m%d%H)
cat /etc/passwd > userInfo.$today
