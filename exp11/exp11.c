#include<stdio.h>
#include<stdlib.h>
#include<string.h>
char str[15],stack[15];
int w=0, top=0;
char act[15];
void check();
int main()
{
	printf("\n GRAMMAR\n");
	printf("\n E->E+E\n E->E/E");
	printf("\n E->E*E\n E->a|b");
	printf("\n Enter the input string:");
	scanf("%s", str);
	printf("\n stack \t\t input symbol\t\t action");
	printf("\n________\t ____________\t\t ______\n");
	printf("\n$\t\t %s$\t\t\t--", str);
	while(w < strlen(str))
	{
		strcpy(act, "shift ");
		strncat(act, &str[w], 1);
		stack[top] = str[w];
		stack[top+1] = '\0';
		str[w] = ' ';
		w++;             
		printf("\n$%s\t\t%s$\t\t\t%s", stack, str, act);
		check();
		top++;
	}
	check();
	return 0;
}
void check()
{
	int flag = 0;
	if(stack[top] == 'a')
	{
		stack[top]='E';
		printf("\n$%s\t\t%s$\t\t\tE->a", stack, str);
		flag = 1;
	}

	if(stack[top] == 'b')
	{
		stack[top]='E';
		printf("\n$%s\t\t%s$\t\t\tE->b", stack, str);
		flag = 1;
	}

	if(stack[top] == '+' || stack[top] == '*' || stack[top] == '/')
		flag = 1;
	
	if(!strcmp(stack, "E+E"))
	{
		strcpy(stack, "E");
		top = 0;
		printf("\n$%s\t\t%s$\t\t\tE->E+E", stack, str);
		flag = 1;
	}

	if(!strcmp(stack, "E/E"))
	{
		strcpy(stack, "E");
		top = 0;
		printf("\n$%s\t\t%s$\t\t\tE->E/E", stack, str);
		flag = 1;
	}

	if(!strcmp(stack, "E*E"))
	{
		strcpy(stack, "E");
		top = 0;
		printf("\n$%s\t\t%s$\t\t\tE->E*E", stack, str);
		flag = 1;
	}
	
	if(!strcmp(stack, "E") && w==strlen(str))
	{
		strcpy(stack, " ");
		printf("\n$$%s\t\t%s\t\t\tACCEPT\n", stack, str);
		exit(0);
	}

	if(flag == 0)
	{
		printf("\n%s\t\t%s\t\t\tREJECT\n", stack, str);
		exit(0);                
	}
	return;
}
