/*
S -> aSbb | e
Grammar for number of a's, followed by double number of b's
*/
#include<stdio.h>
#include<string.h>
#include<ctype.h>
int S();
char string[50];
int i=0;

int main()
{
    printf("Enter string: ");
    scanf("%s",string);
    if(S() && i==strlen(string))
        printf("Accepted\n");
    else
        printf("Rejected\n");
    return 0;
}
int S(){
    if(string[i]=='a')
    {
        i++;
        S();
        if(string[i]=='b')
        {
            i++;
            if(string[i]=='b')
            {
                i++;
                return 1;
            }  
            else
                return 0;
        }
        else
            return 0;
    }
    else
        return 0;
}
