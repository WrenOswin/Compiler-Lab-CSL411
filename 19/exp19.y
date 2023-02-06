%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    int yylex();
    int yyerror(char *);
    char stack[100] = "";
    int top = -1;
%}

%token ID
%left '+' '-'
%left '*'

%%
E: E'+'{strcat(stack,"+"); top++; printf("%s\t\tshift +\n",stack);}E{top-=2; stack[top+1]='\0';printf("%s\t\tE->E+E\n",stack);}
 | E'-'{strcat(stack,"-"); top++; printf("%s\t\tshift -\n",stack);}E{top-=2; stack[top+1]='\0';printf("%s\t\tE->E-E\n",stack);}
 | E'*'{strcat(stack,"*"); top++; printf("%s\t\tshift *\n",stack);}E{top-=2; stack[top+1]='\0';printf("%s\t\tE->E*E\n",stack);}
 | ID{strcat(stack,"id"); top+=2; printf("%s\t\tshift id\n",stack); stack[top--]='\0'; stack[top]='E'; printf("%s\t\tE->id\n",stack);};
%%

int main(){
    printf("Enter string: ");
    yyparse();
    printf("ACCEPT\n");
    return 1;
}

int yyerror(char *s){
    printf("REJECT\n");
    exit(0);
}

/*
Enter string: id+id*id
id              shift *
E               E->id
E+              shift +
E+id            shift *
E+E             E->id
E+E*            shift *
E+E*id          shift *
E+E*E           E->id
E+E             E->E*E
E               E->E+E
ACCEPT
*/
