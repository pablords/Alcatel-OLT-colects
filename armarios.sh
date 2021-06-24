mysql -uroot -p -Dalcatel -e "SELECT nom_ArmarioOrigem FROM cluster_cidade WHERE VENDOR_SHELF = 'ALCATEL' AND nom_Regiao = 'SE'
GROUP BY nom_ArmarioOrigem" > /home/server/ALCATEL/lista_armarios.txt
