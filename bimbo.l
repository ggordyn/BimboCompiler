%{
	#include "y.tab.h"
	#include <stdlib.h>
	#include <strings.h>
%}

NEWLINE "\n"
INTEGER [-]?[0-9]+
START "BIMBO"
STRING ["][^\n\r]*[""]
INTEGER_VAR "NUMBER"
STRING_VAR "TEXT"
VARIABLE_NAME [a-zA-Z]+[0-9a-zA-Z]*
ASSIGNMENT " IS "
PRINTNUM "PRINT NUMBER: "
PRINTSTRING "PRINT TEXT: "
END "}"
PLUS " PLUS "
MINUS " MINUS "
DIVIDED_BY " DIVIDED BY "
MULTIPLICATION " TIMES "
MODULO " MODULO "
CREATE "CREATE "
%%

"BIMBO{ " return BIMBO; //program start
{END} return END;
[\t] ; //ignore whitespaces

{VARIABLE_NAME} {yylval.string = yytext; return VARIABLE_NAME;}	//name of variable in creation

{INTEGER} {yylval.number=atoi(yytext); return INTEGER;}	
{STRING} {yylval.string = yytext; return STRING;}	

{INTEGER_VAR} return INTEGER_VAR;	//integer datatype
{STRING_VAR} return STRING_VAR;	//string datatype

{ASSIGNMENT} return ASSIGNMENT; //value assignment
"CREATE " return CREATE; //variable creation

{PLUS} return PLUS;
{MINUS} return MINUS;
{DIVIDED_BY} return DIVIDED_BY;
{MULTIPLICATION} return MULTIPLICATION;
{MODULO} return MODULO;
"TRUE" return TRUE;	//boolean values
"FALSE" return FALSE;

{PRINTNUM} return PRINTNUM; //printing
{PRINTSTRING} return PRINTSTRING;
" GREATER THAN " return GT; //operators
" LESSER THAN " return LT;
" EQUAL TO " return EQ;
" NOT EQUAL TO " return NE;
" OR " return OR;
" AND " return AND;
"NOT " return NOT;

"IF " return IF;	//if statements
" THEN DO" return THENDO;
"ELSE" return ELSE;
"ENDIF" return ENDIF;

"REPEAT" return REPEAT;	//do while
"UNTIL " return UNTIL;

{NEWLINE} {yylineno++; return NEWLINE;};

. {fprintf(stderr, "Invalid operation found\n");}; 
%%
