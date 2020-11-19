#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     NUM = 259,
     DW = 260,
     LT = 261,
     GT = 262,
     EQ = 263,
     NE = 264,
     OR = 265,
     AND = 266,
     ASSIGN = 267,
     IF = 268,
     NEWLINE = 269;
   };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define DW 260
#define LT 261
#define GT 262
#define EQ 263
#define NE 264
#define OR 265
#define AND 266
#define ASSIGN 267
#define IF 268
#define NEWLINE 269




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;