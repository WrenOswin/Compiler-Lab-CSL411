%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
%}

%%
[0-9]+  {strcpy(yylval.sym,strdup(yytext)); return INTEGER;}
[a-zA-Z][a-zA-Z0-9]*    {strcpy(yylval.sym,strdup(yytext)); return IDENTIFIER;}
[ \t]   ;
[\n]    {return 0;}
. {return yytext[0];}
%%

int yywrap(){
    return 1;
}