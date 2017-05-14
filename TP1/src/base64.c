#include "base64.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>

#define BYTE_SZ 8
#define GROUP_SZ 6.0
#define FILL_CHAR_POS 64
#define SYMBOL_POS 62
#define ENCODED_GROUP_SZ 4
#define DECODED_GROUP_SZ 3
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

typedef enum error {ERROR =-1, SUCCESS, INVALID_CHARACTER, IO_ERROR, MEMORY_ERROR} Error_t;

/****************************EncDec_t*************************************************/

typedef struct encoder_decoder{
    int input_file;
    int output_file;
    Error_t state;
} EncDec_t;


//Inicializa al EncDec_t con un file descriptor 'input' de donde
//se leerán los caracteres de entrada de la operación de
//codificación/decodificación y un file descriptor 'output' en donde se
//escribirán los caracteres de salida de la operación.Devuelve 0
//si la operación es exitosa, de lo contrario devuelve un código de error.
int init_encdec(EncDec_t *self, int fdin, int fdout);

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
void set_input(EncDec_t *self, int input);

//Recibe un puntero a FILE y reemplaza el archivo de
//salida actual por el recibido.
void set_output(EncDec_t *self, int output);

/****************************Implementación EncDec_t************************************************/

int init_encdec(EncDec_t *self, int fdin, int fdout){
    self->input_file = fdin;
    self->output_file = fdout;
    self->state = SUCCESS;
    return self->state;
}

/*char get_fill_char(EncDec_t *self){
    //Obtengo el caracter de relleno ('=')
    return letters[FILL_CHAR_POS];
}*/

void set_input(EncDec_t *self, int input){
    self->input_file = input;
}

void set_output(EncDec_t *self, int output){
    self->output_file = output;
}

/*char encode(EncDec_t *self, unsigned int letter_index){
    return letters[letter_index];
}*/

/*
bool at_stdin_end(EncDec_t *self){
    return (self->input_file == 0) && feof(self->input_file);
}

bool at_file_end(EncDec_t *self, int pos, int len){
    return (self->input_file != 0) && (pos == len);
}*/

/*int concantenate_binary_to_int(unsigned char *characters){
    int number = 0;
    for(int i = 0; i < sizeof(int); ++i){
        number = number | (characters[i] << (sizeof(int) -1 -i)*BYTE_SZ);
    }
    return number;
}*/
/*
int file_len(int fd){
    int len = 0, pos = lseek(fd,0,SEEK_CUR);
    if (fd != 0){ //fd!=stdin
        lseek(fd, 0, SEEK_END);
        len = lseek(fd,0,SEEK_CUR);
        lseek(fd, pos, SEEK_SET);
    }
    return len;
}*/

int encode_text_to_output(EncDec_t *self, unsigned char *read_letters, int tot_read){
    //group_qty: la cantidad de grupos de 6 bits que puedo formar
    //con los bytes que leo:
    int max_group_qty = (DECODED_GROUP_SZ * BYTE_SZ) / GROUP_SZ;
    int group_qty = (int)ceil((double)((tot_read * BYTE_SZ) / GROUP_SZ));

    int read_bytes = 0;
    unsigned int index = 0, shift_count = 0;
    unsigned char encoded_chars[group_qty + 1];
    memset(&encoded_chars, '\0', (group_qty + 1)*sizeof(char));
    memset(&encoded_chars, get_fill_char(), max_group_qty*sizeof(char));

    read_bytes = concantenate_binary_to_int(read_letters);

    //Ahora aplico operaciones logicas y obtengo un index:
    for (int j = 0; j < group_qty; ++j){
        shift_count = (max_group_qty - j - 1)*GROUP_SZ + BYTE_SZ;
        index = (read_bytes >> shift_count) & MASK;
        //Uso el index para obtener un caracter del
        //archivo de caracteres posibles:
        encoded_chars[j] = encode(index);
    }
    if(self->state == SUCCESS){
        int resu = write(self->output_file, encoded_chars, max_group_qty);
        if(resu == ERROR){
        	self->state = errno;//ferror(self->output_file) ? IO_ERROR : self->state;
        }
    }
    return self->state;
}

int encode_text(EncDec_t *self){
    //int input_len = file_len(self->input_file);
    unsigned char read_letters[sizeof(int)];
    memset(&read_letters, '\0', sizeof(int));

    //Leo de a 3 bytes y codifico:
    int qty_read = read(self->input_file, read_letters, DECODED_GROUP_SZ);
    while((self->state==SUCCESS) && (qty_read == DECODED_GROUP_SZ)){ //&& !at_stdin_end(self) && !at_file_end(self, lseek(self->input_file,0,SEEK_CUR), input_len)){
        encode_text_to_output(self, read_letters, qty_read);
        memset(&read_letters, '\0', sizeof(int));
        qty_read = read(self->input_file, read_letters, DECODED_GROUP_SZ);
    }
    if((self->state==SUCCESS) && (qty_read > 0)){
        return encode_text_to_output(self, read_letters, qty_read);
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
    if((self->state == SUCCESS)){
        int resu = write(self->output_file, buff, len);
        if(resu == ERROR){
	        self->state = errno;// ferror(self->output_file) ? IO_ERROR : self->state;
	     }
    }
    return self->state;
}

/*bool issymbol(EncDec_t *self, unsigned char *c, char *index){
    for (int i = SYMBOL_POS; letters[i] && i < FILL_CHAR_POS; ++i){
        if (*c == letters[i]){
            *index = i;
            return true;
        }
    }
    return false;
}*/

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
        if(!issymbol(letters +i, indexes + i)){
            self->state = INVALID_CHARACTER;
            return INVALID_CHARACTER;
        }
    }
    return decode_to_output_file(self, indexes, padding);
}

int decode_text(EncDec_t *self){
    //int input_len = file_len(self->input_file);
    self->state = SUCCESS;
    char fill_character = get_fill_char();
    unsigned char read_letters[ENCODED_GROUP_SZ + 1];
    memset(read_letters, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

    //Inicializo el array de caracteres leidos con el caractere
    //de relleno por si no se completa la cantidad de bytes esperados.
    //Esto solo agrega un '\0' al resultado decodificado.
    int qty_read = read(self->input_file, read_letters, ENCODED_GROUP_SZ);
    while((self->state==SUCCESS) && (qty_read == ENCODED_GROUP_SZ)){// && !at_stdin_end(self) && !at_file_end(self, lseek(self->input_file, 0, SEEK_CUR), input_len)){
        decode(self, read_letters, fill_character, ENCODED_GROUP_SZ);
        memset(read_letters, '\0', ENCODED_GROUP_SZ*sizeof(char));
        qty_read = read(self->input_file, read_letters, ENCODED_GROUP_SZ);
    }
    if ((self->state==SUCCESS) && (qty_read > 0)){
        return decode(self, read_letters, fill_character, qty_read);
    }
    return self->state;
}

/***********************************************************************************/

int base64_encode(int infd, int outfd){
	EncDec_t encdec;
	init_encdec(&encdec, infd, outfd);
	return encode_text(&encdec);
}

int base64_decode(int infd, int outfd){
	EncDec_t encdec;
	init_encdec(&encdec, infd, outfd);
	return decode_text(&encdec);
}

