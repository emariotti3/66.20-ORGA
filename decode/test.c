#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int
main (void) {

  // decode
  printf("YW55IGNhcm5hbCBwbGVhc3VyZS4= se decodifica como %s \n \n", b64_decode((const char *)"YW55IGNhcm5hbCBwbGVhc3VyZS4=",28)); 
  printf("YW55IGNhcm5hbCBwbGVhc3VyZQ== se decodifica como %s \n \n", b64_decode((const char *)"YW55IGNhcm5hbCBwbGVhc3VyZQ==",28)); 
  printf("YW55IGNhcm5hbCBwbGVhc3Vy se decodifica como %s \n \n", b64_decode((const char *)"YW55IGNhcm5hbCBwbGVhc3Vy",28)); 
  printf("TWFu se decodifica como %s \n \n", b64_decode((const char *)"TWFu",4));
  printf("Ilkgc29icmUgdG9kbywgc8OpIGZpZWwgYSB0aSBtaXNtbywgcHVlcyBkZSBlbGxvIHNlIHNpZ3VlLCBjb21vIGVsIGTDrWEgYSBsYSBub2NoZSwgcXVlIG5vIHBvZHLDoXMgc2VyIGZhbHNvIGNvbiBuYWRpZS4i se decodifica como %s \n \n", b64_decode((const char *)"Ilkgc29icmUgdG9kbywgc8OpIGZpZWwgYSB0aSBtaXNtbywgcHVlcyBkZSBlbGxvIHNlIHNpZ3VlLCBjb21vIGVsIGTDrWEgYSBsYSBub2NoZSwgcXVlIG5vIHBvZHLDoXMgc2VyIGZhbHNvIGNvbiBuYWRpZS4i",160));
  

  return 0;
}
