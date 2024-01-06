#!/bin/bash

echo 'BEGIN *****************************************'



nexus_ip=$1
nexus_pass=$2
my_version=$3

if [ "$nexus_ip" = "" ]
then
	echo 'No NEXUS IP in parameter #1!! STOP'
	exit
fi

if [ "$nexus_pass" = "" ]
then
	echo 'No NEXUS PASSWORD in parameter #2!! STOP'
	exit
fi

if [ "$my_version" = "" ]
then
	echo 'No version in parameter #3, default v1.0.0 used'
	my_version="v1.0.0"
fi




echo "{\"insecure-registries" : [\"$nexus_ip:8123\"]}" > /etc/docker/daemon.json
service docker restart

docker login $nexus_ip:8123 --username admin --password $nexus_pass
echo 'docker login to NEXUS success'

docker build -t build_environment:$my_version .
echo 'docker build success'

docker tag build_environment:$my_version $nexus_ip:8123/build_environment:$my_version
echo 'docker tag success'

docker push $nexus_ip:8123/build_environment:$my_version
echo 'docker push success'


echo 'END build & push success!! *****************************************'
