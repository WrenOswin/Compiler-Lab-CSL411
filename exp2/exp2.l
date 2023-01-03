%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<ctype.h>
%}

ID [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]+
OP [-+*<>/=]
comment "//".*

%%
"if"            {printf("<KEYWORD, %s>\n", yytext);} 
"then"          {printf("<KEYWORD, %s>\n", yytext);} 
"else"          {printf("<KEYWORD, %s>\n", yytext);} 
"for"           {printf("<KEYWORD, %s>\n", yytext);} 
"while"         {printf("<KEYWORD, %s>\n", yytext);} 
"int"           {printf("<KEYWORD, %s>\n", yytext);}
"float"         {printf("<KEYWORD, %s>\n", yytext);}
{ID}            {printf("<IDENTIFIER, %s>\n", yytext);}
{DIGIT}         {printf("<NUMERIC, %s>\n", yytext);}
{OP}            {printf("<OPERATOR, %s>\n", yytext);}
{comment}       {}
[ \t\n]         {}
.               {printf("<SPECIAL CHARACTER, %s>\n", yytext);}
%%

int yywrap()
{
    return 1;
}
int main()
{
    yyin = fopen("input.txt", "r");
    yylex();
    return 0;
}


/*INPUT FILE
int a = 5;
int b = 10;
a = b   //comment 1
val = a < b
//this is last comment
*/

/*OUTPUT
<KEYWORD, int>
<IDENTIFIER, a>
<OPERATOR, =>
<NUMERIC, 5>
<;>
<KEYWORD, int>
<IDENTIFIER, b>
<OPERATOR, =>
<NUMERIC, 10>
<;>
<IDENTIFIER, a>
<OPERATOR, =>
<IDENTIFIER, b>
*/