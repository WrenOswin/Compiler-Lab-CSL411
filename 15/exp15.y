%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    int yyerror(char *);
    int yylex();
%}

%token A B

%%
S: A S B | ;
%%

int main(){
    printf("Enter expression: ");
    yyparse();
    printf("Valid expression");
    return 1;
}

int yyerror(char *s){
    printf("Invalid\n");
    exit(0);
}