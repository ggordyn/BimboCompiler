SCANNER = bimbo.l
PARSER = bimbo.y
PARSER_RESULT = bimbo.out

.PHONY: clean

all:
	yacc -d $(PARSER)
	lex $(SCANNER)
	gcc -o bimbo.out lex.yy.c y.tab.c linkedList.c -ly
	@echo "BIMBO COMILATION DONE"

clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h