#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef ENCDEC_H
#define ENCDEC_H

typedef struct encoder_decoder{
    FILE *characters;
    char *input_file;
    char *output_file;
} EncDec_t;

bool init_encdec(EncDec_t *self, char *fname_in, char *fname_out);

void decode_text(EncDec_t *self);

void encode_text(EncDec_t *self);

//TODO:sacar esto, solo es para una prueba:
void shift_left(char *array, size_t size, int shift_count);

#endif //ENCDEC_H
