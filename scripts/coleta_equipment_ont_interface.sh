#!/bin/bash

dia=`date +%d_%m_%y`
inicio=`date +%D-%T`

linha=0
linha=$1

user=$user
password=$password

for ip in `cat /home/server/ALCATEL/host`

do

/usr/bin/expect <<FIN_EXPECT | grep 1/1 >/home/server/ALCATEL/db_medicao/equipment_ont_interface/$ip



set timeout 600



spawn ssh user@$ip

sleep 2

expect {
    "Are you sure you want to continue connecting" {send "yes\r"; exp_continue}
    "password:" {send "password\r"}
}

expect "*#" {send "show equipment ont interface\r"}

expect "*#" {send "logout\r"}

expect eof

FIN_EXPECT
done

fim=`date +%D-%T`

ttl_cli=`cat /home/server/ALCATEL/db_medicao/equipment_ont_interface/$ip | wc -l | awk '{print $1}'`
echo inicio $inicio e temino $fim $ip coletados $ttl_cli>>/home/server/ALCATEL/log_lista_medicao/log_lista_medicao_file_$dia.txt

grep 1/1 /home/server/ALCATEL/db_medicao/equipment_ont_interface/* | sed 's/:\| /;/g' | sed 's/\/home\/server\/ALCATEL\/db_medicao\/equipment_ont_interface\///g' | tr -s ";" > /home/server/ALCATEL/load_base/equipment_ont_interface/end_file.txt

/opt/lampp/bin/./mysql -uroot -Ddb_alcatel --local-infile=1 -e"load data local infile '"/home/server/ALCATEL/load_base/equipment_ont_interface/end_file.txt"' into table db_alcatel.tb_equipment_ont_interface fields terminated by ';' (ip, ontidx, eqptvernum, swveract, numslots, versionnumber, sernum, ypserialno, cfgfile1, cfgfile2, usrate);"

