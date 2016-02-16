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
echo "FrontendMihai2" > machines

for (( i=0; i <= $2; i=i+1 ))
do
	eval ping -c 3 "computeD$i" >/dev/null
 	if [ "$?" == "0" ]; then
		echo "computeD$i" >> machines
    fi
done

make

echo "----------------"
echo "Enviando mpi.out"
echo "----------------"
for (( i=0; i <= $2; i=i+1 ))
do
	echo "Sending mpi.out to computeD$i"
	scp mpi.out computeD$i:.
done

echo "----------"
echo "Ejecutando"
echo "----------"
for (( j=1; j <= $2; j++ ))
do
    echo " $j 2000"
    mpirun -np $j -machinefile machines ./mpi.out 2000 >> tiempoMPI.txt
    echo " $j 4000"
    mpirun -np $j -machinefile machines ./mpi.out 4000 >> tiempoMPI.txt
    echo " $j 6000"
    mpirun -np $j -machinefile machines ./mpi.out 6000 >> tiempoMPI.txt  
    echo " $j 8000"
    mpirun -np $j -machinefile machines ./mpi.out 8000 >> tiempoMPI.txt

done

rm *.out
