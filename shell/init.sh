#!/bin/bash
cron -f >>/data/cron.log &
if [  -f "/data/bi/task" ]
then 
	/etc/init.d/cron start
        chmod +x /data/bi/*.sh
        crontab /data/bi/task
fi

while [ "1" -eq "1" ]
do
 sleep 1000
done