%{
    #include<stdio.h>
    #include<stdlib.h>
    int vowels = 0, consonants = 0;
%}

%%
[aeiouAEIOU]   {vowels++;}
[a-zA-Z]    {consonants++;}
.   {}
%%

int yywrap(){   return 1;   }
int main()
{
    yyin = fopen("input", "r");
    yylex();
    printf("No: of vowels = %d\nNo: of consonants = %d\n", vowels, consonants);
    return 0;
}

/*INPUT
a = b   #comment 1
b = 10
while
#this is last comment
*/

/*OUTPUT
No: of vowels = 10
No: of consonants = 22
*/