#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "../src/encoder_decoder_t.h"

#define DEC_TEST1_IN "dec_test1_in.txt"
#define DEC_TEST1_OUT "dec_test1_out.txt"
#define DEC_TEST2_IN "dec_test2_in.txt"
#define DEC_TEST2_OUT "dec_test2_out.txt"
#define DEC_TEST3_IN "dec_test3_in.txt"
#define DEC_TEST3_OUT "dec_test3_out.txt"
#define DEC_TEST4_IN "dec_test4_in.txt"
#define DEC_TEST4_OUT "dec_test4_out.txt"
#define DEC_TEST5_IN "dec_test5_in.txt"
#define DEC_TEST5_OUT "dec_test5_out.txt"
#define FOUT "out.txt"
#define EQUALS 0
#define SUCCESS 0

bool are_equals(FILE* esperado, FILE* obtenido){
    fseek(esperado, 0, SEEK_SET);
    fseek(obtenido, 0, SEEK_SET);
    while(!feof(obtenido)){
        if(fgetc(esperado) != fgetc(obtenido)){
            return false;
        }
    }
    return true;
}

void print_test(const char *test_name, bool test_passed){
    printf("PRUEBA %s: %s.\n", test_name, test_passed ? "OK":"ERROR");
}

void run_test(const char *test_name, EncDec_t *encdec, const char *file_in, const char* file_out){
    FILE *ftest_in = fopen(file_in, "r+"); //input
    FILE *ftest_out = fopen(file_out, "r+"); //resultado esperado
    FILE *ftest_resu = fopen(FOUT, "w+"); //output
    set_input(encdec, ftest_in);
    set_output(encdec, ftest_resu);
    int success = decode_text(encdec);

    print_test(test_name, (success == SUCCESS) && are_equals(ftest_in, ftest_out));
    fclose(ftest_in);
    fclose(ftest_out);
    fclose(ftest_resu);
}

void pruebas_decodificador(EncDec_t *encdec){
    printf("Pruebas del decodificador: \n \n");
    run_test("TEXTO1 DECODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST1_IN, DEC_TEST1_OUT);
    run_test("TEXTO2 DECODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST2_IN, DEC_TEST2_OUT);
    run_test("TEXTO3 DECODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST3_IN, DEC_TEST3_OUT);
    run_test("TEXTO4 DE NUMEROS DECODIFICADO", encdec, DEC_TEST4_IN, DEC_TEST4_OUT);
    run_test("TEXTO5 DE NUMEROS Y LETRAS DECODIFICADO", encdec, DEC_TEST5_IN, DEC_TEST5_OUT);
}

void pruebas_codificador(EncDec_t *encdec){
    printf("Pruebas del codificador: \n \n");
    run_test("TEXTO1 CODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST1_OUT, DEC_TEST1_IN);
    run_test("TEXTO2 CODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST2_OUT, DEC_TEST2_IN);
    run_test("TEXTO3 CODIFICADO CON SIMBOLOS DE RELLENO", encdec, DEC_TEST3_OUT, DEC_TEST3_IN);
    run_test("TEXTO4 DE NUMEROS CODIFICADO", encdec, DEC_TEST4_OUT, DEC_TEST4_IN);
    run_test("TEXTO5 DE NUMEROS Y LETRAS CODIFICADO", encdec, DEC_TEST5_OUT, DEC_TEST5_IN);
}

int main (void) {
    EncDec_t encdec;
    init_encdec(&encdec, NULL, NULL);
    pruebas_decodificador(&encdec);
    pruebas_codificador(&encdec);
    return 0;
}
