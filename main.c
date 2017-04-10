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
    printf("\nEncoder/Decoder Base64 - v1.1 \n\n");
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

char * b64_decode(char *src, size_t len) {
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
    //Vamos a ir leyendo hasta 4 bytes (los 4 bytes de b64 nos dan 3 bytes de ascii
    //Se van guardando en tmp esos 4 bytes
    tmp[i++] = src[j++];
	}
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

  //Agregamos el caracter de fin de línea.
  dec = (char *) realloc(dec, size + 1);
  dec[size] = '\0';
 
  return dec;
}

char * b64_encode (char *src, size_t len) {
int i = 0;
  int j = 0;
  char *enc = NULL;
  size_t size = 0;
  unsigned char buf[4];
  unsigned char tmp[3];

  // alloc
  enc = (char *) malloc(0);
  if (NULL == enc) { return NULL; }

  // parse until end of source
  while (len--) {
    // read up to 3 bytes at a time into `tmp'
    tmp[i++] = *(src++);

    // if 3 bytes read then encode into `buf'
    if (3 == i) {
      buf[0] = (tmp[0] & 0xfc) >> 2;
      buf[1] = ((tmp[0] & 0x03) << 4) + ((tmp[1] & 0xf0) >> 4);
      buf[2] = ((tmp[1] & 0x0f) << 2) + ((tmp[2] & 0xc0) >> 6);
      buf[3] = tmp[2] & 0x3f;

      // allocate 4 new byts for `enc` and
      // then translate each encoded buffer
      // part by index from the base 64 index table
      // into `enc' unsigned char array
      enc = (char *) realloc(enc, size + 4);
      for (i = 0; i < 4; ++i) {
        enc[size++] = b64_table[buf[i]];
      }

      // reset index
      i = 0;
    }
  }

  // remainder
  if (i > 0) {
    // fill `tmp' with `\0' at most 3 times
    for (j = i; j < 3; ++j) {
      tmp[j] = '\0';
    }

    // perform same codec as above
    buf[0] = (tmp[0] & 0xfc) >> 2;
    buf[1] = ((tmp[0] & 0x03) << 4) + ((tmp[1] & 0xf0) >> 4);
    buf[2] = ((tmp[1] & 0x0f) << 2) + ((tmp[2] & 0xc0) >> 6);
    buf[3] = tmp[2] & 0x3f;

    // perform same write to `enc` with new allocation
    for (j = 0; (j < i + 1); ++j) {
      enc = (char *) realloc(enc, size + 1);
      enc[size++] = b64_table[buf[j]];
    }

    // while there is still a remainder
    // append `=' to `enc'
    while ((i++ < 3)) {
      enc = (char *) realloc(enc, size + 1);
      enc[size++] = '=';
    }
  }

  // Make sure we have enough space to add '\0' character at end.
  enc = (char *) realloc(enc, size + 1);
  enc[size] = '\0';

  return enc;


}

int main(int argc, char* argv[]){
		
		FILE* input = stdin; //Where do we get the input?
		FILE* output = stdout; //Where do we get the output?
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
		
			if (strcmp("-o",argv[i])==0 || strcmp("--output",argv[i])==0 ){ //If -o option is set, we have an output file
					output = fopen(argv[i+1],"wb+");
					if (output==NULL){
					printf("Error de apertura de archivo de salida. No se puede continuar.\n");
					return -1;
				}
				i++;
			}
		
			if (strcmp("-a",argv[i])==0 || strcmp("--action",argv[i])==0 ){ //Defines if we decode or encode
				action = argv[i+1];
				if (strcmp("decode",action) !=0 && strcmp("encode",action) !=0){
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
		

		char* result;
		bool seguir = true; 
		
		if ( strcmp("decode",action) ==0 ){ //If action = decode -> call b64_decode
			result = malloc(4);

			while ( seguir ){
			char target[5]; //Para decodificar tomamos de a 4 bytes
			for (int i=0; i < 4; i++){ 
				int character = fgetc(input); //Tomamos el caracter
				if (character != '\0' && !( ('=' == character) || (!(isalnum(character) || '+' == character || '/' == character))) ){ //Si no es fin de file, lo guardamos
					target[i]=character;
				}
				else{
					for (int j=i;j<4;j++){ //Si es fin de linea, completamos con 0 lo que falte
						target[j]='\0';
						seguir = false;
					}
				}
			}
			target[4] = '\0';
			char* decoded = b64_decode(&target[0],4);
			result = realloc(result,strlen(result)+5);
			result = strcat(result,decoded);
			
			}
			result = realloc(result,strlen(result)+1);
			result[strlen(result)]='\0';
		}
		
		else{ //If action = encode -> call b64_encode
			result = malloc(4);
			int i=0;
			while ( seguir ){
				char target[4]; 
				
				for (i = 0; i < 3; i++){
					int character = fgetc(input); //Tomamos el caracter
					if (character != '\0' && character != EOF && character!='\n'){ //Si no es fin de file, lo guardamos
							target[i]=character;
					}
					else{
						seguir = false;
						for (int j=i;j<3;j++){ //Si es fin de linea, completamos con 0 lo que falte
							target[j]=0;	
						}
					}
				}
				
				target[3] = '\0';
				if(strcmp(&target[0],"")!=0){
				char* encoded = b64_encode(&target[0],3);

				result = realloc(result,(int) strlen(result)+5);
				result = strcat(result,encoded);
				}
			}
				
						
			result = realloc(result,strlen(result)+1);
			result[strlen(result)]='\n';
		}
		
		
		if(output == stdout) //If stdout -> printf the result
			printf("%s\n",result); //Make it friendly

		else{ //Print on file the result
			fprintf(output, "%s", result);
			fclose(output); //Close the output file
		}
		
		if(input != stdin)
			fclose(input); //If it was open, close the input file
			
		free(result);  
		
		return 0; //Everything went fine
}
