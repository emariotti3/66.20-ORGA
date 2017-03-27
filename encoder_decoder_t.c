#include <string.h>
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

bool init_encdec(EncDec_t *self, char *fname_in, char *fname_out){
    self->characters = fopen(SYMBOLS_FILE, "r+");
    self->input_file = fname_in;
    self->output_file = fname_out;
    return true;
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

void encode_text(EncDec_t *self){
    //SI NOS DAN UN ARCHIVO, SI NO HAY QUE USAR STDOUT/STDIN
    FILE *text_file = fopen(self->input_file, "rb+");
    FILE *encoded_file = fopen(self->output_file, "wb+");

    //TODO:esto se podría flexibilizar mas:
    int index = 0, shift_count = 0, read_byte = 0;
    int group_qty = (BYTE_GROUP * BYTE_SZ) / GROUP_SZ;
    char encoded_chars[group_qty + 1], read_letters[sizeof(int) + 1];
    int masks[] = {MASK1, MASK2, MASK3, MASK4};

    while(!at_eof(text_file)){
        memset(&read_letters, '\0', sizeof(int) + 1);
        memset(&encoded_chars,'\0',(group_qty + 1)*sizeof(char));
        fread(read_letters, sizeof(char), BYTE_GROUP, text_file);
        read_byte = concantenate_binary_to_int(read_letters);
        for (int j = 0; j < group_qty; ++j){
            shift_count = (group_qty - j - 1)*GROUP_SZ + BYTE_SZ;
            index = (read_byte & masks[j]) >> shift_count;
            //Si index es 0, entonces le asignamos la posicion
            //del caracter de relleno('=' en este caso).
            index = (index != 0)? index : FILL_CHAR_POS;
            encoded_chars[j] = encode(self, index);
        }
        fwrite(encoded_chars, sizeof(char), group_qty, encoded_file);
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
