%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<math.h>
    #define YYSTYPE struct node*

    struct node
    {
        struct node* left;
        struct node* right;
        char token[10];
    };

    int yyerror(char *);
    struct node* mknode(struct node*, struct node*, char*);
    void printLevelOrder(struct node*);
    void printCurrentLevel(struct node*, int);
    int height(struct node*);
    void makepostfix(struct node*);
    void printpostfix(char postfixexp[50][50]);
    void evalpostfix(char postfixexp[50][50]);
    
    char postfixexp[50][50];
    int p = 0, limit = 1;
    int tabs, num;

%}

%token INTEGER
%left '+' '-'
%left '*' '/'

%%
line: expr{
        printLevelOrder($1);
        makepostfix($1);
        printpostfix(postfixexp);
        evalpostfix(postfixexp);
}

expr: expr'+'expr {$$ = mknode($1, $3, "+");}
|   expr'-'expr   {$$ = mknode($1, $3, "-");}
|   expr'*'expr   {$$ = mknode($1, $3, "*");}
|   expr'/'expr   {$$ = mknode($1, $3, "/");}
|   '('expr')'     {$$ = $2;}
|   INTEGER         {$$ = mknode(NULL, NULL, (char*)yylval);}
%%

int main()
{
    printf("Enter arithmetic expression: ");
    yyparse();
}

struct node* mknode(struct node* left, struct node* right, char* token)
{
    struct node* newnode = (struct node*)malloc(sizeof(struct node));
    newnode->left = left;
    newnode->right = right;
    strcpy(newnode->token, token);
    return newnode;
}

void printLevelOrder(struct node* root)
{
    int h = height(root);
    tabs = 1;
    for(int i = 0; i < h-1; i++)
        tabs *= 2;
    
    for(int i = 1; i <= h; i++)
        printCurrentLevel(root, i);
}

int height(struct node* root)
{
    if(root == NULL)
        return 0;
    else
    {
        int lheight = height(root->left);
        int rheight = height(root->right);
        if(lheight > rheight)
            return (lheight + 1);
        else    
            return (rheight + 1);
    }
}

void printCurrentLevel(struct node* root, int level)
{
    if(root == NULL)
    {
        for(int i = 0; i < tabs*2; i++)
            printf(" ");
        printf(" ");
        for(int i = 0; i < (tabs*2)-1; i++)
            printf(" ");
        num++;
        if(num == limit)
        {
            printf("\n\n");
            num = 0;
            limit *= 2;
            tabs/=2;
        }
        return;
    }
    if(level == 1)
    {
        for(int i = 0; i < tabs*2; i++)
            printf(" ");
        printf("%s", root->token);
        for(int i = 0; i < (tabs*2)-1; i++)
            printf(" ");
        num++;
        if(num == limit)
        {
            printf("\n\n");
            num = 0;
            limit *= 2;
            tabs/=2;
        } 
    }
    else if(level > 1)
    {
        printCurrentLevel(root->left, (level - 1));
        printCurrentLevel(root->right, (level - 1));
    }
}

void makepostfix(struct node* root)
{
    if(root->left)
        makepostfix(root->left);
    if(root->right)
        makepostfix(root->right);
    strcpy(postfixexp[p++], root->token);
}

void printpostfix(char postfixexp[50][50])
{
	printf("\n");
	int i = 0;
    while(strcmp(postfixexp[i], "\0")!=0)
    {
        printf("%s ", postfixexp[i]);
		i++;
    }
}

void evalpostfix(char postfixexp[50][50])
{
    strcpy(postfixexp[p], "\0");
    int k = 0;
    int arg1, arg2, res;
    while(strcmp(postfixexp[1], "\0")!=0)
    {
        while(strcmp(postfixexp[k], "+")!=0 && strcmp(postfixexp[k], "-")!=0 && strcmp(postfixexp[k], "*")!=0 && strcmp(postfixexp[k], "/")!=0)
            k++;
        arg1 = atoi(postfixexp[k-2]);
        arg2 = atoi(postfixexp[k-1]);
        if(strcmp(postfixexp[k],"+")==0)
            res = arg1 + arg2; 
        if(strcmp(postfixexp[k],"-")==0)
            res = arg1 - arg2;
        if(strcmp(postfixexp[k],"*")==0)
            res = arg1 * arg2;
        if(strcmp(postfixexp[k],"/")==0)
            res = arg1 / arg2;  
        sprintf(postfixexp[k-2], "%d", res);
        int temp = k;
        k-=2;
        while(strcmp(postfixexp[temp], "\0")!=0)
        {
            strcpy(postfixexp[temp-1], postfixexp[temp+1]);
            temp++;
        } 
        printpostfix(postfixexp);
    }
}
int yyerror(char *s)
{
    printf("\nInvalid");
}