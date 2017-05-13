#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "encoder_decoder_t.h"

#define COMPARATOR 0
#define EXIT_SUCCESS 0
#define ERROR_ACTION 1
#define ENCODE 2
#define DECODE 3
#define BUFF_SZ 100
#define VERSION "version.txt"
#define HELP "help.txt"

int print_file(char *fname){
    char buff[BUFF_SZ + 1];
    FILE *file = fopen(fname, "r+");

    while(!feof(file)){
        memset(buff, '\0',(BUFF_SZ + 1)*sizeof(char));
        fread(buff, sizeof(char), BUFF_SZ, file);
        printf("%s",buff);
    }
    fclose(file);
    return EXIT_SUCCESS;
}

int show_version(){
    return print_file(VERSION);
}

int show_help(){
    return print_file(HELP);
}

bool free_mem(FILE* input, FILE* output){
    return (fclose(input) != EOF) && (fclose(output) != EOF);
}

int menu(int argc, char** argv, FILE **input, FILE **output){
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
                FILE* salida = fopen(argv[counter],"wb+");
                if (!salida){
					printf("Error de apertura de archivo de salida. No se puede continuar.\n");
					return -1;
				}
				else{
					*output = salida;
				}
            }
        }
        else if (strncmp(argv[counter],"-i",strlen("-i")) == COMPARATOR || strncmp(argv[counter],"--input",strlen("--input")) == COMPARATOR){
            counter++;
            if (strncmp(argv[counter],"-",strlen("-")) != COMPARATOR){
                FILE* entrada = fopen(argv[counter],"rb+");
                if (!entrada){
					printf("Error de apertura de archivo de entrada. No se puede continuar.\n");
					return -1;
				}
				else{
					*input = entrada;
				}            
            
            }
        }
    }
    return exit;
}

int main(int argc, char* argv[]){
    EncDec_t encdec;
    FILE* input = stdin;
    FILE* output = stdout;

    int action_code = menu(argc, argv, &input, &output);
    if (action_code == -1){
			return -1;
	}
    init_encdec(&encdec, input, output);

    switch (action_code){
        case ENCODE:
            encode_text(&encdec);
            break;
        case DECODE:
            decode_text(&encdec);
            break;
        case EXIT_SUCCESS:
            return EXIT_SUCCESS;
    }
    return free_mem(input, output);
}

