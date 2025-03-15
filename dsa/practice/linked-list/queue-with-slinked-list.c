/*
Program to implement queue using linked list
*/
#include<stdio.h>
#include<stdlib.h>
#define TRUE 1

struct node
{
	int info;
	struct node *next;
};

// Create two pointers front and rear
// Dequeue from front and enqueue from rear
struct node *front = NULL, *rear = NULL;

int isempty() 
{
	return front == NULL ? 1 : 0;
}

void enqueue(int val) 
{
	struct node* ins = (struct node*) malloc(sizeof(struct node));

    ins->info = val;
	ins->next = NULL;

    // insert at the rear when queue not empty
    if (rear != NULL)
		rear->next = ins;
	else
		front = ins;

    rear = ins;
}

void peek() 
{
	if(isempty()) 
   		 printf("Queue is empty.\n");  
   	else 
   		 printf("Front element is %d\n", front->info); 	
}

void dequeue() 
{
	if(isempty())
		printf("Queue is empty.\n");
	else
	{
		struct node *temp = front;
		printf("Removed element is %d\n", front->info);
		front = front->next;

		if(front == NULL)
			rear = NULL;

        free(temp);
	}		
}

int main() 
{
	int choice, val;

	while(TRUE)
	{
		printf("-----Menu-----\n");
		printf("1. Enqueue\n");
		printf("2. Dequeue\n");
		printf("3. Peek\n");
		printf("4. Clear\n");
		printf("5. Exit\n");
		printf("Enter a choice (1-5):");
		scanf("%d", &choice);

		switch(choice)
		{
			case 1:
				printf("Enter value to insert:");
				scanf("%d", &val);
				enqueue(val);

                break;
			case 2:
				dequeue();

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
				printf("Wrong choice!\n");
		}
	}
}
