#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<fcntl.h>
#include<ctype.h>
#include<unistd.h>

int main()
{
	char buffer[1000];
	int file_desc, char_count, flag = 0;
	file_desc = open("input", O_RDONLY);
	char_count = read(file_desc, buffer, 1000);
	buffer[char_count] = '\0';
	char keywords[20][100] = {"if", "for", "scanf", "printf", "while", "int", "char", "float"};

	for(int i = 0; buffer[i]!='\0'; i++)
	{
		if(buffer[i] == ' ' || buffer[i] == '\n')
			continue;
		else if(isdigit(buffer[i]))
		{
			int j = 0;
			char number[10];
			while(isdigit(buffer[i]))
			{
				number[j] = buffer[i];
				j++;
				i++;
			}
			i--;
			number[j] = '\0';
			printf("NUMERIC:\t%s\n", number);
		}
		else if(isalpha(buffer[i]))
		{
			flag = 0;
			int j = 0;
			char identifier[10];
			while(isalnum(buffer[i]))
			{
				identifier[j] = buffer[i];
				j++;
				i++;
			}
			i--;
			identifier[j] = '\0';
			for(int c = 0; c < 8; c++)
			{
				if(strcmp(keywords[c], identifier) == 0)
				{
					printf("KEYWORD:\t%s\n", identifier);
					flag = 1;
				}

			}
			if(flag == 0)
				printf("IDENTIFIER:\t%s\n", identifier);
		}
		else if(buffer[i] == '/' && buffer[i+1] == '/')
		{
			while(buffer[i]!='\n')
				i++;
		}
		else if(buffer[i] == '/' && buffer[i+1] == '*')
		{
			i+=2;
			while(buffer[i]!='*' && buffer[i+1]!='/')
				i++;
			i++;
		}
		else if(buffer[i] == '+' || buffer[i] == '-' ||buffer[i] == '*' ||buffer[i] == '/' ||buffer[i] == '=')
			printf("OPERATOR:\t%c\n", buffer[i]);
		else
			printf("SPECIAL SYMBOL:\t%c\n", buffer[i]);	
	}
	close(file_desc);
	return 0;
}

/*INPUT FILE
int a = 8;
int b = 10;
a + b = 18; //comment
//this is a comment
*/

/*OUTPUT
KEYWORD:	int
IDENTIFIER:	a
OPERATOR:	=
NUMERIC:	8
SPECIAL SYMBOL:	;
KEYWORD:	int
IDENTIFIER:	b
OPERATOR:	=
NUMERIC:	10
SPECIAL SYMBOL:	;
IDENTIFIER:	a
OPERATOR:	+
IDENTIFIER:	b
OPERATOR:	=
NUMERIC:	18
SPECIAL SYMBOL:	;
*/
