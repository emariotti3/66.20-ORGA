#include <string.h>
#include <ctype.h>
#include "encoder_decoder_t.h"

#define SYMBOLS_FILE "b64_characters.txt"
#define MASK1 0xFC000000
#define MASK2 0x3F00000
#define MASK3 0xFC000
#define MASK4 0x3F00
#define BYTE_GROUP 3
#define BYTE_SZ 8
#define GROUP_SZ 6
#define FILL_CHAR_POS 64
#define ENCODED_GROUP_SZ 4
#define BUFF_SZ 3
#define SUCCESS 0

//TODO: además de códigos de error habría que settear un mensaje del error
//para mostrar por pantalla (strerror)
int init_encdec(EncDec_t *self, FILE *input, FILE *output){
    self->characters = fopen(SYMBOLS_FILE, "r+");
    if (!self->characters){
        return IO_ERROR;
    }
    self->input_file = input;
    self->output_file = output;
    return SUCCESS;
}

char encode(EncDec_t *self, int letter_index){
    char encoded_letter = '\0';
    fseek(self->characters, letter_index, SEEK_SET);
    fread(&encoded_letter, sizeof(char), 1, self->characters);
    return encoded_letter;
}

bool at_eof(FILE *file_ptr){
    int pos = ftell(file_ptr);
    fgetc(file_ptr);
    bool eof =(fgetc(file_ptr) == EOF);
    fseek(file_ptr, pos, SEEK_SET);
    return eof;
}

int concantenate_binary_to_int(char *characters){
    int number = 0;
    for(int i = 0; i < sizeof(int); ++i){
        number = number | (characters[i] << (sizeof(int) -1 -i)*BYTE_SZ);
    }
    return number;
}

int encode_text(EncDec_t *self){
    //TODO:esto se podría flexibilizar mas:
    int index = 0, shift_count = 0, read_byte = 0;
    int group_qty = (BYTE_GROUP * BYTE_SZ) / GROUP_SZ;
    char encoded_chars[group_qty + 1], read_letters[sizeof(int) + 1];
    int masks[] = {MASK1, MASK2, MASK3, MASK4};

    while(!at_eof(self->input_file)){
        memset(&read_letters, '\0', sizeof(int) + 1);
        memset(&encoded_chars,'\0',(group_qty + 1)*sizeof(char));
        fread(read_letters, sizeof(char), BYTE_GROUP, self->input_file);
        read_byte = concantenate_binary_to_int(read_letters);
        for (int j = 0; j < group_qty; ++j){
            shift_count = (group_qty - j - 1)*GROUP_SZ + BYTE_SZ;
            index = (read_byte & masks[j]) >> shift_count;
            //Si index es 0, entonces le asignamos la posicion
            //del caracter de relleno('=' en este caso).
            index = (index != 0)? index : FILL_CHAR_POS;
            encoded_chars[j] = encode(self, index);
        }
        fwrite(encoded_chars, sizeof(char), group_qty, self->output_file);
    }
    return SUCCESS;
}

int decode_text(EncDec_t *self){
    size_t size = 0;
    int i = 0, j = 0, l = 0; //Contadores para los recorridos
    unsigned char *dec = NULL, buf[BUFF_SZ], tmp[ENCODED_GROUP_SZ], letter = '\0';

    // alloc
    dec = (unsigned char *) malloc(0);
    if (NULL == dec){
        return MEMORY_ERROR;
    }

    //Vamos a tomar caracteres mientras no se termine src
    while (!at_eof(self->input_file)) {
        //Si el caracter no pertenece a los posibles en b64
        //o si es el símbolo = -> rompe el ciclo
        letter = fgetc(self->input_file);
        if ( ('=' == letter) | (!(isalnum(letter) || '+' == letter || '/' == letter)) ) {
    	       return INVALID_CHARACTER;
    	  }

        //Vamos a ir leyendo hasta 4 bytes (los 4 bytes de b64 nos dan 3 bytes de ascii)
        //Se van guardando en tmp esos 4 bytes
        tmp[i++] = letter;

        // Si ya leimos 4, pasamos a la traducción
        if (i == ENCODED_GROUP_SZ) {
            //Se mueve por los 4 bytes
            for (i = 0; i < ENCODED_GROUP_SZ; ++i) {
                //Cuando encontramos el caracter en la lista de b64, guardamos su posición
                //(Su número asociado)
                for (l = 0; l < 64; ++l) {
                    fseek(self->characters, l, SEEK_SET);
                    if (tmp[i] == fgetc(self->characters)) {
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
            dec = (unsigned char *) realloc(dec,size + BUFF_SZ);
            for (i = 0; i < BUFF_SZ; ++i) {
                dec[size++] = buf[i];
            }

            //Reseteamos el contador de i
            i = 0;
        }
    }

    //Si no es múltiplo de 4, vamos a tener un valor en i, que será 1-2-3
    if (i > 0) {
        //Vamos a llenar tmp(j) con \0
        memset(tmp, '\0', ENCODED_GROUP_SZ*sizeof(char));

        //Buscamos la traducción para lo que haya quedado grabado tras agregar los \0
        for (j = 0; j < ENCODED_GROUP_SZ; ++j) {
            for (l = 0; l < 64; ++l) {
                fseek(self->characters, l, SEEK_SET);
                if (tmp[j] == fgetc(self->characters)) {
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

    fwrite(dec, sizeof(char), size, self->output_file);
    return SUCCESS;
}
