/*
Program to implement stack using linked list
*/

#include<stdio.h>
#include<stdlib.h>
#define TRUE 1

struct node
{
	int info;
	struct node *next;
};

struct node *top = NULL;

int isempty()
{
	return top == NULL ? 1 : 0;
}

void push(int val)
{
	struct node* ins = (struct node*) malloc(sizeof(struct node));

	ins->info = val;
	ins->next = top;
	top = ins;		
}

void peek() 
{
	if(isempty()) 
   		 printf("Stack is empty.\n");  
   	else 
   		 printf("Topmost element is %d\n", top->info); 	
}

void pop() 
{
	if(isempty()) 
		printf("Stack is empty.\n");
   	else
	{
		struct node *temp = top;
		printf("Removed element is %d\n", temp->info);

        top = top->next;

        free(temp);			
	}		
}
int main() 
{
	int choice, val;

	while(TRUE)
	{
		printf("-----Menu-----\n");
		printf("1. Push\n");
		printf("2. Pop\n");
		printf("3. Peek\n");
		printf("4. Clear\n");
		printf("5. Exit\n");
		printf("Enter a choice (1-5):");
		scanf("%d", &choice);

		switch(choice)
		{
			case 1:
				printf("Enter value to push:");
				scanf("%d", &val);
				push(val);
				break;
			case 2:
				pop();
				break;
			case 3:
				peek();
				break;
			case 4:
				system("clear");
				break;
			case 5:
				exit(0);
			default:
				printf("Wrong choice!");
		}
	}
}

