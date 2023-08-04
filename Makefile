

CC = gcc
CFLAGS = -m32 -masm=att

all: fizzbuzz

main: main.c Makefile
	$(CC) $(CFLAGS) -O0 -S -o $@.s $<  



fizzbuzz: fizzbuzz.S main
	$(CC) $(CFLAGS) -E $< -o $@_pp.s
	$(CC) $(CFLAGS) main.s $@_pp.s -o $@


clean:
	rm -rf *_pp.s fizzbuzz fizzbuzz.exe main.s
