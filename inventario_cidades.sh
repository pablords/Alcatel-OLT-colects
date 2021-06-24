#!/bin/bash


rm -rf /var/lib/mysql-files/*.txt

rm -rf /home/server/ALCATEL/scripts/equipment_optics/*.sh

mysql -uroot -Ddb_alcatel -e "SELECT LEFT  (nom_ArmarioOrigem,5), cod_Cidade FROM tb_cluster_cidades 
WHERE VENDOR_SHELF = 'ALCATEL' AND nom_Cluster = 'BELO HORIZONTE' GROUP BY nom_Cidade 
INTO OUTFILE '/var/lib/mysql-files/cidades.txt' FIELDS TERMINATED BY ';';"


for cidade in `cat /var/lib/mysql-files/cidades.txt|cut -d ';' -f1`
do


mysql -uroot -Ddb_alcatel -e "SELECT * FROM tb_cluster_cidades 
WHERE LEFT(nom_ArmarioOrigem,5)='$cidade' AND VENDOR_SHELF = 'ALCATEL' 
INTO OUTFILE '/var/lib/mysql-files/$cidade.txt' FIELDS TERMINATED BY ';';"

cat /home/server/ALCATEL/scripts/base_script.sh | sed 's/\/home\/server\/ALCATEL\/scripts\/equipment_ont_optics\///g' | sed 9s/^/cidade=$cidade/  > /home/server/ALCATEL/scripts/equipment_optics/$cidade.sh

chmod 777 /home/server/ALCATEL/scripts/equipment_optics/*.sh


cmd="/home/server/ALCATEL/scripts/equipment_optics/$cidade.sh"
cronjob="15 12 * * 1-7 $cmd"

(crontab -l | grep -v -F "$cmd" ; echo "$cronjob" ) | crontab -


done






