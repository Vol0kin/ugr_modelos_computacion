
all: lex.yy.cc compyler

lex.yy.cc: compyler.l
	flex compyler.l

compyler: lex.yy.c
	gcc -o compyler lex.yy.c 

clean:
	rm compyler *.c
