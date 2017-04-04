%{
#define YYSTYPE double
#include "./parser.h"
#ifdef CALC_LEX
    YYSTYPE yylval;
#endif
%}
%option noyywrap
%%
"+"                                  { return ADD;    } 
"-"                                  { return SUB;    } 
"*"                                  { return MUL;    } 
"/"                                  { return DIV;    } 
"("                                  { return OP;     }
")"                                  { return CP;     }
"|"                                  { return ABS;    } 
\n                                   { return EOL;    } 
[ t]                                 { /* ignore */   } 
([0-9]*\.?[0-9]+|[0-9]+\.[0-9]*)     { yylval = atof(yytext); return NUMBER; } 
%%


#ifdef CALC_LEX
int main(int argc, char** argv) {
    int token;
    printf("start");
    char* x = "(";
    while (token = yylex()) {
        printf("current %d", token);
        if (token == NUMBER) {
            printf(" = %f\n", yylval);
        } else {
            printf("other \n");
        }
    }
    return 0;
}
#endif 
