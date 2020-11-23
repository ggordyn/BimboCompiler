SCANNER = bimbo.l
PARSER = bimbo.y
BIMBO = bimbo.out

.PHONY: clean

all:
	yacc -d $(PARSER)
	lex $(SCANNER)
	gcc -o bimbo.out lex.yy.c y.tab.c linkedList.c integerLinkedList.c -ly
	@echo "BIMBO COMPILATION DONE"

tests:
	./$(BIMBO) < Examples/HelloWorld.bimbo > Examples/HelloWorld.c
	gcc -w Examples/HelloWorld.c -o HelloWorld.out
	./$(BIMBO) < Examples/multiples.bimbo > Examples/multiples.c
	gcc -w Examples/multiples.c -o multiples.out
	./$(BIMBO) < Examples/gcd.bimbo > Examples/gcd.c
	gcc -w Examples/gcd.c -o gcd.out
	./$(BIMBO) < Examples/textList.bimbo > Examples/textList.c
	gcc -w Examples/textList.c Examples/linkedList.c -o textList.out
	./$(BIMBO) < Examples/numberList.bimbo > Examples/numberList.c
	gcc -w Examples/numberList.c Examples/integerLinkedList.c -o numberList.out
clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h