#include <string.h>
#include "encoder_decoder_t.h"
#define SYMBOLS_FILE "b64_characters.txt"
#define GROUP_QTY 6
#define BYTE_SZ 8
#define BUFF_SZ 2

bool init_encdec(EncDec_t *self, char *fname_in, char *fname_out){
    self->characters = fopen(SYMBOLS_FILE, "r+");
    self->input_file = fname_in;
    self->output_file = fname_out;
    return true;
}

char encode(EncDec_t *self, char letter_index){
    int index = atoi(&letter_index);
    char encoded_letter = '\0';
    fseek(self->characters, index, SEEK_SET);
    fread(&encoded_letter, sizeof(char), 1, self->characters);
    return encoded_letter;
}

void shift_left(char *array, size_t size, int shift_count){
    for(int i = 0; i < size; ++i){
        array[i] = array[i] << shift_count;
        if (i != (size - 1)){
            array[i] = array[i] | (array[i+1] >> (BYTE_SZ - shift_count));
        }
    }
}

void encode_text(EncDec_t *self){
    //SI NOS DAN UN ARCHIVO, SI NO HAY QUE USAR STDOUT/STDIN
    FILE *text_file = fopen(self->input_file, "rb+");
    FILE *encoded_file = fopen(self->output_file, "wb+");

    //Create 16 bit buffer: = [ buff1 | buff2 ]
    char buffer[2];
    memset(&buffer, 0, 2*sizeof(char));

    int bits_to_read = 0, buff2_count = 0; //buff1_count = 0, total_encoded = 0;
    buff2_count += fread(buffer + 1, sizeof(char), 1, text_file) * BYTE_SZ;
    char encoded_letter = '\0';

    while(!feof(text_file)){
        bits_to_read = GROUP_QTY - buff2_count;
        if(bits_to_read <= 0){
            shift_left(buffer, BUFF_SZ, GROUP_QTY);
            //here buff1 contains index to match to a character of base64!
            //encoded_letter = encode(self, *buffer);
            buff2_count -= GROUP_QTY;
            //memset(&buffer, 0, sizeof(char));
        }else{
            shift_left(buffer, BUFF_SZ, GROUP_QTY - bits_to_read);
            buff2_count = fread(buffer + 1, sizeof(char), 1, text_file)* BYTE_SZ;
            shift_left(buffer, BUFF_SZ, bits_to_read);
            //here buff1 contains index to match to a character of base64!
            //encoded_letter = encode(self, *buffer);
            //memset(&buffer, 0, sizeof(char));
            buff2_count -= bits_to_read;
        }
        encoded_letter = encode(self, *buffer);
        memset(&buffer, 0, sizeof(char));
        fwrite(&encoded_letter, sizeof(char), 1, encoded_file);
    }

    fclose(encoded_file);
    fclose(text_file);
}

void decode_text(EncDec_t *self){
    //SI NOS DAN UN ARCHIVO, SI NO HAY QUE USAR STDOUT/STDIN
    FILE *encoded_file = fopen(self->input_file, "rb+");
    FILE *text_file = fopen(self->output_file, "wb+");
    fclose(encoded_file);
    fclose(text_file);
}
