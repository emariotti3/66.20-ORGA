#include "base64.h"
#include "encoder_decoder_t.h"

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

