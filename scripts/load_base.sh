#!/bin/bash



grep tx-power /home/server/ALCATEL/db_medicao/xfp1/* | sed 's/:\| /;/g' |sed 's/"//g'| sed 's/dBm//g' | sed 's/\/home\/server\/ALCATEL\/db_medicao\/xfp1\///g' | tr -s ";" > /home/server/ALCATEL/load_base/xfp1/end_file.txt



/home/server/9.0/./kitchen.sh -file="/home/server/job/xfp1.kjb" -level="Detailed">/home/server/job/xfp1.txt
