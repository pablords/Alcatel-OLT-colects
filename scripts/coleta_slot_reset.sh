#!/bin/bash




for armario in `cat /home/server/ALCATEL/lista_armarios.txt |cut -d ';' -f1`
do


mysql -uroot -p -Dalcatel -e "SELECT IP_DSLAM FROM cluster_cidade 
WHERE nom_ArmarioOrigem ='$armario' AND VENDOR_SHELF = 'ALCATEL'" > /home/server/ALCATEL/armarios/$armario.txt

cat /home/server/ALCATEL/scripts/base_script_slot_reset.sh | sed 's/\/home\/server\/ALCATEL\/scripts\/slot_reset\///g' | sed 9s/^/armario="$armario"/  > /home/server/ALCATEL/scripts/slot_reset/$armario.sh

chmod 777 /home/server/ALCATEL/scripts/slot_reset/*.sh

cmd="/home/server/ALCATEL/scripts/slot_reset/$armario.sh"
cronjob="*/30 * * * * $cmd"

(crontab -l | grep -v -F "$cmd" ; echo "$cronjob" ) | crontab -



done








