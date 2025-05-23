#include<stdio.h>
#include<stdlib.h>
#define TRUE 1

int a[10] = {NULL};

int hash(int k)
{
	return k % 10;
}

int hash2(int k)
{
	return 7 - (k % 7);
}

void insert(int k)
{
	int i = hash(k), index;
	for(int j = 0; j < 10; j++)
	{
		index = (i + j * hash2(k)) % 10;

		if(a[index]==NULL)
		{
			a[index] = k;
			break;
		}
	}	
}

int search(int k)
{
	int i = hash(k), index;

	for(int j = 0; j < 10; j++)
	{
		index = (i + j) % 10;
		if(a[index]==k)
		{
			return index;
		}
	}
	return -1;	
}

void del(int k)
{
	int i = hash(k), index;

	for(int j = 0; j < 10; j++)
	{
		index = (i + j) % 10;

		if(a[index]==k)
		{
			a[index]=NULL;

			break;
		}
	}	
}

int main()
{
	int choice, val, i;

	while(TRUE)
	{
		printf("-----Menu-----\n");
		printf("1. Insert\n");
		printf("2. Delete\n");
		printf("3. Search\n");
		printf("4. Clear\n");
		printf("5. Exit\n");
		printf("Enter a choice (1-5):");
		scanf("%d", &choice);

		switch(choice)
		{
			case 1:
				printf("Enter value to insert:");
				scanf("%d", &val);
				insert(val);

				break;
			case 2:
				printf("Enter value to delete:");
				scanf("%d", &val);
				del(val);

				break;
			case 3:
				printf("Enter value to search:");
				scanf("%d", &val);
				i = search(val);

				if(i == -1)
					printf("Not found\n");
				else
					printf("Found %d at index %d\n", val, i);

				break;
			case 4:
				system("clear");

				break;
			case 5:
				exit(0);
			default:
				printf("Wrong choice\n");
		}
	}
}