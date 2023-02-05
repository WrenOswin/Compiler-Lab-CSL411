%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #define YYSTYPE struct node*
    #define COUNT 10
    struct node
    {
        struct node* left;
        struct node* right;
        char token[10];
        int res;
    };
    int yylex();
    int yyerror(char *);
    struct node* mknode(struct node*, struct node*, char *, int);
    void printAST(struct node* root, int space);
%}

%token INTEGER
%left '+' '-'
%left '*' '/'

%%
line: expr{printAST($1, 0);}
expr: expr'+'expr {$$ = mknode($1, $3, "+",1);}
|   expr'-'expr   {$$ = mknode($1, $3, "-",1);}
|   expr'*'expr   {$$ = mknode($1, $3, "*",1);} 
|   expr'/'expr   {$$ = mknode($1, $3, "/",1);}
|   '('expr')'     {$$ = $2;}
|   INTEGER         {$$ = mknode(NULL, NULL, (char*)$1,0);}
%%

int main()
{
    printf("Enter arithmetic expression: ");
    yyparse();
}

struct node* mknode(struct node* left, struct node* right, char* token, int f)
{
    struct node* newnode = (struct node*)malloc(sizeof(struct node));
    newnode->left = left;
    newnode->right = right;
    newnode->res = atoi(token);
    strcpy(newnode->token,token);
    if(f==1){
        if(!strcmp(token,"+"))
            printf("%d + %d = %d\n",left->res,right->res,newnode->res=left->res+right->res);
        else if(!strcmp(token,"-"))
            printf("%d - %d = %d\n",left->res,right->res,newnode->res=left->res-right->res);
        else if(!strcmp(token,"*"))
            printf("%d * %d = %d\n",left->res,right->res,newnode->res=left->res*right->res);
        else
            printf("%d / %d = %d\n",left->res,right->res,newnode->res=left->res/right->res);
    }
    return newnode;
}

void printAST(struct node* root, int space)
{
    if (root == NULL)
        return;

    space += COUNT;
 
    printAST(root->right, space);

    printf("\n");
    for (int i = COUNT; i < space; i++)
        printf(" ");
        
    printf("%s\n", root->token);
 
    printAST(root->left, space);
}

int yyerror(char *s){
    printf("Invalid\n");
    exit(0);
}
