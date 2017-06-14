#!/bin/bash

#import chinese
export LANG="en_US.UTF-8"

#source the evn profile
source ~/.profile

#setting date for log perday
to_date=`date +%Y%m%d`
#create kettle log path
mkdir -p /data/kettlelog
##go to kettle soft dir
kitchen.sh -rep zn -user admin -pass  -dir  -job all_job  -level=basic  >/data/kettlelog/all_job_${to_date}.log

echo "Ö´ÐÐÍê³É£¡"