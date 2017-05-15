#ifndef BASE64_H
#define BASE64_H


/*Recibe dos file descriptors infd y outfd, 
codifica los leido desde infd a base64 
y lo escribe en el file descriptor outfd*/
int base64_encode(int infd, int outfd);

/*Recibe dos file descriptors infd y outfd, 
decodifica los leido desde infd en base64 
y lo escribe en el file descriptor outfd*/
int base64_decode(int infd, int outfd);

extern int saludar();

extern char get_fill_char();

extern char encode(unsigned int letter_index);

extern int concantenate_binary_to_int(unsigned char *characters);

extern int issymbol(unsigned char *c, char *index);

#endif //BASE64_H
