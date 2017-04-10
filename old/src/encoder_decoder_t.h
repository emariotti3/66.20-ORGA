#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef ENCDEC_H
#define ENCDEC_H

typedef enum error { INVALID_CHARACTER = 1, IO_ERROR = 2, MEMORY_ERROR = 3} Error_t;

typedef struct encoder_decoder{
    FILE *characters;
    //bool read_stdin;
    //bool write_stdout;
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

//Recibe un puntero a FILE y reemplaza el archivo de
//entrada actual por el recibido.
void set_input(EncDec_t *self, FILE *input);

//Recibe un puntero a FILE y reemplaza el archivo de
//salida actual por el recibido.
void set_output(EncDec_t *self, FILE *output);

#endif //ENCDEC_H
