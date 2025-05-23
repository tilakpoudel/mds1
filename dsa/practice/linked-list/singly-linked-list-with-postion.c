
/*
    WAP to implement singly linked list taking position to perform the operation
*/

#include<stdio.h>
#include<stdlib.h>

struct node
{
	int info;
	struct node* next;
};

struct node* list = NULL;

void insertnode(int pos, int val) 
{
    // TODO: [TP: 2025-03-08] Count the number of nodes inserted and check before operation(deletion)
	struct node* ins = (struct node*) malloc(sizeof(struct node));
	ins->info = val;
	ins->next = NULL;

	if(pos == 1)
	{
		ins->next = list;
		list = ins;
	}
	else
	{
		struct node* pred = list;

		for(int i = 1; i < pos - 1; i++) {
			pred = pred->next;
        }

	    ins->next = pred->next;
	    pred->next = ins;
	}	
}

void deletenode(int pos)
{
	if(pos == 1) 
	{
		list  = list->next;
	}
	else
	{
		struct node* pred, *del = list;

		for(int i = 1; i < pos; i++)
		{
			pred = del;
			del = del->next;
		}

		pred->next = del->next;
		free(del);
	}
}

void display() 
{
	struct node* temp = list;

	while(temp != NULL) 
	{
        printf("%d\t", temp->info);
        temp = temp->next;
   	}

   	printf("\n");
}

int main()
{
	int choice, pos, val;

	while(1)
	{
		printf("------MENU------\n");
		printf("1. Insert\n");
		printf("2. Delete\n");
		printf("3. Display\n");
		printf("4. Clear\n");
		printf("5. Exit\n");
		printf("Enter a choice (1-5):");
		scanf("%d", &choice);

		switch(choice)
		{
			case 1:
				printf("Enter pos:");
				scanf("%d", &pos);
				printf("Enter value:");
				scanf("%d", &val);
				insertnode(pos, val);

                break;
			case 2:
				printf("Enter pos:");
				scanf("%d", &pos);
				deletenode(pos);

                break;
			case 3:
				printf("Elements in the linked list:\n");
				display();

                break;
			case 4:
				system("clear");

                break;
			case 5:
				exit(0);
			default:
				printf("Wrong choice");
		}
	}
}
