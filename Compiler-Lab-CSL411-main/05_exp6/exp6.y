%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *);
    extern FILE* yyin;
%}

%token INTEGER IDENTIFIER 
%left '+' '-'                                 
%left '*' '/'

%%
expr: expr'-'expr
    |expr'+'expr   
    |expr'*'expr 
    |expr'/'expr                                    
    |'-'expr
    |'('expr')'
    |INTEGER
    |IDENTIFIER
    ;
%%

int main()
{   
    //printf("Enter expression: ");
    yyin = fopen("input.txt", "r"); 
    yyparse();
    printf("\nExpression is valid\n");
    return 0;
}

int yyerror(char *s)
{
    printf("\nExpression is invalid");
    exit(0);
}


//flex exp6.l
//bison -dy exp6.y
//gcc lex.yy.c y.tab.c 
