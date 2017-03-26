
CFLAGS = -std=c99 -Wall
TEST_CFLAGS = -Ideps

default: test
	./$<

test: CFLAGS+=$(TEST_CFLAGS)
test: test.o  decode.o 

clean:
	rm -f *.o test 

.PHONY: default clean
