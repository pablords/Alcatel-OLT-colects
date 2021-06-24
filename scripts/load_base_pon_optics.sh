#!/bin/bash



grep 1/1 /home/server/ALCATEL/db_medicao/pon_optics/* | sed 's/:\| /;/g' | sed 's/\/home\/server\/ALCATEL\/db_medicao\/pon_optics\///g' | tr -s ";" > /home/server/ALCATEL/load_base/pon_optics/end_file.txt


mysql -uroot --local-infile=1 -e"load data local infile '"/home/server/ALCATEL/load_base/pon_optics/end_file.txt"' 
into table db_alcatel.tb_pon_optics fields terminated by ';' (armario, pon, tx, temperature, voltage, laser);"


