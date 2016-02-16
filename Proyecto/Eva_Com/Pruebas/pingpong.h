#ifndef _PINGPONG_H_
#define _PINGPONG_H_

/* Constantes locales */
#define MASTER	0
#define ESCLAVO	1

/* Tamaño de los datos a enviar */

#define SIZE0	0			/*  0   */

/* Cantidad de envíos a hacer */
#define ENVIOS	50

/* Menu del programa */
#define MENU_ENVIOS	"## Ingrese la cantidad de envíos:\
			\n## 1)    100\
			\n## 2)  1.000\
			\n## 3) 10.000\n"

/* Funciones */
void obtener_info_sist();
void master_func(int size, int envios, MPI_Status estado);

#endif /* _PINGPONG_H_ */
