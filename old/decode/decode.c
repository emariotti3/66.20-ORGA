#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

unsigned char *
b64_decode(const char *src, size_t len); 

static const char b64_table[] = {
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
  'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
  'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
  'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
  'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
  'w', 'x', 'y', 'z', '0', '1', '2', '3',
  '4', '5', '6', '7', '8', '9', '+', '/',
};

unsigned char *
b64_decode(const char *src, size_t len) {
  int i = 0; //Contadores
  int j = 0; //para los
  int l = 0; //recorridos
  
  size_t size = 0;
  unsigned char *dec = NULL;
  unsigned char buf[3];
  unsigned char tmp[4];

  // alloc
  dec = (unsigned char *) malloc(0); 
  if (NULL == dec) { return NULL; }

  //Vamos a tomar caracteres mientras no se termine src
  while (len--) {
    //Si el caracter no pertenece a los posibles en b64
    //o si es el símbolo = -> rompe el ciclo
    if ( ('=' == src[j]) | (!(isalnum(src[j]) || '+' == src[j] || '/' == src[j])) ) { 
		break; 
	}

    //Vamos a ir leyendo hasta 4 bytes (los 4 bytes de b64 nos dan 3 bytes de ascii
    //Se van guardando en tmp esos 4 bytes
    tmp[i++] = src[j++];

    // Si ya leimos 4, pasamos a la traducción
    if (4 == i) {
      //Se mueve por los 4 bytes
      for (i = 0; i < 4; ++i) {
        //Cuando encontramos el caracter en la lista de b64, guardamos su posición
        //(Su número asociado)
        for (l = 0; l < 64; ++l) {
          if (tmp[i] == b64_table[l]) {
            tmp[i] = l;
            break; //No necesita seguir buscando
          }
        }
      }

      //Teniendo los números asociados se hace la decodificación en sí misma
      //relacionando los valores en b64 y ascii
      //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3 
      //Se encuentran explicados los cálculos en el informe
       
      
      buf[0] = (tmp[0] << 2) + ((tmp[1] & 0x30) >> 4); //Línea 1
      buf[1] = ((tmp[1] & 0xf) << 4) + ((tmp[2] & 0x3c) >> 2); //Línea 2
      buf[2] = ((tmp[2] & 0x3) << 6) + tmp[3]; //Línea 3

      //Guardamos lo obtenido 
      dec = (unsigned char *) realloc(dec, size + 3);
      for (i = 0; i < 3; ++i) {
        dec[size++] = buf[i];
      }

      //Reseteamos el contador de i
      i = 0;
    }
  }

  //Si no es múltiplo de 4, vamos a tener un valor en i, que será 1-2-3
  if (i > 0) {
    //Vamos a llenar tmp(j) con \0
    for (j = i; j < 4; ++j) {
      tmp[j] = '\0';
    }

    //Buscamos la traducción para lo que haya quedado grabado tras agregar los \0
    for (j = 0; j < 4; ++j) {
        for (l = 0; l < 64; ++l) {
          if (tmp[j] == b64_table[l]) {
            tmp[j] = l;
            break;
          }
        }
    }

    //Decodificación
    buf[0] = (tmp[0] << 2) + ((tmp[1] & 0x30) >> 4);
    buf[1] = ((tmp[1] & 0xf) << 4) + ((tmp[2] & 0x3c) >> 2);
    buf[2] = ((tmp[2] & 0x3) << 6) + tmp[3];

    //Agregamos lo que faltaba a dec
    dec = (unsigned char *) realloc(dec, size + (i - 1));
    for (j = 0; (j < i - 1); ++j) {
      dec[size++] = buf[j];
    }
  }

  //Agregamos el caracter de fin de línea.
  dec = (unsigned char *) realloc(dec, size + 1);
  dec[size] = '\0';
 
  return dec;
}
