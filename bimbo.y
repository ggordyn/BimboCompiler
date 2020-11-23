%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "linkedList.h"
#define MAX_VARLENGTH 30


int yylex();	//avoiding warnings
void yyerror(const char *s);
int yydebug = 1;
llist * symbol_table;
char typeaux[10];
char typeout[10];
char aux[50];
char * tok;
%}

%union{

  char* string;
  int number;

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
%token MAXLENGTH;
%token <string> VARIABLE_NAME;
%token <string> STRING;
%token <number> INTEGER;
%token END;
%token READ;
%token INTO_SP;
%token INTO;
%token TEXTLIST;
%token ADD;
%token TOSTRINGLIST;
%token REMOVE;
%token FROMSTRINGLIST;
%token PRINTTEXTLIST;
%token TONUMBERLIST;
%token FROMNUMBERLIST;
%token NUMBERLIST;
%token STARTON;
%token SPACE;
%type<string> STRING_ST
%type<string> VARIABLE_NAME_S
%type<string> VARIABLE_NAME_F
%type<string> VARIABLE_NAME_CHECK
%type<string> VARIABLE_NAME_LIST
%type<string> VARIABLE_NAME_INTLIST
%type<string> VARIABLE_NAME_CHECKTEXTLIST
%type<string> VARIABLE_NAME_CHECKNUMBERLIST
%type<string> DATATYPE
%type<string> DECLARATION
%start START;


%%
START: BEGIN STATEMENTS FINISH;

BEGIN: BIMBO {printf("#include \"linkedList.h\"\n#include \"integerLinkedList.h\"\n");printf("int main (){");};
FINISH: END {printf("}");};


STATEMENTS: INSTRUCTION STATEMENTS | CONTROL STATEMENTS | {};

INSTRUCTION: DECLARATION FINALIZER_S
| DECLARATION ASSIGN_STRING FINALIZER_S
| DECLARATION ASSIGN_NUM FINALIZER_S
| VARIABLE_NAME_F ASSIGN_STRING FINALIZER_S
| VARIABLE_NAME_F ASSIGN_NUM FINALIZER_S 
| PRINT_NUM_ST FINALIZER_S
| PRINT_STRING_ST FINALIZER_S
| READ STRING_VAR MAXLENGTH INTEGER INTO_SP VARIABLE_NAME_CHECK FINALIZER {printf("%s\b = malloc(%d);", $6, $4 + 1);printf("scanf(\"%%s\", %s\b);", $6);}
| READ INTEGER_VAR INTO VARIABLE_NAME_CHECK FINALIZER {printf("scanf(\"%%d\", &%s\b);", $4);}
| ADD STRING TOSTRINGLIST VARIABLE_NAME_CHECKTEXTLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("llist_add_inorder(%s, %s\b, \"\");", tok, $4);
}
| ADD VARIABLE_NAME_CHECK TOSTRINGLIST VARIABLE_NAME_CHECKTEXTLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("llist_add_inorder(%s, %s\b, \"\");", tok, $4);
}
| REMOVE STRING FROMSTRINGLIST VARIABLE_NAME_CHECKTEXTLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("llist_remove(%s, %s\b);", tok, $4);
}
| REMOVE VARIABLE_NAME_CHECK FROMSTRINGLIST VARIABLE_NAME_CHECKTEXTLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("llist_remove(%s, %s\b);", tok, $4);
}

| PRINTTEXTLIST VARIABLE_NAME_CHECKTEXTLIST FINALIZER{
	printf("llist_print(%s);", $2);
}
| ADD INTEGER TONUMBERLIST VARIABLE_NAME_CHECKNUMBERLIST FINALIZER{
	
	printf("intllist_add_inorder(%d, %s\b);", $2, $4);
}
| ADD VARIABLE_NAME_CHECK TONUMBERLIST VARIABLE_NAME_CHECKNUMBERLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("intllist_add_inorder(%s, %s\b);", tok, $4);
}
| REMOVE INTEGER FROMNUMBERLIST VARIABLE_NAME_CHECKNUMBERLIST FINALIZER{
	printf("intllist_remove(%d, %s\b);", $2, $4);
}
| REMOVE VARIABLE_NAME_CHECK FROMNUMBERLIST VARIABLE_NAME_CHECKNUMBERLIST FINALIZER{
	strcpy(aux, $2);
	tok = strtok(aux, " ");
	printf("intllist_remove(%s, %s\b);", tok, $4);
}


VARIABLE_NAME_CHECK: VARIABLE_NAME {
	int found = 0;
	if(llist_search(symbol_table, $1, typeout)){
		found = 1;
	}
	if(!found){
		yyerror("undefined variable");
		fprintf(stderr, "Be careful! Variable '%s' does not exist!\n", $1);
		
		system("rm output.c");
		YYABORT;
	}
};

VARIABLE_NAME_CHECKTEXTLIST: VARIABLE_NAME {
	int found = 0;
	if(llist_search(symbol_table, $1, typeout)){
		found = 1;
	}
	if(!found){
		yyerror("undefined variable");
		fprintf(stderr, "Be careful! Variable '%s' does not exist!\n", $1);
		
		system("rm output.c");
		YYABORT;
	}else if(strcmp(typeout, "TEXTLIST") != 0){
		yyerror("Invalid list");
		fprintf(stderr, "Be careful! Variable '%s' is not a text list!\n", $1);
		system("rm output.c");
		YYABORT;
	}
}
VARIABLE_NAME_CHECKNUMBERLIST: VARIABLE_NAME {
	int found = 0;
	if(llist_search(symbol_table, $1, typeout)){
		found = 1;
	}
	if(!found){
		yyerror("undefined variable");
		fprintf(stderr, "Be careful! Variable '%s' does not exist!\n", $1);
		
		system("rm output.c");
		YYABORT;
	}else if(strcmp(typeout, "INTLIST") != 0){
		yyerror("Invalid list");
		fprintf(stderr, "Be careful! Variable '%s' is not a number list!\n", $1);
		system("rm output.c");
		YYABORT;
	}
}
VARIABLE_NAME_F: VARIABLE_NAME {
	int found = 0;
	if(llist_search(symbol_table, $1, typeout)){
		found = 1;
	}
	if(found){
		printf("%s", $1);
	}	
	else{
		yyerror("undefined variable");
		fprintf(stderr, "Be careful! Variable '%s' does not exist!\n", $1);
		
		system("rm output.c");
		YYABORT;
	}
};


DECLARATION: CREATE DATATYPE VARIABLE_NAME_S {
if(strlen($3) >= MAX_VARLENGTH){
	fprintf(stderr, "Be careful! Variable name '%s' is way too long!\n", $3);
	yyerror("Symbol table error");
}
else{
	if(llist_search(symbol_table, $3, typeout)){
		yyerror("re-definition of variable");
		fprintf(stderr, "Be careful! Variable '%s' was already defined\n", $3);
		system("rm output.c");
		YYABORT;	
	}
	else{
		strcpy(typeaux, $2);
		llist_add_inorder($3, symbol_table, typeaux);
	}
}
$$ = $3;
}
|CREATE TEXTLIST VARIABLE_NAME_LIST{
	if(strlen($3) >= MAX_VARLENGTH){
	fprintf(stderr, "Be careful! Variable name '%s' is way too long!\n", $3);
	yyerror("Symbol table error");
}
else{
	if(llist_search(symbol_table, $3, typeout)){
		yyerror("re-definition of variable");
		fprintf(stderr, "Be careful! Variable '%s' was already defined\n", $3);
		system("rm output.c");
		YYABORT;	
	}
	else{
		strcpy(typeaux, "TEXTLIST");
		llist_add_inorder($3, symbol_table, typeaux);
	}
}
printf("=llist_create(NULL)");
}
|CREATE NUMBERLIST VARIABLE_NAME_INTLIST STARTON INTEGER{
	if(strlen($3) >= MAX_VARLENGTH){
	fprintf(stderr, "Be careful! Variable name '%s' is way too long!\n", $3);
	yyerror("Symbol table error");
}
else{
	if(llist_search(symbol_table, $3, typeout)){
		yyerror("re-definition of variable");
		fprintf(stderr, "Be careful! Variable '%s' was already defined\n", $3);
		system("rm output.c");
		YYABORT;	
	}
	else{
		strcpy(typeaux, "INTLIST");
		strcpy(aux, $3);
		strtok(aux, " ");
		llist_add_inorder(aux, symbol_table, typeaux);
	}
	printf("=intllist_create(%d)", $5);
}
}|CREATE NUMBERLIST VARIABLE_NAME_INTLIST STARTON VARIABLE_NAME_CHECK{
	if(strlen($3) >= MAX_VARLENGTH){
	fprintf(stderr, "Be careful! Variable name '%s' is way too long!\n", $3);
	yyerror("Symbol table error");
}
else{
	if(llist_search(symbol_table, $3, typeout)){
		yyerror("re-definition of variable");
		fprintf(stderr, "Be careful! Variable '%s' was already defined\n", $3);
		system("rm output.c");
		YYABORT;	
	}
	else{
		strcpy(typeaux, "INTLIST");
		strcpy(aux, $3);
		strtok(aux, " ");
		llist_add_inorder(aux, symbol_table, typeaux);
	}
	printf("=intllist_create(%s)", $5);
}
};

ASSIGN_STRING: ASSIGNMENT_ST STRING_ST;

ASSIGN_NUM: ASSIGNMENT_ST EXP;

ASSIGNMENT_ST: ASSIGNMENT{printf("=");};

FINALIZER_S: FINALIZER {printf(";");};

DATATYPE: STRING_VAR {$$ = "TEXT"; printf("char *");}
| INTEGER_VAR {$$ = "NUMBER"; printf("int ");};


CONTROL: IFBLOCK | DOWHILE; 

VARIABLE_NAME_S: VARIABLE_NAME {$$ = $1, printf("%s", $$);};

VARIABLE_NAME_LIST: VARIABLE_NAME {$$ = $1, printf("llist * %s", $$);};
VARIABLE_NAME_INTLIST: VARIABLE_NAME {$$ = $1, printf("intllist * %s", $$);};


IFBLOCK: IF_STATEMENT BOOLEXP THENDO_STATEMENT STATEMENTS ENDIF_STATEMENT
| IF_STATEMENT BOOLEXP THENDO_STATEMENT STATEMENTS ELSE_STATEMENT STATEMENTS ENDIF_STATEMENT;

IF_STATEMENT: IF {printf("if(");};

THENDO_STATEMENT: THENDO {printf("){");};

ENDIF_STATEMENT: ENDIF { printf("}"); };

ELSE_STATEMENT: ELSE {printf("}else{");};  

DOWHILE: REPEAT_ST STATEMENTS UNTIL_ST BOOLEXP ENDWHILE;

REPEAT_ST: REPEAT {printf("do{");};

UNTIL_ST: UNTIL {printf("}while(");};

ENDWHILE: FINALIZER {printf(");");};

PRINT_NUM_ST: PRINTNUM_S PRINTNUM_END;

PRINTNUM_S: PRINTNUM {printf("printf(\"");}

PRINTNUM_END: VARIABLE_NAME {printf("%%d\", %s)", $1);};

PRINT_STRING_ST: PRINTSTRING_S PRINTSTRING_END;

PRINTSTRING_S: PRINTSTRING {printf("printf(");}

PRINTSTRING_END: VARIABLE_NAME {printf("\"%%s\", %s)", $1);};
| STRING_ST {printf(")");};

STRING_ST: STRING{ printf($1);};

BOOLEXP: BOOLEXP OR_ST BOOLTERM | BOOLTERM | NOT_ST BOOLEXP;

BOOLTERM: BOOLTERM AND_ST BOOLFACT | BOOLFACT;

BOOLFACT: BOOLEXP | BOOLEAN;

BOOLEAN: FALSE_ST | TRUE_ST | COMPARISON;

TRUE_ST: TRUE {printf("1");};

FALSE_ST: FALSE {printf("0");};

COMPARISON: EXP OPERATOR EXP;

OPERATOR: LT_ST | GT_ST | EQ_ST | NE_ST;

EXP: EXP SUM_ST TERM | EXP MINUS_ST TERM | EXP MODULO_ST TERM | TERM;

TERM: TERM MUL_ST FACTOR | TERM DIV_ST FACTOR | TERM FACTOR | FACTOR;

FACTOR: VARIABLE_NAME_F | NUM_ST;

NUM_ST: INTEGER{printf("%d", $1);};

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
	symbol_table = llist_create("");
    yyparse();
    free(symbol_table);
} 
