CC = gcc
CFLAGS = -g -Wall -pedantic -std=c99

OBJECTS = encoder_decoder_t.o
EXEC = encdec

VALGRIND = valgrind --track-origins=yes --leak-check=full
VALGRIND-V = $(VALGRIND) -v

all: $(EXEC)

encoder_decoder_t.o: encoder_decoder_t.c encoder_decoder_t.h
	$(CC) $(CFLAGS) -c encoder_decoder_t.c -o encoder_decoder_t.o

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) tp0.c -o $(EXEC)

run: $(EXEC)
	./$(EXEC)

valgrind: $(EXEC)
	$(VALGRIND) ./$(EXEC)

valgrind-verb: $(EXEC)
	$(VALGRIND-V) ./$(EXEC)

clean:
	rm -f *.o $(EXEC)
