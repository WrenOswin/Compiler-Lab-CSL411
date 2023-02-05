%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "y.tab.h"
%}

ALPHA [A-Z a-z]
DIGIT [0-9]
  
/* Rule Section */
%%
{ALPHA}({ALPHA}|{DIGIT})*     return ID;
{DIGIT}+    return ID;
[ \t]       ;
\n          return 0;
.           return yytext[0];
%%

int yywrap(){
    return 1;
}