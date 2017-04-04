#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "encoder_decoder_t.h"
#define COMPARATOR 0
#define ENCODE 0
#define DECODE 1
#define ERROR_ACTION 2

int show_version(){

    printf("Organizacion de Computadoras - TP0\n");
    printf("Encoder/Decoder Base64 - v0.1\n\n");
    printf("Group Members:\n");
    printf("Gonzalez Perez, Ailen\t\tPadron: 97043\n");
    printf("Mariotti, Maria Eugenia\t\tPadron: 96260\n");
    printf("Raña, Cristian Ezequiel\t\tPadron: 95457\n");

    return EXIT_SUCCESS;

}

int show_help(){

    printf("Usage:\n");
    printf("  tp0 -h\n");
    printf("  tp0 -V\n");
    printf("  tp0 [options]\n\n");
    printf("Options:\n");
    printf("  -V, --version\t\tPrint version and quit.\n");
    printf("  -h, --help\t\tPrint this information.\n");
    printf("  -i, --input\t\tLocation of the input file.\n");
    printf("  -o, --output\t\tLocation of the output file.\n");
    printf("  -a, --action\t\tProgram action: encode (default) or decode.\n\n");
    printf("Examples:\n");
    printf("  tp0 -a encode -i ~/input -o ~/output\n");
    printf("  tp0 -a decode\n\n");

    return EXIT_SUCCESS;

}

int free_mem(FILE* input, FILE* output){

    //if (input != stdin){
        fclose(input);
    //    printf("Libera INPUT FILE\n");
    //}

    //if (output != stdout){
        fclose(output);
      //  printf("Libera OUTPUT FILE\n");
    //}

    return EXIT_SUCCESS;
}

int menu(int argc, char** argv, FILE *input, FILE *output){
    int exit = ENCODE;

    for (int counter = 1; counter < argc; counter++){

        if (strncmp(argv[counter],"-h", strlen("-h")) == COMPARATOR || strncmp(argv[counter],"--help",strlen("--help")) == COMPARATOR){
            show_help();
            return EXIT_SUCCESS;
        }
        else if (strncmp(argv[counter],"-V", strlen("-V")) == COMPARATOR || strncmp(argv[counter],"--version", strlen("--version")) == COMPARATOR){
            show_version();
            return EXIT_SUCCESS;
        }
        else if (strncmp(argv[counter],"-a",strlen("-a")) == COMPARATOR || strncmp(argv[counter],"--action",strlen("--action")) == COMPARATOR){
            counter++;
            if (strncmp(argv[counter],"decode", strlen("decode")) == COMPARATOR){
                exit = DECODE;
            }
            else if (strncmp(argv[counter],"encode", strlen("encode")) == COMPARATOR){
                exit = ENCODE;
            }
            else{
                return ERROR_ACTION;
            }
        }
        else if (strncmp(argv[counter],"-o",strlen("-o")) == COMPARATOR || strncmp(argv[counter],"--output",strlen("--output")) == COMPARATOR){
            counter++;
            if (strncmp(argv[counter],"-",strlen("-")) != COMPARATOR){
                *output = *fopen(argv[counter],"wb+");
            }
        }
        else if (strncmp(argv[counter],"-i",strlen("-i")) == COMPARATOR || strncmp(argv[counter],"--input",strlen("--input")) == COMPARATOR){
            counter++;
            if (strncmp(argv[counter],"-",strlen("-")) != COMPARATOR){
                *input = *fopen(argv[counter],"rb+");
            }
        }
    }
    return exit;
}

int main(int argc, char* argv[]){
    EncDec_t encdec;
    FILE* input = stdin;
    FILE* output = stdout;

    int action_code = menu(argc, argv, input, output);
    init_encdec(&encdec, input, output);

    switch (action_code) {
        case ENCODE:
            encode_text(&encdec);
            break;
        case DECODE:
            decode_text(&encdec);
            break;
    }

    free_mem(input, output);
    return EXIT_SUCCESS;
}
