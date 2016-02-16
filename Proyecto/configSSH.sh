#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "Start Argument not supplied!";
    exit;
fi

if [ -z "$2" ]
then
    echo "End Argument not supplied!";
    exit;
fi


sudo chmod 755 ~/.ssh/id_rsa.pub

for (( i=$1; i <= $2; i=i+1 ))
do
	echo "-------------------------------"
	echo "Sending id.rsa.pub to compute$i"
	echo "-------------------------------"
	cat ~/.ssh/id_rsa.pub | ssh azureuser@compute$i 'cat >> .ssh/authorized_keys'

	ssh azureuser@compute$i 'sudo apt-get update'
	ssh azureuser@compute$i 'sudo apt-get -y install openmpi-bin'

done

sudo chmod 400 ~/.ssh/id_rsa.pub
