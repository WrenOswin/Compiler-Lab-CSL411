%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<ctype.h>
    int nlines = 0, nwords = 0, nchars = 0;
%}

%%
\n          {nchars++;nlines++;}
[^ \n\t]+   {nwords++, nchars=nchars+yyleng;}
.           {nchars++;}
%%

int yywrap()
{
    nchars++;
    nlines++;
    return 1;
}
int main()
{
    yyin = fopen("input", "r");
    yylex();
    printf("No: of lines = %d\nNo: of words = %d\nNo: of chars = %d\n", nlines, nwords, nchars);
    return 0;
}

/*INPUT
num1 = 10
num2 = num1
*/

/*OUTPUT
No: of lines = 2
No: of words = 6
No: of chars = 22
*/
