/*
    WAp to create a singly linked list to take address as an argument to perform operation
*/

#include<stdio.h>
#include<stdlib.h>
struct node
{
    int info;
    struct node* next;
};

struct node* list = NULL;

void insertnode(struct node* pred, int val)
{
    struct node* ins = (struct node*) malloc(sizeof(struct node));
    ins->info = val;
    ins->next = NULL;

    if(pred == NULL)
    {
        ins->next = list;
        list = ins;
       
    }
    else
    {
        ins->next = pred->next;
        pred->next = ins;
    }
    
}
void deletenode(struct node* del)
{
    if(del == list)
    {
        list = del->next;

    }
    else
    {
        struct node* pred = list;

        while (pred->next != del)
        {
            pred = pred->next;
        }

        pred->next = del->next;
    }

    free(del);
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

    insertnode(NULL, 7);
    insertnode(list, 10);
    insertnode(list, 16);
    display();
    deletenode(list->next);
    display();

}
