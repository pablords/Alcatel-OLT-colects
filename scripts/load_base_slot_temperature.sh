#!/bin/bash



grep 1/1 /home/server/ALCATEL/db_medicao/slot_temperature/* | sed 's/:\| /;/g' | sed 's/\/home\/server\/ALCATEL\/db_medicao\/slot_temperature\///g' | tr -s ";" > /home/server/ALCATEL/load_base/slot_temperature/end_file.txt


mysql -uroot --local-infile=1 -e"load data local infile '"/home/server/ALCATEL/load_base/slot_temperature/end_file.txt"' 
into table db_alcatel.tb_slot_temperature fields terminated by ';' (armario, slot, sensor, temperature, tca_low, tca_high, shut_low, shut_high);"

