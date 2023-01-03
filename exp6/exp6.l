%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"    
%}

%%
[0-9]+                  {return INTEGER;}   
[a-zA-Z][a-zA-Z0-9]*    {return IDENTIFIER;}                                          
[ \t]                   ;
[\n]                    {return 0;}
.                       {return yytext[0];}
%%

int yywrap()
{
    return 1;
}
