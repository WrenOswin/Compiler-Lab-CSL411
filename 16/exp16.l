%{
    /*hex calc*/
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%
[0-9]+  {yylval=atoi(yytext);return INTEGER;}
0x[0-9A-F]+   {yylval=(int)strtol(yytext, NULL, 16);return INTEGER;}
[ \t]   ;
[\n]    {return 0;}
.   {return yytext[0];}
%%

int yywrap(){
    return 1;
}
