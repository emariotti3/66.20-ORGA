#include <encoder_decoder_t.h>

bool init_encdec(EncDec_t *self, char *fname_in, char *fname_out, int bits_qty){
    self->input_file = fname_in;
    self->output_file = fname_out;
    self->bit_qty = bits_qty;
    return true;
}

void encode_text(EncDec_t *self){
    //SI NOS DAN UN ARCHIVO, SI NO HAY QUE USAR STDOUT/STDIN
    FILE *text_file = fopen(self->input_file, "rb+");
    FILE *encoded_file = fopen(self->output_file, "wb+");
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
