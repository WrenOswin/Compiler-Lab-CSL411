%{
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%
[0-9]+ {yylval = (int)yytext; return INTEGER;}
[ \t] {}
[\n]  {return 0;}
.     {return yytext[0];}
%%

int yywrap (void)
{
  return 1;
} 