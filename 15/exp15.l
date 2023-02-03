%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "y.tab.h"
%}

%%
"a" {return A;}
"b" {return B;}
[ \t] ;
[\n] {return 0;}
. {return 0;}
%%

int yywrap(){
    return 1;
}