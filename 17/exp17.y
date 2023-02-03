%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    int yyerror(char *);
    int yylex();
    char* printRow(char operand1[20] ,char operand2[20] , char);
    char temp='A'-1;
    char t[20];
%}

%token INTEGER IDENTIFIER
%left '+' '-'
%left '*' '/'
%union{
    char sym[20];
}

%%
final: IDENTIFIER '=' expr{printRow($<sym>1,$<sym>3,'=');}
expr: expr'+'expr {strcpy($<sym>$,printRow($<sym>1,$<sym>3,'+'));}
    | expr'-'expr {strcpy($<sym>$,printRow($<sym>1,$<sym>3,'-'));}
    | expr'*'expr {strcpy($<sym>$,printRow($<sym>1,$<sym>3,'*'));}
    | expr'/'expr {strcpy($<sym>$,printRow($<sym>1,$<sym>3,'/'));}
    | INTEGER {strcpy($<sym>$,$<sym>1);}
    | IDENTIFIER {strcpy($<sym>$,$<sym>1);};
%%

int main(){
    printf("Enter expression: ");
    yyparse();
    return 0;
}

int yyerror(char *s){
    printf("Error");
    exit(0);
}

char* printRow(char operand1[20],char operand2[20],char op){
    temp++;
    printf("%c := %s %c %s\n",temp,operand1,op,operand2);
    sprintf(t,"%c",temp);
    return t;
}

/*
Enter expression: a=b*c+1/3-5*f
A := b * c
B := 1 / 3
C := A + B
D := 5 * f
E := C - D
F := a = E
*/
