#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "Second argument not supplied, compile.sh <size>(size>2) <cpuNumber>(cpuNumber>2) ";
    exit;
fi

echo "----------------"
echo "Enviando mpi.out"
echo "----------------"
for (( i=0; i <= $1; i=i+1 ))
do
        echo "Sending mpi.out to compute$i"
        scp mpi.out compute$i:.
done

