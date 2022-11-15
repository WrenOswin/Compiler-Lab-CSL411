%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>

	typedef struct node
	{
		struct node *left;
		struct node *right;
		char *token;
	}node;

	int yyerror(char *);
	node *mknode(node *left, node *right, char *token);
	void makepostfix(node *tree);
	void printLevelOrder(node *root);
	void printCurrentLevel(node* root, int level);
	int height(node* node);
	char postfixexp[50][50];
	void printpostfix(char postfixexp[50][50]);
	void evalpostfix(char postfixexp[50][50]);
	#define YYSTYPE struct node*
	int num = 0;
	int p = 0;
	int limit = 1;
	int h;
	int tabs = 4;
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%% 
line: exp 		{ 	
					printf("\nAbstract syntax tree:\n");
 					printLevelOrder($1);
   					makepostfix($1);
					printf("\nPostfix traversal and evaluation: \n");
    				printpostfix(postfixexp);
					evalpostfix(postfixexp);
				}

exp :  exp'+'exp 	{$$ = mknode($1, $3, "+");}
| exp'-'exp 	{$$ = mknode($1, $3, "-");}
| exp'*'exp 	{$$ = mknode($1, $3, "*");}
| exp'/'exp 	{$$ = mknode($1, $3, "/");}
| '('exp')'		{$$ = $2;}
| NUMBER 		{$$ = mknode(NULL,NULL,(char *)yylval);}
;

%%

int main () 
{
	printf("Enter expression: ");
	return yyparse();
}

node *mknode(node *left, node *right, char *token)
{ 	
	node *newnode = (node *)malloc(sizeof(node));
	char *newstr = (char *)malloc(strlen(token)+1);
	strcpy(newstr, token);
	newnode->left = left;
	newnode->right = right;
	newnode->token = newstr;
	return(newnode);
}

void makepostfix(node *tree)
{
	if(tree->left)
		makepostfix(tree->left);
	if(tree->right)
		makepostfix(tree->right);
	strcpy(postfixexp[p++], tree->token);
}

void printLevelOrder(node* root)
{
    h = height(root);
    int i;
    for (i = 1; i <= h; i++)
        printCurrentLevel(root, i);
}
 
void printCurrentLevel(node* root, int level)
{
    if (root == NULL)
	{
		for(int k = 0; k <= tabs; k++)
			printf(" ");
        printf("N");
		for(int k = 0; k < tabs/2; k++)
			printf("  ");
		num++;
		if(num == limit)
		{
			printf("\n\n");
			limit*=2;
			num = 0;
			tabs--;
		}
		return;
	}
    if (level == 1)
	{
		for(int k = 0; k <= tabs; k++)
			printf(" ");
        printf("%s", root->token);
		for(int k = 0; k < tabs/2; k++)
			printf("  ");
		num++;
		if(num == limit)
		{
			printf("\n\n");
			limit*=2;
			num = 0;
			tabs--;
		}
	}
    else if (level > 1) {
        printCurrentLevel(root->left, level - 1);
        printCurrentLevel(root->right, level - 1);
    }
}
 

int height(node* node)
{
    if (node == NULL)
        return 0;
    else {
        int lheight = height(node->left);
        int rheight = height(node->right);
        if (lheight > rheight)
            return (lheight + 1);
        else
            return (rheight + 1);
    }
}

void printpostfix(char postfixexp[50][50])
{
	strcpy(postfixexp[p], "END");
	printf("\n");
	for(int i = 0; strcmp(postfixexp[i], "END")!=0; i++)
		printf(" %s ", postfixexp[i]);
	printf("\n");
}

void evalpostfix(char postfixexp[50][50])
{
	char op[5];
	int arg1, arg2, res;
	int track = 0;
	while(strcmp(postfixexp[1], "END")!=0)
	{
		while(strcmp(postfixexp[track], "+")!=0 && strcmp(postfixexp[track], "-")!=0 && strcmp(postfixexp[track], "*")!=0 && strcmp(postfixexp[track], "/")!=0)
			track++;
		strcpy(op, postfixexp[track]);
		arg1 = atoi(postfixexp[track-2]);
		arg2 = atoi(postfixexp[track -1]);
		if(strcmp(op, "+")==0)
			res = arg1 + arg2;
		else if(strcmp(op, "-")==0)
			res = arg1 - arg2;
		else if(strcmp(op, "*")==0)
			res = arg1 * arg2;
		else if(strcmp(op, "/")==0)
			res = arg1 / arg2;
		sprintf(postfixexp[track-2], "%d", res);
		int temp = track;
		track-=2;
		while(strcmp(postfixexp[temp], "END")!=0)
		{
			strcpy(postfixexp[temp-1], postfixexp[temp+1]);
			temp++;
		}
		printpostfix(postfixexp);
	}
	return;
}
int yyerror (char *s) 
{
	printf("\ninvalid");
	exit(0);
}