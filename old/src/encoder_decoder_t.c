#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <unistd.h>
#include "encoder_decoder_t.h"

//#define BYTE_GROUP 3
#define BYTE_SZ 8
#define GROUP_SZ 6.0
#define FILL_CHAR_POS 64
#define SYMBOL_POS 62
#define ENCODED_GROUP_SZ 4
#define DECODED_GROUP_SZ 3
//#define SUCCESS 0
#define NEW_LINE '\n'
#define MAX_LEN 76

#define MASK 0x3F
#define DMASK_1 0x30
#define DMASK_2 0xf
#define DMASK_3 0x3c
#define DMASK_4 0x3

#define DELTA_UPP 65
#define DELTA_LOW 71
#define DELTA_NUM 4
#define DELTA_SYM 18

static const char letters[] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
'P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k',
'l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5',
'6','7','8','9','+','/','='};

int init_encdec(EncDec_t *self, FILE *input, FILE *output){
    self->input_file = input;
    self->output_file = output;
    self->state = SUCCESS;
    return SUCCESS;
}

char get_fill_char(EncDec_t *self){
    //Obtengo el caracter de relleno ('=')
    return letters[FILL_CHAR_POS];
}

void set_input(EncDec_t *self, FILE *input){
    self->input_file = input;
}

void set_output(EncDec_t *self, FILE *output){
    self->output_file = output;
}

char encode(EncDec_t *self, unsigned int letter_index){
    return letters[letter_index];
}

bool at_stdin_end(EncDec_t *self){
    return (self->input_file == stdin) && feof(self->input_file);
}

bool at_file_end(EncDec_t *self, int pos, int len){
    return (self->input_file != stdin) && (pos == len);
}

bool error_ocurred(EncDec_t *self){
    bool ioerr = ferror(self->input_file) || ferror(self->output_file);
    self->state = ioerr ? IO_ERROR : self->state;
    return self->state;
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

int encode_text_to_output(EncDec_t *self, unsigned char *read_letters, int tot_read){
    //group_qty: la cantidad de grupos de 6 bits que puedo formar
    //con los bytes que leo:
    int max_group_qty = (DECODED_GROUP_SZ * BYTE_SZ) / GROUP_SZ;
    int group_qty = (int)ceil((double)((tot_read * BYTE_SZ) / GROUP_SZ));

    int read_bytes = 0;
    unsigned int index = 0, shift_count = 0;
    //unsigned char encoded_chars[group_qty + 1];
    //memset(&encoded_chars, '\0', (group_qty + 1)*sizeof(char));
    unsigned char encoded_chars[max_group_qty + 1];
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
    if(!error_ocurred(self)){
        fwrite(encoded_chars, sizeof(char), max_group_qty, self->output_file);
        self->state = ferror(self->output_file) ? IO_ERROR : self->state;
    }
    return self->state;
}

int encode_text(EncDec_t *self){
    int input_len = file_len(self->input_file);
    unsigned char read_letters[sizeof(int)];
    memset(&read_letters, '\0', sizeof(int));

    //Leo de a 3 bytes y codifico:
    int len = fread(read_letters, sizeof(char), DECODED_GROUP_SZ, self->input_file);
    while(!error_ocurred(self) && !at_stdin_end(self) && !at_file_end(self, ftell(self->input_file), input_len)){
        encode_text_to_output(self, read_letters, len);
        memset(&read_letters, '\0', sizeof(int));
        len = fread(read_letters, sizeof(char), DECODED_GROUP_SZ, self->input_file);
    }
    if(!error_ocurred(self) && (len > 0)){
        return encode_text_to_output(self, read_letters, len);
    }
    return self->state;
}

int decode_to_output_file(EncDec_t *self, char *letter_indexes, int padding){
    char buff[DECODED_GROUP_SZ + 1];
    memset(buff, '\0', (DECODED_GROUP_SZ + 1)*sizeof(char));

    //Teniendo los números asociados se hace la decodificación en sí misma
    //relacionando los valores en b64 y ascii
    //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3
    //Se encuentran explicados los cálculos en el informe
    buff[0] = (letter_indexes[0] << 2) | ((letter_indexes[1] & DMASK_1) >> 4);
    buff[1] = ((letter_indexes[1] & DMASK_2) << 4) | ((letter_indexes[2] & DMASK_3) >> 2);
    buff[2] = ((letter_indexes[2] & DMASK_4) << 6) | letter_indexes[3];
    //Esto es para que si se codifico un caracter nulo
    //en el medio de los otros caracteres, este se copie
    //al archivo decodificado.
    size_t len = DECODED_GROUP_SZ - padding;
    if(!error_ocurred(self)){
        fwrite(buff, sizeof(char), len, self->output_file);
        self->state = ferror(self->output_file) ? IO_ERROR : self->state;
    }
    return self->state;
}

bool issymbol(EncDec_t *self, unsigned char *c, char *index){
    for (int i = SYMBOL_POS; letters[i] && i < FILL_CHAR_POS; ++i){
        if (*c == letters[i]){
            *index = i;
            return true;
        }
    }
    return false;
}

int decode(EncDec_t *self, unsigned char *letters, char fill_character, int count){
    char indexes[ENCODED_GROUP_SZ + 1];
    memset(indexes, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));
    int padding = 0;
    for (int i = 0; i < count; ++i) {
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
            self->state = INVALID_CHARACTER;
            return INVALID_CHARACTER;
        }
    }
    return decode_to_output_file(self, indexes, padding);
}

int decode_text(EncDec_t *self){
    int input_len = file_len(self->input_file);
    self->state = SUCCESS;
    char fill_character = get_fill_char(self);
    unsigned char read_letters[ENCODED_GROUP_SZ + 1];
    memset(read_letters, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

    //Inicializo el array de caracteres leidos con el caractere
    //de relleno por si no se completa la cantidad de bytes esperados.
    //Esto solo agrega un '\0' al resultado decodificado.
    int qty_read = fread(read_letters, sizeof(char), ENCODED_GROUP_SZ, self->input_file);
    while(!error_ocurred(self) && !at_stdin_end(self) && !at_file_end(self, ftell(self->input_file), input_len)){
        decode(self, read_letters, fill_character, ENCODED_GROUP_SZ);
        memset(read_letters, '\0', ENCODED_GROUP_SZ*sizeof(char));
        qty_read = fread(read_letters, sizeof(char), ENCODED_GROUP_SZ, self->input_file);
    }
    if (!error_ocurred(self) && (qty_read > 0)){
        return decode(self, read_letters, fill_character, qty_read);
    }
    return self->state;
}
