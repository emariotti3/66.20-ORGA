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

    if (input != stdin){
        fclose(input);
        printf("Libera INPUT FILE\n");
    }

    if (output != stdout){
        fclose(output);
        printf("Libera OUTPUT FILE\n");
    }

    return EXIT_SUCCESS;
}

int menu(int argc, char** argv, FILE** input, FILE** output){

    int exit = DECODE;

    for (int counter = 1; counter < argc; counter++){

        if (strcmp(argv[counter],"-h") == COMPARATOR || strcmp(argv[counter],"--help") == COMPARATOR){
            show_help();
            return EXIT_SUCCESS;
        }
        else if (strcmp(argv[counter],"-V") == COMPARATOR || strcmp(argv[counter],"--version") == COMPARATOR){
            show_version();
            return EXIT_SUCCESS;
        }
        else if (strcmp(argv[counter],"-a") == COMPARATOR || strcmp(argv[counter],"--action") == COMPARATOR){
            counter++;
            if (strcmp(argv[counter],"decode") == COMPARATOR){
                exit = DECODE;
            }
            else if (strcmp(argv[counter],"encode") == COMPARATOR){
                exit = ENCODE;
            }
            else{
                return ERROR_ACTION;
            }
        }
        else if (strcmp(argv[counter],"-o") == COMPARATOR || strcmp(argv[counter],"--output") == COMPARATOR){
            counter++;
            if (strcmp(argv[counter],"-") != COMPARATOR){
                *output = fopen(argv[counter],"wb+");
            }
        }
        else if (strcmp(argv[counter],"-i") == COMPARATOR || strcmp(argv[counter],"--input") == COMPARATOR){
            counter++;
            if (strcmp(argv[counter],"-") != COMPARATOR){
                *input = fopen(argv[counter],"rb+");
            }
        }
    }

    return exit;
}

int main(int argc, char* argv[]){
    EncDec_t encdec;
    FILE* input = stdin;
    FILE* output = stdout;

    int code = menu(argc, argv, &input, &output);

    init_encdec(&encdec, input, output);
    encode_text(&encdec);

    free_mem(input, output);

    return EXIT_SUCCESS;
}
