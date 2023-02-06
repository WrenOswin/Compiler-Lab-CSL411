%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
%}

%%
"id"    {return ID;}
[ \t]   ;
\n      {return 0;}
.       {return yytext[0];}
%%

int yywrap(){
    return 1;
}