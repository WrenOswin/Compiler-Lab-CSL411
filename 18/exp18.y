%{
    /* Definition section */
    #include <stdio.h>
    #include <stdlib.h>
    extern char* yytext;
    int yylex();
    int yyerror(char *);
    void A1();
    void A2();
    void A3();
    char stack[100];
    int top=0;
%}
  
%token    ID
%left    '+' '-'
%left    '*' '/'

%%
  
line  :  expr
expr  :  expr'+'{A1();}expr{A2();}
   |  expr'-'{A1();}expr{A2();}
   |  expr'*'{A1();}expr{A2();}
   |  expr'/'{A1();}expr{A2();}
   |  '('expr{A2();}')'
   |  ID{A3();}
   ;
%%
  
//driver code
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
void A1()
{
    stack[top++]=yytext[0];
}
  
void A2()
{
    printf("%c", stack[--top]);
}
  
void A3()
{
    printf("%s ", yytext);
}