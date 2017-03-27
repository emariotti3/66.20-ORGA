#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool are_equals(unsigned char* esperado, unsigned char* obtenido,int len);
unsigned char *
b64_decode(const char *src, size_t len); 

int
main (void) {

  // Pruebas decode
  
  int fallidas = 0;
  int pasadas = 0;
  
  printf("Pruebas del decodificador: \n \n");
  printf("Prueba 1: ");
  if( are_equals(b64_decode("QWlsZW4=",8),"Ailen",5)){
	printf("OK \n");
	pasadas++;
  }
  else{
	printf("ERROR \n");
	fallidas++;
  }	
  
  printf("Prueba 2: ");
  if( are_equals(b64_decode("RXVnZW5pYQ==",12),"Eugenia",8)){
	printf("OK \n");
	pasadas++;
  }
  else{
	printf("ERROR \n");
	fallidas++;
  }	

  printf("Prueba 3: ");
  if( are_equals(b64_decode("Q3Jpc3RpYW4=",12),"Cristian",8)){
	printf("OK \n");
	pasadas++;
  }
  else{
	printf("ERROR \n");
	fallidas++;
  }	
 
  printf("Prueba 4: ");
  if( are_equals(b64_decode("MTIzNDU2Nzg5",12),"123456789",9)){
	printf("OK \n");
	pasadas++;
  }
  else{
	printf("ERROR \n");
	fallidas++;
  }	 

  printf("Prueba 5: ");
  if( are_equals(b64_decode("RXN0byBkZWNvZGlmaWNhIGJhc2UgNjQ=",32),"Esto decodifica base 64",23)){
	printf("OK \n");
	pasadas++;
  }
  else{
	printf("ERROR \n");
	fallidas++;
  }	
  
  printf("\nPruebas del codificador: \n \n");
    
  printf("Pruebas fallidas = %i \n",fallidas);
  printf("Pruebas pasadas = %i \n",pasadas);
    	
  return 0;
}

bool are_equals(unsigned char* esperado, unsigned char* obtenido,int len){
	int i;
	for (i=0; i<len; i++)
		if ( !( (esperado[i] == obtenido[i]) ) )
			return false;
	return true; 
}
