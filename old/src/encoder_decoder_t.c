#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <unistd.h>
#include "encoder_decoder_t.h"

#define SYMBOLS_FILE "b64_characters.txt"
#define MASK 0x3F
#define BYTE_GROUP 3
#define BYTE_SZ 8
#define GROUP_SZ 6.0
#define FILL_CHAR_POS 64
#define SYMBOL_POS 62
#define ENCODED_GROUP_SZ 4
#define DECODED_GROUP_SZ 3
#define SUCCESS 0
#define NEW_LINE '\n'
#define MAX_LEN 76

#define DELTA_UPP 65
#define DELTA_LOW 71
#define DELTA_NUM 4
#define DELTA_SYM 18

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

char get_fill_char(EncDec_t *self){
    //Obtengo el caracter de relleno ('=')
    fseek(self->characters, FILL_CHAR_POS, SEEK_SET);
    char fill_character = fgetc(self->characters);
    fseek(self->characters, 0, SEEK_SET);
    return fill_character;
}

void add_newline_to_output(EncDec_t *self){
    char new_ln = NEW_LINE;
    fwrite(&new_ln, sizeof(char), 1, self->output_file);
}

void set_input(EncDec_t *self, FILE *input){
    self->input_file = input;
}

void set_output(EncDec_t *self, FILE *output){
    self->output_file = output;
}

char encode(EncDec_t *self, unsigned int letter_index){
    char encoded_letter = '\0';
    fseek(self->characters, letter_index, SEEK_SET);
    fread(&encoded_letter, sizeof(char), 1, self->characters);
    return encoded_letter;
}

bool at_stdin_end(EncDec_t *self, char c){
    return self->input_file == stdin && (c == NEW_LINE || c == '\0');
}

bool at_file_end(EncDec_t *self, int pos, int len){
    if (self->input_file == stdin) return false;
    return pos == len;
}

bool at_inserted_eol(EncDec_t *self){
    size_t pos = ftell(self->input_file);
    return ((pos % MAX_LEN)== 0) && (pos > 0);
}

bool read_input(EncDec_t *self, unsigned char *buffer, size_t count, int *read, int flen, bool encode){
    //Devuelve true si durante la lectura se encontro
    //el final del archivo. Guarda el total de caracteres
    //leidos en read, sin incluir el EOF como caracter.
    char c;
    bool continue_read = true;
    //TODO: emprolijar esto:
    if (!encode && at_inserted_eol(self)) getc(self->input_file);
    for(int i = 0; (i < count) && continue_read; ++i){
        //No incluyo los caracteres nulos o EOF
        c = getc(self->input_file);
        buffer[i] = (unsigned char)c;
        *read = i + 1;
        continue_read = !at_stdin_end(self, buffer[i]) && !at_file_end(self, ftell(self->input_file), flen);
    }
    return continue_read;
}

int concantenate_binary_to_int(unsigned char *characters){
    int number = 0;
    for(int i = 0; i < sizeof(int); ++i){
        number = number | (characters[i] << (sizeof(int) -1 -i)*BYTE_SZ);
    }
    return number;
}

int file_len(FILE *file){
    int len = 0, pos = ftell(file);
    if (file != stdin){
        fseek(file, 0, SEEK_END);
        len = ftell(file);
        fseek(file, pos, SEEK_SET);
    }
    return len;
}

void encode_text_to_output(EncDec_t *self, unsigned char *read_letters, int tot_read){
    //group_qty: la cantidad de grupos de 6 bits que puedo formar
    //con los bytes que leo:
    int max_group_qty = (BYTE_GROUP * BYTE_SZ) / GROUP_SZ;
    int group_qty = (int)ceil((double)((tot_read * BYTE_SZ) / GROUP_SZ));

    int read_bytes = 0;
    unsigned int index = 0, shift_count = 0;
    unsigned char encoded_chars[group_qty + 1];
    memset(&encoded_chars, '\0', (group_qty + 1)*sizeof(char));
    memset(&encoded_chars, get_fill_char(self), max_group_qty*sizeof(char));

    read_bytes = concantenate_binary_to_int(read_letters);

    //Ahora aplico operaciones logicas y obtengo un index:
    for (int j = 0; j < group_qty; ++j){
        shift_count = (max_group_qty - j - 1)*GROUP_SZ + BYTE_SZ;
        index = (read_bytes >> shift_count) & MASK;
        //Uso el index para obtener un caracter del
        //archivo de caracteres posibles:
        encoded_chars[j] = encode(self, index);
    }

    /*for (int k = 0; k < max_group_qty; ++k){
        size_t pos = ftell(self->output_file);
        if (((pos+1) % MAX_LEN == 0) && (pos > 0)){
            add_newline_to_output(self);
            fputc(encoded_chars[k], self->output_file);
        }else{
            fputc(encoded_chars[k], self->output_file);
        }
    }*/
    fwrite(encoded_chars, sizeof(char), max_group_qty, self->output_file);
}

int encode_text(EncDec_t *self){
    //TODO:esto se podría flexibilizar mas:
    int tot_read = 0;
    unsigned char read_letters[sizeof(int)];
    memset(&read_letters, '\0', sizeof(int));
    int input_len = file_len(self->input_file);

    //Leo de a 3 bytes y codifico:
    while (read_input(self, read_letters, BYTE_GROUP, &tot_read, input_len, true)){
        encode_text_to_output(self, read_letters, tot_read);
        memset(&read_letters, '\0', sizeof(int));
        if (ftell(self->output_file) % MAX_LEN == 0) add_newline_to_output(self);
    }
    //Codifico lo que quedo en el buffer:
    if(tot_read > 0){
        encode_text_to_output(self, read_letters, tot_read);
    }
    add_newline_to_output(self);
    return SUCCESS;
}

void decode_to_output_file(EncDec_t *self, char *letter_indexes, int padding){
    char buff[DECODED_GROUP_SZ + 1];
    memset(buff, '\0', (DECODED_GROUP_SZ + 1)*sizeof(char));

    //Teniendo los números asociados se hace la decodificación en sí misma
    //relacionando los valores en b64 y ascii
    //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3
    //Se encuentran explicados los cálculos en el informe
    buff[0] = (letter_indexes[0] << 2) | ((letter_indexes[1] & 0x30) >> 4);
    buff[1] = ((letter_indexes[1] & 0xf) << 4) | ((letter_indexes[2] & 0x3c) >> 2);
    buff[2] = ((letter_indexes[2] & 0x3) << 6) | letter_indexes[3];

    //Esto es para que si se codifico un caracter nulo
    //en el medio de los otros caracteres, este se copie
    //al archivo decodificado.
    size_t len = DECODED_GROUP_SZ - padding;
    //for(; padding && (buff[len-1] == 0) && (len >= 0); --len){}

    fwrite(buff, sizeof(char), len, self->output_file);
    //size_t len = (total < DECODED_GROUP_SZ) ? total : DECODED_GROUP_SZ;
    //fwrite(buff, sizeof(char), len, self->output_file);
}

bool issymbol(EncDec_t *self, unsigned char *c, char *index){
    char encoded_letter = '\0';
    fseek(self->characters, SYMBOL_POS, SEEK_SET);
    while (!feof(self->characters)) {
        encoded_letter = fgetc(self->characters);
        if (*c == encoded_letter) {
            *index = ftell(self->characters) - 1;
            return true;
        }
    }
    return false;
}

int decode(EncDec_t *self, unsigned char *letters, char fill_character){
    char indexes[ENCODED_GROUP_SZ + 1];
    memset(indexes, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));
    int padding = 0;
    for (int i = 0; i < ENCODED_GROUP_SZ; ++i) {
        //Si no, tenemos que buscar el índice de la letra.
        //en b64 y guardar su posición.
        //TODO: esta pared de ifs hay que emprolijarla:
        if (letters[i] == fill_character){
            //Si la letra leida es el caracter de relleno,
            //llenamos con 0 la posicion de ese caracter.
            padding++;
            indexes[i] =  0;
            continue;
        }
        if(isupper(letters[i])){
            indexes[i] = letters[i] - DELTA_UPP;
            continue;
        }
        if(islower(letters[i])){
            indexes[i] = letters[i] - DELTA_LOW;
            continue;
        }
        if(isdigit(letters[i])){
            indexes[i] = letters[i] + DELTA_NUM;
            continue;
        }
        if(!issymbol(self, letters +i, indexes + i)){
            return INVALID_CHARACTER;
        }
    }
    decode_to_output_file(self, indexes, padding);
    return SUCCESS;
}

int decode_text(EncDec_t *self){
    int input_len = file_len(self->input_file);
    int qty_read = 0, result = SUCCESS;
    char fill_character = get_fill_char(self);
    unsigned char letters[ENCODED_GROUP_SZ + 1];
    memset(letters, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

    //Inicializo el array de caracteres leidos con el caractere
    //de relleno por si no se completa la cantidad de bytes esperados.
    //Esto solo agrega un '\0' al resultado decodificado.
    //memset(letters, '\0', ENCODED_GROUP_SZ*sizeof(char));
    read_input(self, letters, ENCODED_GROUP_SZ, &qty_read, input_len, false);

    while((qty_read > 0) && result == SUCCESS){
        result = result || decode(self, letters, fill_character);
        memset(letters, '\0', ENCODED_GROUP_SZ*sizeof(char));
        read_input(self, letters, ENCODED_GROUP_SZ, &qty_read, input_len, false);
    }
    return result;
}
