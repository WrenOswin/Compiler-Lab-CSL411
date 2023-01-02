%{
    #include<stdio.h>
    #include<stdlib.h>
%}

%%
"abc" {
        yytext[0] = 'A';
        yytext[1] = 'B';
        yytext[2] = 'C';
        printf("%s", yytext);
        }

.   {printf("%s", yytext);}   
%%

int main()
{
    printf("Enter string: ");
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