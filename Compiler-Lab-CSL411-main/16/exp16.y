%{
    //hex calc
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    extern char * yytext;
    int yyerror(char *);
    int yylex();
    int res;
%}

%token INTEGER
%left '+' '-'
%left '*' '/'

%%
final: expr{res = $$;}
expr: expr'+'expr {$$=$1+$3;}
    | expr'-'expr {$$=$1-$3;}
    | expr'*'expr {$$=$1*$3;}
    | expr'/'expr {$$=$1/$3;}
    | INTEGER {$$=$1;}
%%

int main(){
    printf("Enter expression: ");
    yyparse();
    printf("Valid Expression\n");
    printf("Result decimal= %d\n",res);
    printf("Result hex= %X\n",res);
    return 1;
}

int yyerror(char *s){
    printf("Invalid expression\n");
    exit(0);
}