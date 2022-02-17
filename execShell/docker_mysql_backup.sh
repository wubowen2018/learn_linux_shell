#!/bin/bash

sysdate=db_name_$(date+"%Y-%m-%d%H%M%S")
docker exec -it mysql mysqldump -uroot -p121212 test > /root/${sysdate}.sql
gzip -c /root/${sysdate}.sql > /root/${sysdate}.sql.gz