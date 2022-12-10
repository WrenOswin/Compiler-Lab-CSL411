#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct NFAstate
{
	int* to0;
	int* to1;
	int num0, num1;
	int isFinal;
};

struct NFA
{
	struct NFAstate* q;
	int num;
};

struct DFAstate
{
	char* name;
	struct DFAstate* next;
};

struct QUEUE
{
	struct DFAstate* front;
	struct DFAstate* back;
};
void initqueue(struct QUEUE *queue)
{
	queue->front = queue->back = NULL;
}
void enqueue(struct QUEUE *queue, char* state)
{
	if(queue->front == NULL)
	{
		queue->front = queue->back = malloc(sizeof(struct DFAstate));
		queue->front->next = NULL;
		queue->front->name = malloc(sizeof(state) + 1);
		strcpy(queue->front->name, state);
	}
	else
	{
		struct DFAstate* newstate = malloc(sizeof(struct DFAstate));
		newstate->name = malloc(sizeof(state) + 1);
		strcpy(newstate->name, state);
		queue->back->next = newstate;
		newstate->next = NULL;
		queue->back = newstate;
	}	
}
char* dequeue(struct QUEUE* queue)
{
	if(queue->front == NULL)
		return NULL;
	char* name = malloc(sizeof(queue->front->name) + 1);
	strcpy(name, queue->front->name);
	struct DFAstate* state = queue->front;
	queue->front = queue->front->next;
	free(state);
	return name;
}
int isEmpty(struct QUEUE queue)
{
	if(queue.front == NULL)
		return 1;
	else
		return 0;
}
struct LL
{
	struct DFAstate* front;
	struct DFAstate* back;
};
void initll(struct LL* ll)
{
	ll->front = ll->back = NULL;
}
void push(struct LL* ll, char* name)
{
	if(ll->front == NULL)
	{
		ll->front = ll->back = malloc(sizeof(struct DFAstate));
		ll->front->next = NULL;
		ll->front->name = malloc(sizeof(name) + 1);
		strcpy(ll->front->name, name);
	}
	else
	{
		struct DFAstate* newstate = malloc(sizeof(struct DFAstate));
		newstate->name = malloc(sizeof(name) + 1);
		strcpy(newstate->name, name);
		newstate->next = NULL;
		ll->back->next = newstate;
		ll->back = newstate;
	}
}
int find(struct LL ll, char* name)
{
	struct DFAstate* iter = ll.front;
	while(iter != NULL)
	{
		if(strcmp(iter->name, name) == 0)
			return 1;
		iter = iter->next;
	}
	return 0;
}

int main()
{
	struct NFA nfa;
	int NUMSTATES;
	printf("Number of states : ");
	scanf("%d", &NUMSTATES);
	nfa.q = malloc(NUMSTATES * sizeof(struct NFAstate));
	nfa.num = NUMSTATES;

	for(int i = 0; i < NUMSTATES; ++i)
	{
		printf("State q%d : \n", i);
		printf("Transitions : input(0)\n");
		printf("Number of transitions : ");
		scanf("%d", &nfa.q[i].num0);
		nfa.q[i].to0 = malloc(nfa.q[i].num0 * sizeof(int));
		for(int j = 0; j < nfa.q[i].num0; ++j)
		{
			printf("Transition %d : ", j);
			scanf("%d", &nfa.q[i].to0[j]);
		}
		printf("Transitions : input(1)\n");
		printf("Number of transitions : ");
		getchar();
		scanf("%d", &nfa.q[i].num1);
		nfa.q[i].to1 = malloc(nfa.q[i].num1 * sizeof(int));
		for(int j = 0; j < nfa.q[i].num1; ++j)
		{
			printf("Transition %d : ", j);
			scanf("%d", &nfa.q[i].to1[j]);
		}
		printf("Final? (y/n) : ");
		char c;
		getchar();
		scanf("%c", &c);
		nfa.q[i].isFinal = (c == 'y') ? 1 : 0;
	}

	struct QUEUE queue;
	initqueue(&queue);
	struct LL statelist;
	initll(&statelist);
	char initialname[2];
	initialname[0] = '0';
	initialname[1] = '\0';
	enqueue(&queue, initialname);
	push(&statelist, initialname);
	printf("DFA Transition table : \n");
	while(!isEmpty(queue))
	{
		int isFinal = 0;
		char name[100];
		strcpy(name, dequeue(&queue));
		if(find(statelist, name) == 0)
		{
			push(&statelist, name);
		}
		printf("[");
		for(int i = 0; name[i] != '\0'; ++i)
		{
			printf("q%c", name[i]);
			if(nfa.q[name[i] - '0'].isFinal == 1)
				isFinal = 1;
		}
		printf("]\t");
		int newstatesize = 0;
		for(int i = 0; name[i] != '\0'; ++i)
			newstatesize += nfa.q[name[i] - '0'].num0;
		
		char* newstatename = malloc(sizeof(char) * newstatesize + 1);
		int chariter = 0;
		for(int i = 0; name[i] != '\0'; ++i)
		{
			for(int j = 0; j < nfa.q[name[i] - '0'].num0; ++j)
			{
				int found = 0;
				for(int k = 0; k < chariter; ++k)
				{
					if(nfa.q[name[i] - '0'].to0[j] == newstatename[k] - '0')
					{
						found = 1;
						break;
					}
				}
				if(!found)
					newstatename[chariter++] = nfa.q[name[i] - '0'].to0[j] + '0';
			}
		}
		newstatename[chariter] = '\0';
		if(!find(statelist, newstatename))
		{
			enqueue(&queue, newstatename);
		}
		printf("[");
		for(int i = 0; newstatename[i] != '\0'; ++i)
			printf("q%c", newstatename[i]);
		
		printf("]\t");
		
		newstatesize = 0;
		for(int i = 0; name[i] != '\0'; ++i)
			newstatesize += nfa.q[name[i] - '0'].num1;
		
		free(newstatename);
		newstatename = malloc(sizeof(char) * newstatesize + 1);
		chariter = 0;
		for(int i = 0; name[i] != '\0'; ++i)
		{
			for(int j = 0; j < nfa.q[name[i] - '0'].num1; ++j)
			{
				int found = 0;
				for(int k = 0; k < chariter; ++k)
				{
					if(nfa.q[name[i] - '0'].to1[j] == newstatename[k] - '0')
					{
						found = 1;
						break;
					}
				}
				if(!found)
					newstatename[chariter++] = nfa.q[name[i] - '0'].to1[j] + '0';
			}
		}
		newstatename[chariter] = '\0';
		if(!find(statelist, newstatename))
			enqueue(&queue, newstatename);
		
		printf("[");
		for(int i = 0; newstatename[i] != '\0'; ++i)
			printf("q%c", newstatename[i]);
		printf("]");
		
		if(isFinal)
			printf("\t*FINAL STATE*\n");
		else
			printf("\n");
	}
	return 0;
}

/*INPUT
Number of states : 3
State q0 : 
Transitions : input(0)
Number of transitions : 1
Transition 0 : 0
Transitions : input(1)
Number of transitions : 2
Transition 0 : 0
Transition 1 : 1
Final? (y/n) : n
State q1 : 
Transitions : input(0)
Number of transitions : 0
Transitions : input(1)
Number of transitions : 1
Transition 0 : 2
Final? (y/n) : n
State q2 : 
Transitions : input(0)
Number of transitions : 0
Transitions : input(1)
Number of transitions : 0
Final? (y/n) : y

OUTPUT
DFA Transition table : 
[q0]	[q0]	[q0q1]
[q0q1]	[q0]	[q0q1q2]
[q0q1q2]	[q0]	[q0q1q2]	*FINAL STATE*
*/
