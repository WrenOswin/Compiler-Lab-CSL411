#include <stdio.h>
#include<string.h>
char string[20];
int w=0,error=0;
void E();
void Edash();
void T();
void Tdash();
void F();
/*
E -> E + T
E -> T
T -> T * F
T -> F
F -> (E) | d

after left recursion
E -> TE'
E' -> +TE' | ε
T -> FT'
T' -> *FT' | ε
F -> (E) | d
*/
int main()
{
    printf("Enter string: ");
    scanf("%s",string);
    E();
    if(error==0 && w==strlen(string))
        printf("success\n");
    else
        printf("failed\n");
    return 0;
}

void E(){
    T();
    Edash();
}
void Edash(){
    if(string[w]=='+'){
           w++;
           T();
           Edash();
    }
}

void T(){
    F();
    Tdash();
}

void Tdash(){
    if(string[w]=='*'){
           w++;
           F();
           Tdash();
    }
}
void F(){
    if(string[w]=='('){
        w++;
        E();
        if(string[w]==')'){
            w++;
        }
        else
            error=1;
    }
    else if(string[w]=='d'){
        w++;
    }
    else
        error=1;
}
