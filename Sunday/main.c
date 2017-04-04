#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#define MAX 200

static const char b64_table[] = {
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
  'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
  'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
  'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
  'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
  'w', 'x', 'y', 'z', '0', '1', '2', '3',
  '4', '5', '6', '7', '8', '9', '+', '/',
};

int show_version(){

    printf("\nOrganizacion de Computadoras - TP0\n");
    printf("\nEncoder/Decoder Base64 - v0.1 \n\n");
    printf("Group Members:\n");
    printf("Gonzalez Perez, Ailen\t\tPadron: 97043\n");
    printf("Mariotti, Maria Eugenia\t\tPadron: 96260\n");
    printf("Raña, Cristian Ezequiel\t\tPadron: 95457\n \n");

    return EXIT_SUCCESS;

}

int show_help(){

    printf("Usage:\n");
    printf("  tp0 -h\n");
    printf("  tp0 -V\n");
    printf("  tp0 [options]\n\n");
    printf("Options:\n");
    printf("  -V, --version\t\tPrint version and quit.\n");
    printf("  -h, --help\t\tPrint this information and quit.\n");
    printf("  -i, --input\t\tLocation of the input file.\n");
    printf("  -o, --output\t\tLocation of the output file.\n");
    printf("  -a, --action\t\tProgram action: encode (default) or decode.\n\n");
    printf("Examples:\n");
    printf("  tp0 -a encode -i ~/input -o ~/output\n");
    printf("  tp0 -a decode\n\n");

    return EXIT_SUCCESS;

}

char * d_reader(FILE* file){
  char buffer[MAX];
  memset(buffer, '\0', sizeof(char)*MAX);
	int totalCharacters = 0;
	int readCharacters = fread(buffer, sizeof(char), MAX, file);

	//I initialize a "basic" string
	char* read = malloc(sizeof(char)*MAX);

	while(readCharacters > 0){
		//If I read a character, I copy it into
		char* appendix = &read[totalCharacters];
		strcpy(appendix, buffer);
		read = (char *) realloc(read, sizeof(read) + 1);
		totalCharacters += readCharacters;
		readCharacters = fread(file, sizeof(char), MAX,file);
	}

	return read;
}

char * e_reader(FILE* file){
  char buffer[MAX];
  memset(buffer, '\0', sizeof(char)*MAX);
	int totalCharacters = 0;
	int readCharacters = fread(buffer, sizeof(char), MAX, file);

	//I initialize a "basic" string
	char* read = malloc(sizeof(char)*MAX);

	while(readCharacters > 0){
		//If I read a character, I copy it into
		char* appendix = &read[totalCharacters];
		strcpy(appendix, buffer);
		read = (char *) realloc(read, sizeof(read) + 1);
		totalCharacters += readCharacters;
		readCharacters = fread(file, sizeof(char), MAX,file);
	}
	//Eliminar \0
	for(int i = 0; i < strlen(read);i++){
		if(read[i] == '\n'){
			for(int j = i; j < strlen(read);j++)
				read[j] = read[j+1];
		}
	}
	return read;
}


char * b64_decode(const char *src, size_t len) {
  int i = 0; //Contadores
  int j = 0; //para los
  int l = 0; //recorridos

  size_t size = 0;
  char *dec = NULL;
  unsigned char buf[3];
  unsigned char tmp[4];

  // alloc
  dec = (char *) malloc(0);
  if (NULL == dec) { return NULL; }

  //Vamos a tomar caracteres mientras no se termine src
  while (len--) {
    //Si el caracter no pertenece a los posibles en b64
    //o si es el símbolo = -> rompe el ciclo
    if ( ('=' == src[j]) || (!(isalnum(src[j]) || '+' == src[j] || '/' == src[j])) ) {
		break;
	}

    //Vamos a ir leyendo hasta 4 bytes (los 4 bytes de b64 nos dan 3 bytes de ascii
    //Se van guardando en tmp esos 4 bytes
    tmp[i++] = src[j++];

    // Si ya leimos 4, pasamos a la traducción
    if (4 == i) {
      //Se mueve por los 4 bytes
      for (i = 0; i < 4; ++i) {
        //Cuando encontramos el caracter en la lista de b64, guardamos su posición
        //(Su número asociado)
        for (l = 0; l < 64; ++l) {
          if (tmp[i] == b64_table[l]) {
            tmp[i] = l;
            break; //No necesita seguir buscando
          }
        }
      }

      //Teniendo los números asociados se hace la decodificación en sí misma
      //relacionando los valores en b64 y ascii
      //A considerar: 0x30 = 48 0x3c = 60  0xf= 15 0x3 = 3
      //Se encuentran explicados los cálculos en el informe


      buf[0] = (tmp[0] << 2) + ((tmp[1] & 0x30) >> 4); //Línea 1
      buf[1] = ((tmp[1] & 0xf) << 4) + ((tmp[2] & 0x3c) >> 2); //Línea 2
      buf[2] = ((tmp[2] & 0x3) << 6) + tmp[3]; //Línea 3

      //Guardamos lo obtenido
      dec = (char *) realloc(dec, size + 3);
      for (i = 0; i < 3; ++i) {
        dec[size++] = buf[i];
      }

      //Reseteamos el contador de i
      i = 0;
    }
  }

  //Si no es múltiplo de 4, vamos a tener un valor en i, que será 1-2-3
  if (i > 0) {
    //Vamos a llenar tmp(j) con \0
    for (j = i; j < 4; ++j) {
      tmp[j] = '\0';
    }

    //Buscamos la traducción para lo que haya quedado grabado tras agregar los \0
    for (j = 0; j < 4; ++j) {
        for (l = 0; l < 64; ++l) {
          if (tmp[j] == b64_table[l]) {
            tmp[j] = l;
            break;
          }
        }
    }

    //Decodificación
    buf[0] = (tmp[0] << 2) + ((tmp[1] & 0x30) >> 4);
    buf[1] = ((tmp[1] & 0xf) << 4) + ((tmp[2] & 0x3c) >> 2);
    buf[2] = ((tmp[2] & 0x3) << 6) + tmp[3];

    //Agregamos lo que faltaba a dec
    dec = (char *) realloc(dec, size + (i - 1));
    for (j = 0; (j < i - 1); ++j) {
      dec[size++] = buf[j];
    }
  }

  //Agregamos el caracter de fin de línea.
  dec = (char *) realloc(dec, size + 1);
  dec[size] = '\0';

  return dec;
}

char * b64_encode (char *src, size_t len) {
  int i = 0;
  int j = 0;
  char * enc = NULL;
  size_t size = 0;
  unsigned char buf[4];
  unsigned char tmp[3];

  enc = (char *) malloc(0);
  if (NULL == enc) { return NULL; }


  while (len--) {
    tmp[i++] = *(src++);

    // Aquí es de a tres (inverso a decode)
    if (3 == i) {
      buf[0] = (tmp[0] & 0xfc) >> 2;
      buf[1] = ((tmp[0] & 0x03) << 4) + ((tmp[1] & 0xf0) >> 4);
      buf[2] = ((tmp[1] & 0x0f) << 2) + ((tmp[2] & 0xc0) >> 6);
      buf[3] = tmp[2] & 0x3f;

      enc = (char *) realloc(enc, size + 4);
      for (i = 0; i < 4; ++i) {
        enc[size++] = b64_table[buf[i]];
      }

      i = 0;
    }
  }


  if (i > 0) {
    for (j = i; j < 3; ++j) {
      tmp[j] = '\0';
    }

    buf[0] = (tmp[0] & 0xfc) >> 2;
    buf[1] = ((tmp[0] & 0x03) << 4) + ((tmp[1] & 0xf0) >> 4);
    buf[2] = ((tmp[1] & 0x0f) << 2) + ((tmp[2] & 0xc0) >> 6);
    buf[3] = tmp[2] & 0x3f;

    for (j = 0; (j < i + 1); ++j) {
      enc = (char *) realloc(enc, size + 1);
      enc[size++] = b64_table[buf[j]];
    }


    while ((i++ < 3)) {
      enc = (char *) realloc(enc, size + 1);
      enc[size++] = '=';
    }
  }

  // Add '\0' character at end.
  enc = (char *) realloc(enc, size + 1);
  enc[size] = '\0';

  return enc;
}

int main(int argc, char* argv[]){
		FILE* input = stdin;
		FILE* output = stdout;
		char* action = "encode"; //What we are going to do
		bool showVersion = false; //To check if the version option was used
		bool showHelp = false;

		for (int i=1;i<argc;i++){
			if (strcmp("-h",argv[i])==0 || strcmp("--help",argv[i])==0 ){ //Help -> show help and continue execution
				show_help();
				showHelp = true;
				break;
			}

			if (strcmp("-V",argv[i])==0 || strcmp("--version",argv[i])==0 ){ //Version -> show version and save the boolean
				show_version();
				showVersion = true;
				break;
			}

			if (strcmp("-i",argv[i])==0 || strcmp("--input",argv[i])==0 ){ //If -i option is set, we have an input file
				input = fopen(argv[i+1],"rb+");
				if (input==NULL){
					printf("Error de apertura de archivo de entrada. No se puede continuar.\n");
					return -1;
				}
				i++;
			}

			if (strcmp("-o",argv[i]) == 0 || strcmp("--output",argv[i]) == 0 ){ //If -o option is set, we have an output file
					output = fopen(argv[i+1],"wb+");
					if (output==NULL){
					printf("Error de apertura de archivo de salida. No se puede continuar.\n");
					return -1;
				}
				i++;
			}

			if (strcmp("-a",argv[i]) == 0 || strcmp("--action",argv[i]) == 0 ){ //Defines if we decode or encode
				action = argv[i+1];
				if (strcmp("decode",action) != 0 && strcmp("encode",action) != 0){
					printf("%s no es una opción válida.\n",action);
					return -1;
				}
				i++;
			}
		}

		if (showVersion || showHelp){ //-v and -h "show and quit" options
			if (input != stdin)
				fclose(input);
			if (output != stdout)
				fclose(output);
			return 0;
		}

		char *result; //Where we save the decoded/encoded string
    char *target;

		if ( strcmp("decode",action) == 0 ){ //If action = decode -> call b64_decode
			target = d_reader(input); //Argument for b64_decode/encode
			result = b64_decode(target,strlen(target));
		}else{ //If action = encode -> call b64_encode
			target = e_reader(input);
			result = b64_encode(target,strlen(target));
		}

		if(output == stdout) //If stdout -> printf the result
			printf("\nEl resultado del %s es: %s \n\n",action,result); //Make it friendly

		else{ //Print on file the result
			fprintf(output, "%s", result);
			fclose(output); //Close the output file
		}

		if(input != stdin)
			fclose(input); //If it was open, close the input file

    free(target);
		free(result);
		return 0; //Everything went fine
}
