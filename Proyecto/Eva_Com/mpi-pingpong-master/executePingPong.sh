#!/usr/bin/env bash


make

echo "----------------"
echo "Enviando mpi.out"
echo "----------------"

echo "Sending ./pingpong.out to compute0"
scp mpi.out compute0:.


echo "----------"
echo "Ejecutando"
echo "----------"
mpirun -np 2 -machinefile machines ./pingpong.out

rm *.out
