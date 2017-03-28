#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef ENCDEC_H
#define ENCDEC_H

typedef enum error { INVALID_CHARACTER = -1, IO_ERROR = -2, MEMORY_ERROR = -3} Error_t;

typedef struct encoder_decoder{
    FILE *characters;
    FILE *input_file;
    FILE *output_file;
} EncDec_t;

//Inicializa al EncDec_t con un file descriptor 'input' de donde
//se leerán los caracteres de entrada de la operación de
//codificación/decodificación y un file descriptor 'output' en donde se
//escribirán los caracteres de salida de la operación.Devuelve 0
//si la operación es exitosa, de lo contrario devuelve un código de error.
int init_encdec(EncDec_t *self, FILE *input, FILE *output);

//Decodifica el texto del 'input' y los escribe en el 'output'.
//Devuelve 0 si la operación es exitosa, de lo contrario devuelve
//un código de error.
int decode_text(EncDec_t *self);

//Codifica el texto del 'input' y los escribe en el 'output'.
//Devuelve 0 si la operación es exitosa, de lo contrario devuelve
//un código de error.
int encode_text(EncDec_t *self);

#endif //ENCDEC_H
