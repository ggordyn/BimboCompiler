%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <strings.h>
%}

NEWLINE "\n"
INTEGER [-]?[0-9]+
START "BIMBO"
STRING ["][^\n\r]*[""]
NUMBER_VAR "NUMBER"
STRING_VAR "TEXT"
VARIABLE_NAME [a-zA-Z]+[0-9a-zA-Z]*
ASSIGNMENT " IS "
PRINT "SAY: "
END "}"
%%

"BIMBO{ " return BIMBO; //program start
{END} return END;
[\t] ; //ignore whitespaces

{VARIABLE_NAME} {yylval.string = yytext; return VARIABLE_NAME;}	//name of variable in creation

{INTEGER} {yyval.number=atoi(yytext); return INTEGER;}	
{STRING} {yyval.string = yytext; return STRING}	

{NUMBER_VAR} return NUMBER_VAR;	//integer datatype
{STRING_VAR} return STRING_VAR;	//string datatype

{ASSIGNMENT} return ASSIGNMENT; //value assignment
"CREATE " return CREATE; //variable creation


"TRUE" return TRUE;	//boolean values
"FALSE" return FALSE;

{PRINT} return PRINT; //printing

" GREATER " return GT; //operators
" LESSER " return LT;
" EQUAL " return EQ;
" NOT EQUAL " return NE;
" OR " return OR;
" AND " return AND;


"IF " return IF;	//if statements
" THEN DO " THENDO;
"ENDIF" return ENDIF;

"REPEAT " return REPEAT;	//do while
"UNTIL " return UNTIL;

{NEWLINE} {yylineno++; return NEWLINE};

. {fprintf(stderr, "Invalid operation found\n");}; 
%%

int yywrap(void){
    return 1;
}
int main(void){
    yylex();
    return 0;
}
