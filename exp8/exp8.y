%{
	#include<stdlib.h>
	#include<string.h>
	#include<stdio.h>
	#include<math.h>
	#define YYSTYPE struct node*
	
	struct node
	{
		struct node *left;
		struct node *right;
		char token[10];
	};

	int yyerror(char *);
	struct node * mknode(struct node *,struct node *, char *);
	void makepostfix(struct node *);
	void printLevelOrder(struct node *);
	void printCurrentLevel(struct node *, int);
	int height(struct node*);
	void printpostfix(char postfixexp[50][50]);
	void evalpostfix(char postfixexp[50][50]);
	char postfixexp[50][50];
	int num = 0;
	int p = 0;
	int limit = 1;
	int h;
	int tabs;
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
line:exp	{
				printf("\nAbstract Syntax Tree: \n");
				printLevelOrder($1);
				makepostfix($1);
				printf("\nPostfix traversal and evaluation: \n");
				printpostfix(postfixexp);
				evalpostfix(postfixexp);
			}
exp:	exp'+'exp	{$$ = mknode($1,$3, "+");}
|	exp'-'exp	{$$ = mknode($1,$3, "-");}
|	exp'*'exp	{$$ = mknode($1,$3, "*");}
|	exp'/'exp	{$$ = mknode($1,$3, "/");}
|	'('exp')'	{$$ = $2;}
|	NUMBER	{$$ = mknode(NULL,NULL,(char *)yylval);}
%%
int main()
{
	printf("Enter expression: ");
	yyparse();
}	
struct node *mknode(struct node *left,struct node* right, char *ntoken)
{
	struct node *newnode = (struct node *)malloc(sizeof(struct node));
	newnode->left = left;
	newnode->right = right;
	strcpy(newnode->token, ntoken);
	return(newnode);
}
void printLevelOrder(struct node *root)
{
	h = height(root);
	tabs = 1;
	for(int j = 0; j < h-1; j++)
		tabs *= 2;
	
	int i;
	for(i = 1; i<=h; i++)
		printCurrentLevel(root, i);
}
void printCurrentLevel(struct node* root, int level)
{
	if(root==NULL)
	{
		for(int k = 0; k < tabs*2; k++)
			printf(" ");
		printf(" ");
		for(int k = 0; k < tabs*2-1; k++)
			printf(" ");
		num++;
		if(num == limit)
		{
			printf("\n\n");
			limit*=2;
			num = 0;
			tabs/=2;
		}
		return;
	}
	if(level == 1)
	{
		for(int k = 0; k < tabs*2; k++)
			printf(" ");
		printf("%s", root->token);
		for(int k = 0; k < tabs*2-1; k++)
			printf(" ");
		num++;
		if(num == limit)
		{
			printf("\n\n");
			limit*=2;
			num = 0;
			tabs/=2;
		}
	}
	else if(level > 1)
	{
		printCurrentLevel(root->left, level - 1);
		printCurrentLevel(root->right, level - 1);
	}
}

int height(struct node* node)
{
	if(node==NULL)
		return 0;
	else
	{
		int lheight = height(node->left);
		int rheight = height(node->right);
		if(lheight > rheight)
			return (lheight + 1);
		else
			return (rheight + 1);
	}
}
void makepostfix(struct node *tree)
{
	if(tree->left)
		makepostfix(tree->left);
	if(tree->right)
		makepostfix(tree->right);
	strcpy(postfixexp[p++], tree->token);
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
		while(strcmp(postfixexp[track], "+")!=0 && strcmp(postfixexp[track], "-")!=0 &&strcmp(postfixexp[track], "*")!=0 &&strcmp(postfixexp[track], "/")!=0)
			track++;
		strcpy(op, postfixexp[track]);
		arg1 = atoi(postfixexp[track-2]);
		arg2 = atoi(postfixexp[track-1]);
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
int yyerror(char *s)
{
	printf("\nInvalid");
}
