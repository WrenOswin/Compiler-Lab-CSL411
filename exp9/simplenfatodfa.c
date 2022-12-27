#include<stdio.h>
#include<string.h>
#include<stdlib.h>
struct transtab
{
    char state[10];
    char trans0[10];
    char trans1[10];
    int final;
}nfa[10], dfa[10];
int n, d, f, s;
void initializeNFAstates();
void inputNFAtransitions();
void printtable(struct transtab *, int);
void constructDFAtable();
int checkifnew(char *);
void addnewtransdfa(char *);
void sortandmakeunique(char *);
int main()
{
    printf("Enter number of states for NFA: ");
    scanf("%d", &n);
    initializeNFAstates();
    inputNFAtransitions();
    printf("NFA\n");
    printtable(nfa, n);
    constructDFAtable();
    printf("DFA\n");
    printtable(dfa, d);
}
void initializeNFAstates()
{
    char statecode = '0';
    for(int i = 0; i < n; i++)
    {
        char statename[10]="";
        strncat(statename, &statecode, 1);
        strcpy(nfa[i].state, statename);
        statecode++;
    }
}
void inputNFAtransitions()
{
    for(int i = 0; i < n; i++)
    {
        char s;
        char first[] = "", second[] = "";
        printf("Enter number of transitions for state %d on input 0: ", i);
        scanf("%d", &f);
        for(int j = 0; j < f; j++)
        {
            char s;
            printf("Enter transition %d: ", j + 1);
            scanf(" %c", &s);
            strncat(first, &s, 1);
        }
        sortandmakeunique(first);
        strcpy(nfa[i].trans0, first);

        printf("Enter number of transitions for state %d on input 1: ", i);
        scanf("%d", &s);
        for(int j = 0; j < s; j++)
        {
            char s;
            printf("Enter transition %d: ", j + 1);
            scanf(" %c", &s);
            strncat(second, &s, 1);
        }
        sortandmakeunique(second);
        strcpy(nfa[i].trans1, second);

        char choice;
        printf("Is state %d a final state? (y/n): ", i);
        scanf(" %c", &choice);
        if(choice == 'y' || choice == 'Y')
            nfa[i].final = 1;
        else    
            nfa[i].final = 0;
    }
}
void printtable(struct transtab *tab, int rows)
{
    for(int i = 0; i < rows; i++)
    {
        printf("%s\t%s\t%s", tab[i].state, tab[i].trans0, tab[i].trans1);
        if(tab[i].final == 1)
            printf("\t[FINAL]");
        printf("\n");
    }
}
void constructDFAtable()
{
    strcpy(dfa[0].state, nfa[0].state);
    strcpy(dfa[0].trans0, nfa[0].trans0);
    strcpy(dfa[0].trans1, nfa[0].trans1);
    d++;
    int i = 0;
    while(i < d)
    {
        if(checkifnew(dfa[i].trans0))
            addnewtransdfa(dfa[i].trans0);
        
        if(checkifnew(dfa[i].trans1))
            addnewtransdfa(dfa[i].trans1);
        i++;
    } 
}    
int checkifnew(char *s)
{
    for(int i = 0; i < d; i++)
    {
        if(strcmp(dfa[i].state, s)==0)
            return 0;
    }
    return 1;
}
void addnewtransdfa(char *state)
{
    char finaldfirst[] = "", finaldsecond[] = "";
    strcpy(dfa[d].state, state);
    for(int i = 0; i < strlen(state); i++)
    {
        for(int j = 0; j < n; j++)
        {
            if(strncmp(nfa[j].state, &state[i], 1)==0 && nfa[j].final == 1)
                dfa[d].final = 1;
        }
    }
    int found = 0;
    int k = 0;
    char temp;
    temp = dfa[d].state[k];
    while(temp!='\0')
    {
        int i = 0;
        while(strncmp(nfa[i].state, &temp, 1))
            i++;
        
        strcpy(finaldfirst, "");
        strcat(finaldfirst, nfa[i].trans0);
        strcat(dfa[d].trans0, finaldfirst);
        sortandmakeunique(dfa[d].trans0);

        strcpy(finaldsecond, "");
        strcat(finaldsecond, nfa[i].trans1);
        strcat(dfa[d].trans1, finaldsecond);
        sortandmakeunique(dfa[d].trans1);
        k++;
        temp = dfa[d].state[k];
    }
    d++;
}
void sortandmakeunique(char* s)
{
    char temporary[] = "";
    int k = 0;
    for(int i = 0; i < strlen(s); i++)
    {
        for(int j = 0; j < strlen(s) - i - 1; j++)
        {
            if(s[j] > s[j + 1])
            {
                char temp = s[j];
                s[j] = s[j + 1];
                s[j + 1] = temp;
            }
        }
    }
    int i = 0;
    char ch = ' ';
    while(s[i]!='\0')
    {
        char nch = s[i];
        if(nch != ch)
        {
            strncat(temporary, &nch, 1);
            ch = nch;
        }
        i++;
    }
    strcpy(s, temporary);
}