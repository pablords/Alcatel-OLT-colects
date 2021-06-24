#!/bin/bash

dia=`date +%d_%m_%y`
inicio=`date +%D-%T`

linha=0
linha=$1


for ip in `cat /var/lib/mysql-files/$armario.txt|cut -d ';' -f13`

do

/usr/bin/expect <<FIN_EXPECT | grep 1/1 >/home/server/ALCATEL/db_medicao/equipment_ont_optics/$armario



set timeout 600



spawn ssh user@$ip

sleep 2

expect {
    "Are you sure you want to continue connecting" {send "yes\r"; exp_continue}
    "password:" {send "#password\r"}
}

expect "*#" {send "show equipment ont optics\r"}

expect "*#" {send "logout\r"}

expect eof

FIN_EXPECT
done

fim=`date +%D-%T`

ttl_cli=`cat /home/server/ALCATEL/db_medicao/equipment_ont_optics/$armario | wc -l | awk '{print $1}'`
echo inicio $inicio e temino $fim $armario coletados $ttl_cli>>/home/server/ALCATEL/log_lista_medicao/equipment_ont_optics/log_lista_medicao_file_$dia.txt


