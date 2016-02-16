#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "Argument not supplied";
    exit;
fi

echo "frontend" > machines

for (( i=0; i <= $1; i=i+1 ))
do
	eval ping -c 3 "compute$i" >/dev/null
 	if [ "$?" == "0" ]; then
		echo "compute$i" >> machines
		echo "Compute$i: [OK]"
    else
        echo "*DOWN*" 
    fi
done
