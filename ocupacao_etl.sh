#!/bin/bash

wget -c -P /home/server/FTP ftp://root@ip/IT_DATA_BASE/*


/home/server/Pentaho/9.0/./kitchen.sh -file="/home/server/job/ETL_OCUPACAO.kjb" -level="Detailed">/home/server/job/ETL_OCUPACAO.txt






