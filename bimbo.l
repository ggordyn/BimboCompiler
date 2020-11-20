%{
	#include "y.tab.h"
	#include <stdio.h>
%}

alpha [A-Za-z]
digit [0-9]

%%

[\t] ; //ignore whitespaces
{digit}+ {yyval=atoi(yytext); return INTEGER_VALUE;}
{alpha}({alpha}|{digit})* return ID; 
\"(\\.|[^"])*\" return TEXT;
"GREATER" return GT;
"LESSER" return LT;
"EQUAL" return EQ;
"NOT EQUAL" return NE;
"OR" return OR;
"AND" return AND;
"IF" return IF;
"ENDIF" return ENDIF;
\n {yylineno++; return NEWLINE};

. return yytext[0]; 
%%

int yywrap(void){
    return 1;
}
int main(void){
    yylex();
    return 0;
}
