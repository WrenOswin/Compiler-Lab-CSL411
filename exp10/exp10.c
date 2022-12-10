#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int ptr;
char s[200];
int A()
{
    int ret = ptr;
    if(s[ptr] == 'a')
    {
        ptr++;
        if(s[ptr] == 'b')
            return 1; 
        else 
        {
            ptr = ret;
            return 1;
        }
    }
    return 0;
}
int S()
{
    ptr = 0;
    if(s[ptr]=='c')
    {
        ptr++;
        if(A())
        {
            ptr++;
            if(s[ptr]=='d')
                return 1;
        }
    }
    return 0;
}
int main()
{
    printf("Enter string to parse: ");
    fgets(s, sizeof(s), stdin);
    int res = S();
    if(res)
    	printf("Successfully parsed\n");
    else
    	printf("Rejected string\n");
    return 0;
}

/*
S -> cAd
A -> ab | a
*/
