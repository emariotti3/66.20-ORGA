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
#define SYMBOL_POS 62
#define ENCODED_GROUP_SZ 4
#define DECODED_GROUP_SZ 3
#define SUCCESS 0
#define NEW_LINE '\n'

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

bool at_stdin_end(EncDec_t *self, char c){
    return self->input_file == stdin && c == NEW_LINE;
}

int read_input(EncDec_t *self, char *buffer, size_t count){
    int i = 0;
    char c;
    for(; i < count; ++i){
        c = getc(self->input_file);
        //No incluyo los caracteres nulos o EOF
        if (c == EOF || c == '\0'){
            return i;
        }
        buffer[i] = c;
        if (at_stdin_end(self, c)){
            return i+1;
        }
    }
    return count;
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
    int index = 0, shift_count = 0, read_bytes = 0, tot_read = 0;
    //group_qty: la cantidad de grupos de 6 bits que puedo formar
    //con los bytes que leo:
    int group_qty = (BYTE_GROUP * BYTE_SZ) / GROUP_SZ;
    char encoded_chars[group_qty + 1], read_letters[sizeof(int)];

    //Array de mascaras a utilizar para obtener los
    //bits que me interesan.
    int masks[] = {MASK1, MASK2, MASK3, MASK4};
    fseek(self->input_file, 0, SEEK_SET);
    memset(&read_letters, '\0', sizeof(int));
    memset(&encoded_chars,'\0',(group_qty + 1)*sizeof(char));

    tot_read = read_input(self, read_letters, BYTE_GROUP);

    //Leo 3 bytes del archivo de entrada y los guardo en read_letters
    while (tot_read > 0){
        //Leo 3 bytes del input y los almaceno en un array de chars, para
        //luego concatenar los bits de los 3 bytes leidos en un int (32 bits).
        //No puedo aplicar fread directamente al integer porque me cambia
        //el endianness.
        read_bytes = concantenate_binary_to_int(read_letters);

        //Ahora aplico operaciones logicas con las mascaras
        //y shifteo de bits para poder obtener los grupos
        //de bits que quiero y obtengo un index:
        for (int j = 0; j < group_qty; ++j){
            shift_count = (group_qty - j - 1)*GROUP_SZ + BYTE_SZ;
            index = (read_bytes & masks[j]) >> shift_count;
            //Si index es 0, entonces le asignamos la posicion
            //del caracter de relleno('=' en este caso).
            index = (index != 0)? index : FILL_CHAR_POS;
            //Uso el index para obtener un caracter del
            //archivo de caracteres posibles:
            encoded_chars[j] = encode(self, index);
        }
        fwrite(encoded_chars, sizeof(char), group_qty, self->output_file);

        memset(&read_bytes, 0, sizeof(int));
        memset(&read_letters, '\0', sizeof(int));
        memset(&encoded_chars,'\0',(group_qty + 1)*sizeof(char));

        //Corto la codificacion si en el string anterior leido había un
        //caracter de fin:
        if (tot_read < BYTE_GROUP){
            char new_ln = NEW_LINE;
            fwrite(&new_ln, sizeof(char), 1, self->output_file);
            return SUCCESS;
        }
        tot_read = read_input(self, read_letters, BYTE_GROUP);
    }
    char new_ln = NEW_LINE;
    fwrite(&new_ln, sizeof(char), 1, self->output_file);
    return SUCCESS;
}

void decode_to_output_file(EncDec_t *self, char *letter_indexes){
    char buff[DECODED_GROUP_SZ + 1];
    memset(buff, '\0', (DECODED_GROUP_SZ + 1)*sizeof(char));

    //Teniendo los números asociados se hace la decodificación en sí misma
    //relacionando los valores en b64 y ascii
    //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3
    //Se encuentran explicados los cálculos en el informe
    buff[0] = (letter_indexes[0] << 2) | ((letter_indexes[1] & 0x30) >> 4);
    buff[1] = ((letter_indexes[1] & 0xf) << 4) | ((letter_indexes[2] & 0x3c) >> 2);
    buff[2] = ((letter_indexes[2] & 0x3) << 6) | letter_indexes[3];

    fwrite(buff, sizeof(char), strlen(buff), self->output_file);
}

bool issymbol(EncDec_t *self, char *c){
    unsigned char encoded_letter = '\0';
    fseek(self->characters, SYMBOL_POS, SEEK_SET);
    bool found_letter_index = false;
    while (!feof(self->characters) || !found_letter_index) {
        encoded_letter = fgetc(self->characters);
        found_letter_index = (*c == encoded_letter);
        if (found_letter_index) {
            *c = ftell(self->characters) - 1;
            return true;
        }
    }
    return false;
}

int decode(EncDec_t *self, char *letters, char fill_character){
    char indexes[ENCODED_GROUP_SZ + 1];
    memset(indexes, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

    for (int i = 0; i < ENCODED_GROUP_SZ; ++i) {
        //Si no, tenemos que buscar el índice de la letra.
        //en b64 y guardar su posición.
        if (letters[i] == fill_character){
            //Si la letra leida es el caracter de relleno,
            //llenamos con 0 la posicion de ese caracter.
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
        if(!issymbol(self, letters +i)){
            return INVALID_CHARACTER;
        }
    }
    decode_to_output_file(self, indexes);
    return SUCCESS;
}

int decode_text(EncDec_t *self){
    int qty_read = 0, result = SUCCESS;
    char letters[ENCODED_GROUP_SZ + 1];
    memset(letters, '\0', (ENCODED_GROUP_SZ + 1)*sizeof(char));

    //Obtengo el caracter de relleno ('=')
    fseek(self->characters, FILL_CHAR_POS, SEEK_SET);
    char fill_character = fgetc(self->characters);
    fseek(self->characters, 0, SEEK_SET);

    //Inicializo el array de caracteres leidos con el caractere
    //de relleno por si no se completa la cantidad de bytes esperados.
    //Esto solo agrega un '\0' al resultado decodificado.
    memset(letters, fill_character, ENCODED_GROUP_SZ*sizeof(char));
    qty_read = read_input(self, letters, ENCODED_GROUP_SZ);

    while (qty_read > 0){
        result = decode(self, letters, fill_character);
        if (qty_read < ENCODED_GROUP_SZ){
            return result;
        }
        memset(letters, fill_character, ENCODED_GROUP_SZ*sizeof(char));
        qty_read = read_input(self, letters, ENCODED_GROUP_SZ);
    }
    return result;
}
