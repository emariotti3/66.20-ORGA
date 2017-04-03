CC = gcc
INC_DIR = ../src
CFLAGS = -g -Wall -I -pedantic -std=c99

OBJECTS = $(INC_DIR)/encoder_decoder_t.o
EXEC = tests

VALGRIND = valgrind --track-origins=yes --leak-check=full
VALGRIND-V = $(VALGRIND) -v

all: $(EXEC)

encoder_decoder_t.o: $(INC_DIR)/encoder_decoder_t.c $(INC_DIR)/encoder_decoder_t.h
	$(CC) $(CFLAGS) -c $(INC_DIR)/encoder_decoder_t.c -o $(INC_DIR)/encoder_decoder_t.o

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) encdec_unit_tests.c -o $(EXEC)

run: $(EXEC)
	./$(EXEC)

valgrind: $(EXEC)
	$(VALGRIND) ./$(EXEC)

valgrind-verb: $(EXEC)
	$(VALGRIND-V) ./$(EXEC)

clean:
	rm -f *.o $(EXEC)
