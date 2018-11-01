#!/bin/bash
#reboot tomcat!!!
#Author:fansik
tomcat_list=(tomcat8081 tomcat8082 tomcat8083 tomcat8084 tomcat8085 tomcat8086 timmer)
for number in ${tomcat_list[@]}
do
    echo reboot $number
done
read -p "enter choice tomcat_name : " tomcat_name
		
proId=`ps -ef | grep $tomcat_name | grep java | awk '{print $2}'`
echo $proId
kill -9 $proId
cd /usr/tomcats/$tomcat_name
rm -rf logs/* work
./bin/startup.sh
