%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *);
    int Result;
%}

%token INTEGER IDENTIFIER 
%left '+' '-'                                 
%left '*' '/'


%%
Final:  expr{Result = $$;}
expr: expr'-'expr   {$$ = $1 - $3;}
    |expr'+'expr    {$$ = $1 + $3;}
    |expr'*'expr    {$$ = $1 * $3;}
    |expr'/'expr    {$$ = $1 / $3;}                               
    |'-'expr        {$$ = -$2;}
    |'('expr')'     {$$ = $2;}
    |INTEGER        {$$ = $1;}
    ;
%%

int main()
{   
    printf("Enter expression: ");
    yyparse();
    printf("\nExpression is valid\n");
    printf("\nResult = %d", Result);
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
