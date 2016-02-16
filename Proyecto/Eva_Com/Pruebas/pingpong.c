/* PINGPONG */

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>


void processor_A(void);
void processor_B(void);

int main(int argc, char *argv[]) {
  int rank, size;

  MPI_Init(&argc, &argv);               /* Initialize MPI               */
  MPI_Comm_size(MPI_COMM_WORLD, &size); /* Get the number of processors */
  MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* Get my number                */
  
  if (size != 2) { /* This if-block makes sure only two processors
                    * takes part in the execution of the code, pay no
                    * attention to it */
    if (rank == 0)
      fprintf(stdout, "\aRun on two processors only!\n");
  }
  else {
    if ( rank == 0 ) 
      processor_A();
    else
      processor_B();
  }
  MPI_Finalize();
  return 0;
}
  
void processor_A(void){
  
	double message[0];
	double timer1;
	const int ping=101, pong=102;
	int len = 0;
	int i = 0;
  	int envios = 10000;

  	MPI_Status status;


	timer1=MPI_Wtime();

	for (i=0; i<10000; i++) {
	MPI_Ssend(message, 0, MPI_DOUBLE, 1, ping, MPI_COMM_WORLD);
	MPI_Recv(message, 0, MPI_DOUBLE, 1, pong, MPI_COMM_WORLD, &status);
	}

	timer1=MPI_Wtime()-timer1;

	printf("## |%9d| %6d | %13g | %12g |%d|\n", 0, envios, timer1, timer1/envios, 0);

}

void processor_B(void){
  
	double message[0];
	const int ping=101, pong=102;
	int len,i;
	MPI_Status status;

	for (i=0; i<=10000; i++) {
		MPI_Recv(message, len, MPI_DOUBLE, 0, ping, MPI_COMM_WORLD, &status);
		MPI_Ssend(message, len, MPI_DOUBLE, 0, pong, MPI_COMM_WORLD);
	}
}