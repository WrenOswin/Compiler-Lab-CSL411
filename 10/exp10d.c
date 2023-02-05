/*
S -> aS'
S' -> S+S' | S*S' | e

eg. a
    aa+
    aaa++
    aa+a*
*/
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
char input[20];
int ptr=0,error=0;
void S();
void Sdash();

int main(){
    printf("Enter string: ");
    scanf("%s",input);
    S();
    if(ptr==strlen(input) && error==0)
        printf("Success\n");
    else 
        printf("Failed\n");
}

void S(){
    if(input[ptr]=='a'){
        ptr++;
        Sdash();
    }
    else
        error = 1;
}

void Sdash(){
    if(input[ptr]=='a'){
        S();
        if(input[ptr]=='+' || input[ptr]=='*'){
            ptr++;
            Sdash();
        }
        else
            error=1;
    }
}
