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
#define DECODED_GROUP_SZ 3
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

void set_input(EncDec_t *self, FILE *input){
    self->input_file = input;
}

void set_output(EncDec_t *self, FILE *output){
    self->output_file = output;
}

char encode(EncDec_t *self, int letter_index){
    char encoded_letter = '\0';
    fseek(self->characters, letter_index, SEEK_SET);
    fread(&encoded_letter, sizeof(char), 1, self->characters);
    return encoded_letter;
}

bool at_eof(FILE *file_ptr){
    int pos = ftell(file_ptr), ch = 0;
    //fgetc(file_ptr);
    //bool eof =(fgetc(file_ptr) == EOF);
    ch = fgetc(file_ptr);
    bool eof = (ch == EOF);
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

void decode_to_output_file(EncDec_t *self, unsigned char *letter_indexes){
    char buff[DECODED_GROUP_SZ];
    memset(buff, '\0', (DECODED_GROUP_SZ + 1)*sizeof(char));

    //Teniendo los números asociados se hace la decodificación en sí misma
    //relacionando los valores en b64 y ascii
    //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3
    //Se encuentran explicados los cálculos en el informe
    buff[0] = (letter_indexes[0] << 2) | ((letter_indexes[1] & 0x30) >> 4);
    buff[1] = ((letter_indexes[1] & 0xf) << 4) | ((letter_indexes[2] & 0x3c) >> 2);
    buff[2] = ((letter_indexes[2] & 0x3) << 6) | letter_indexes[3];

    fwrite(buff, sizeof(char), DECODED_GROUP_SZ, self->output_file);
}

int decode_text(EncDec_t *self){
    size_t qty_read = 0;
    unsigned char indexes[ENCODED_GROUP_SZ + 1], letters[ENCODED_GROUP_SZ + 1];
    memset(letters, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));
    unsigned char encoded_letter = '\0';

    //Obtengo el caracter de relleno ('=')
    fseek(self->characters, FILL_CHAR_POS, SEEK_SET);
    char fill_character = fgetc(self->characters);
    fseek(self->characters, 0, SEEK_SET);

    //Vamos a tomar caracteres mientras no se termine src
    while (!at_eof(self->input_file)) {
        //Inicializo el array de caracteres leidos con el caractere
        //de relleno por si no se completa la cantidad de bytes esperados.
        //Esto solo agrega un '\0' al resultado decodificado.
        memset(letters, fill_character, ENCODED_GROUP_SZ*sizeof(char));
        memset(indexes, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

        qty_read = fread(letters, sizeof(char), ENCODED_GROUP_SZ, self->input_file);

        //Se mueve por los 4 bytes
        for (int i = 0; i < qty_read; ++i) {
            //Si el caracter no pertenece a los posibles en b64
            //y no es el caracter de relleno ('=') -> se rompe el ciclo.
            if ( (letters[i] != fill_character) && !isalnum(letters[i]) ) {
        	       return INVALID_CHARACTER;
        	  }
            if (letters[i] == fill_character){
                //Si la letra leida es el caracter de relleno,
                //llenamos con 0 la posicion de ese caracter.
                indexes[i] =  0;
            }else{
                //Si no, tenemos que buscar el índice de la letra.
                //en la lista de b64 y guardar su posición.
                fseek(self->characters, 0, SEEK_SET);
                bool found_letter_index = false;
                while (!at_eof(self->characters) && !found_letter_index) {
                    encoded_letter = fgetc(self->characters);
                    found_letter_index = (letters[i] == encoded_letter);
                    if (found_letter_index) {
                        indexes[i] = ftell(self->characters) - 1; //No necesita seguir buscando
                    }
                }
            }
        }
        decode_to_output_file(self, indexes);
    }
    return SUCCESS;
}
