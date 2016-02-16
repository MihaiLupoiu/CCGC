#!/usr/bin/env bash

ver=$(uname -s)

if [ -z "$1" ]
then
    echo "First argument not supplied, compile.sh <size>(size>2) <cpuNumber>(cpuNumber>2) ";
    exit;
fi

if [ -z "$2" ]
then
    echo "Second argument not supplied, compile.sh <size>(size>2) <cpuNumber>(cpuNumber>2) ";
    exit;
fi

echo "-------------------"
echo "Creando machinefile"
echo "-------------------"

# Se crea el machinefile automaticamente en base a los nodos que están conectados
echo "frontend" > machines

for (( i=0; i <= $2; i=i+1 ))
do
	eval ping -c 3 "compute$i" >/dev/null
 	if [ "$?" == "0" ]; then
		echo "compute$i" >> machines
    fi
done

make

echo "----------------"
echo "Enviando mpi.out"
echo "----------------"
for (( i=0; i <= $2; i=i+1 ))
do
	echo "Sending mpi.out to compute$i"
	scp mpi.out compute$i:.
done

echo "----------"
echo "Ejecutando"
echo "----------"
for (( j=1; j <= $2; j++ ))
do
	for (( i=0; i <= $1; i=i+200 ))
	do
        echo $i
        mpirun -np $j -machinefile machines ./mpi.out $i >> tiempoMPI.txt
    done
done

rm *.out
