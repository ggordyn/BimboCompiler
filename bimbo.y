%{
#include <stdio.h>
int yylex();	//avoiding warnings
void yyerror(const char *s);

%}

%union{

  char* string;
  int number;
  int isNumber;
  int isString;

}
%define parse.error verbose
%token BIMBO; 
%token ASSIGNMENT; 
%token STRING_VAR;
%token INTEGER_VAR;
%token PLUS;
%token MINUS;
%token DIVIDED_BY;
%token MULTIPLICATION;
%token MODULO;
%token TRUE; 
%token FALSE; 
%token REPEAT; 
%token UNTIL; 
%token IF;
%token THENDO;
%token ELSE;
%token ENDIF;
%token GT;
%token LT;
%token EQ;
%token NE;
%token OR;
%token AND;
%token NOT;
%token CREATE;
%token FINALIZER;
%token TEXT;
%token PRINTNUM;
%token PRINTSTRING;
%token <string> VARIABLE_NAME;
%token <string> STRING;
%token <number> INTEGER;
%token END;
%type<string> STRING_ST
%start START;


%%
START: BEGIN STATEMENTS FINISH;

BEGIN: BIMBO {printf("int main (){");};
FINISH: END {printf("}");};


STATEMENTS: INSTRUCTION STATEMENTS | CONTROL STATEMENTS | {};

INSTRUCTION: DECLARATION FINALIZER 
| DECLARATION ASSIGN_STRING FINALIZER
| DECLARATION ASSIGN_NUM FINALIZER
| VARIABLE_NAME ASSIGN_STRING FINALIZER
| VARIABLE_NAME ASSIGN_NUM FINALIZER
| PRINT_NUM_ST FINALIZER
| PRINT_STRING_ST FINALIZER
| ASSIGN_STRING FINALIZER
| ASSIGN_NUM FINALIZER;


DECLARATION: CREATE DATATYPE VARIABLE_NAME;

ASSIGN_STRING: ASSIGNMENT_ST STRING;

ASSIGN_NUM: ASSIGNMENT_ST EXP;

ASSIGNMENT_ST: ASSIGNMENT{printf("=");};

DATATYPE: STRING_VAR_ST | INTEGER_VAR_ST;

STRING_VAR_ST: STRING_VAR {printf("char *");};

INTEGER_VAR_ST: INTEGER_VAR {printf("int");};

CONTROL: IFBLOCK | DOWHILE; 

IFBLOCK: IF_STATEMENT BOOLEXP THENDO_STATEMENT FINALIZER STATEMENTS ENDIF_STATEMENT FINALIZER
| IF_STATEMENT BOOLEXP THENDO_STATEMENT FINALIZER STATEMENTS FINALIZER ELSE_STATEMENT FINALIZER STATEMENTS ENDIF_STATEMENT FINALIZER;

IF_STATEMENT: IF {printf("if(");};

THENDO_STATEMENT: THENDO {printf("){");};

ENDIF_STATEMENT: ENDIF { printf("}"); };

ELSE_STATEMENT: ELSE {printf("}else{");};  

DOWHILE: REPEAT_ST FINALIZER STATEMENTS UNTIL_ST BOOLEXP ENDWHILE;

REPEAT_ST: REPEAT {printf("do{");};

UNTIL_ST: UNTIL {printf("}while(");};

ENDWHILE: {printf(");");};

PRINT_NUM_ST: PRINTNUM PRINTNUM_END {printf("printf(\"");};

PRINTNUM_END: VARIABLE_NAME FINALIZER {printf("%%d\", %s);", $1);};

PRINT_STRING_ST: PRINTSTRING PRINTSTRING_END{printf("printf(\"");};

PRINTSTRING_END: VARIABLE_NAME FINALIZER {printf("%%s\", %s);", $1);};
| STRING_ST FINALIZER {printf("%%s\", %s);", $1);};

STRING_ST: STRING{ $$ = $1; printf("%%s", $1);};

BOOLEXP: BOOLEXP OR_ST BOOLTERM | BOOLTERM;

BOOLTERM: BOOLTERM AND_ST BOOLFACT | BOOLFACT;

BOOLFACT: BOOLEXP | NOT_ST BOOLEXP | BOOLEAN;

BOOLEAN: FALSE_ST | TRUE_ST | COMPARISON;

TRUE_ST: TRUE {printf("1");};

FALSE_ST: FALSE {printf("0");};

COMPARISON: EXP OPERATOR EXP;

OPERATOR: LT_ST | GT_ST | EQ_ST | NE_ST;

EXP: EXP SUM_ST TERM | EXP MINUS_ST TERM | EXP MODULO_ST TERM | TERM;

TERM: TERM MUL_ST FACTOR | TERM DIV_ST FACTOR | TERM FACTOR | FACTOR;

FACTOR: VARIABLE_NAME | NUM_ST;

NUM_ST: INTEGER{printf("%%d", $1);};

OR_ST: OR{printf("||");};

AND_ST: AND{printf("&&");};

NOT_ST: NOT{printf("!");};

SUM_ST: PLUS{printf("+");};

MINUS_ST: MINUS{printf("-");};

MODULO_ST: MODULO{printf("%%");};

MUL_ST: MULTIPLICATION{printf("*");};

DIV_ST: DIVIDED_BY{printf("/");};

LT_ST: LT{printf("<");};

GT_ST: GT{printf(">");};

EQ_ST: EQ{printf("==");};

NE_ST: NE{printf("!=");};



%%

int yywrap()
{
        return 1;
} 

int main(void) {
    yyparse();
} 
