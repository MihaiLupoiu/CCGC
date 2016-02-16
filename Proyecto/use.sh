#!/usr/bin/env bash

echo "Frontend"
ps -C mpi.out -o %cpu,%mem,cmd

for (( i=0; i <= 18; i=i+1 ))
do
	echo "Compute$i"
	ssh azureuser@compute$i 'ps -C mpi.out -o %cpu,%mem,cmd'
done
