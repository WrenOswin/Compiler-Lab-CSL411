%{
    #include <stdio.h>
    #include <stdlib.h>
    extern char* yytext;
    int yylex();
    int yyerror(char *);
    void push(char c);
    void pop();
    void printc();
    char stack[100];
    int top=-1;
%}
  
%token ID
%left '+' '-'
%left '*' '/'

%%  
expr  :  expr'+'expr{push('+');pop();}
   |  expr'-'expr{push('-');pop();}
   |  expr'*'expr{push('*');pop();}
   |  expr'/'expr{push('/');pop();}
   |  '('expr')'{pop();}
   |  ID{printc();}
   ;
%%
  
int main()
{
    printf("Enter infix expression:  "); 
    yyparse();
    printf("\n");
    return 0;
}
int yyerror(char *s){
    printf("Error\n");
    exit(0);
}
void push(char c)
{
    stack[++top]=c;
}
void pop()
{
    printf("%c ", stack[top--]);
} 
void printc()
{
    printf("%s ", yytext);
}
