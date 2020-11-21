SCANNER = bimbo.l
PARSER = bimbo.y
PARSER_RESULT = bimbo.out

.PHONY: clean

all:
	yacc -d $(PARSER)
	lex $(SCANNER)
	gcc -o $(PARSER) lex.yy.c y.tab.c -ly
	@echo "BIMBO COMILATION DONE"

clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h