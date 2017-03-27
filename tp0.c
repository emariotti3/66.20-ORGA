#include <stdio.h>
#include <stdlib.h>
#include "encoder_decoder_t.h"

int main(int argc, char* argv[]){
    EncDec_t encdec;
    char fname_in[] = "in.txt";
    char fname_out[] = "out.txt";
    init_encdec(&encdec, fname_in, fname_out);
    encode_text(&encdec);
    return 0;
}
