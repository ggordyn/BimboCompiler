%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
%%

int yywrap()
{
        return 1;
} 

main() {
    printf("Enter the expression:\n");
    yyparse();
} 