#!/bin/bash
sed -i "s/bbb.ccc.test/${1}/g" $(grep -ilR --exclude=config.sh 'bbb.ccc.test' *)
external_ip_address=`nslookup ${1}|grep Address|tail -n 1|cut -d: -f2|sed 's/ //'`
sed -i "s/000.000.000.000/${external_ip_address}/g" vars.xml
