/*
L -> SL'
L' -> ,SL'| e
S -> a

eg. a,a,a
*/
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
char input[20];
int ptr=0,error=0;
void L();
void Ldash();
void S();

int main(){
    printf("Enter string: ");
    scanf("%s",input);
    L();
    if(ptr==strlen(input) && error==0)
        printf("Success\n");
    else 
        printf("Failed\n");
}

void L(){
    S();
    Ldash();
}

void Ldash(){
    if(input[ptr]==','){
        ptr++;
        S();
        Ldash();
    }
}

void S(){
    if(input[ptr]=='a'){
        ptr++;
    }
    else
        error=1;
}
