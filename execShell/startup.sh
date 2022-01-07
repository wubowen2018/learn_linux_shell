#!/bin/bash

# 应用启动脚本
 umask 0022
 export ENV="FAT"
 export MOBAPP_CLUSTER="default"
 export JAVA_OPTS="-Xms512m -Xmx512m"
 SERVICE_NAME="service_name"

PATH_TO_JAR=$1

if [[ $PATH_TO_JAR == "" ]]; then
	for i in `ls -r $SERVICE_NAME-*.jar 2>/dev/null`; do
		PATH_TO_JAR=$i
		break
	done
fi

if [[ $PATH_TO_JAR == "" ]]; then
	echo "Cannot find $PATH_TO_JAR,Failed to start."
	exit -1;
fi

printf "==== $(date +%y-%m-%d) ======= $PATH_TO_JAR Starting =========\n"

nohup java -Denv=${ENV} -Dhades.rpc.registry.enable-nacos-registry=false -Dapollo.cluster=${MOBAPP_CLUSTER} ${JAVA_OPTS} -jar ${PATH_TO_JAR} >> startup.log

rc=#?;

if [[ $rc != 0 ]]; then
	echo "$(date +%y-%m-%d) Failed to start ${PATH_TO_JAR}, return $rc "
	exit $rc;
fi

printf "\n$(date +%y-%m-%d) Server started"

exit 0;


