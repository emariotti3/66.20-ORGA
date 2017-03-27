#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef ENCDEC_H
#define ENCDEC_H

typedef struct encoder_decoder{
    FILE *characters;
    FILE *input_file;
    FILE *output_file;
} EncDec_t;

bool init_encdec(EncDec_t *self, FILE *input, FILE *output);

void decode_text(EncDec_t *self);

void encode_text(EncDec_t *self);

#endif //ENCDEC_H
