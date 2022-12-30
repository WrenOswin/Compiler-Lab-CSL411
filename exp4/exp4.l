%{
    #include<stdio.h>
    #include<stdlib.h>
%}

%%
"abc"   {
            yytext[0] = 'A';
            yytext[1] = 'B';
            yytext[2] = 'C';
            printf("%s", yytext);
        }

.   {printf("%s", yytext);}   
%%

int main()
{
    FILE *finput = fopen("input", "r");
    yyin = finput;
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

/*INPUT
abdabcss
*/

/*OUTPUT
abdABCss
*/