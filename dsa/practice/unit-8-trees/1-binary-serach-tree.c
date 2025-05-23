// # Binary search tree
// # Binary search tree is a data structure that stores elements in a sorted order.
// # It allows for efficient searching, insertion, and deletion of elements.
// # The binary search tree is a binary tree where each node has at most two children.
// # The left child of a node contains only nodes with values less than the node's value.
// # The right child of a node contains only nodes with values greater than the node's value.
// # The left and right subtree each must also be a binary search tree.
// # The binary search tree is a dynamic data structure that can grow and shrink as needed.
// # The binary search tree is a recursive data structure.
// # The binary search tree is a self-balancing data structure that maintains its balance by performing rotations.

// # Operations on binary search tree
// 1. Search
// 2. Insert
// 3. Delete
// 4. Traversal
// 5. Find minimum
// 6. Find maximum
// 7. Find height
// 8. Find depth
// 9. Find level
// 10. Find size
// 11. Find diameter
// 12. Find balance factor
// 13. Find ancestor
// 14. Find successor
// 15. Find predecessor

#include <stdio.h>
#include <stdlib.h>
struct node
{
	int info;
	struct node *left, *right;
};
struct node *root = NULL;
int depth = 0;

struct node *search(int val) 
{

	struct node *curr = root;
	for(;;)
	{
		if(curr == NULL)
			return NULL;
		if(val == curr->info)
			return curr;
		else if(val < curr->info)
			curr = curr->left;
		else
			curr = curr->right;
            depth++;
	}
}
void insert(int val) 
{
	struct node *ins = (struct node*) malloc(sizeof(struct node));
	ins->info = val;
	ins->left = NULL;
	ins->right = NULL;

	if(root == NULL)
		root = ins;
	else
	{
		struct node *parent = NULL, *curr = root;
		while(curr != NULL)
		{
			parent = curr;
			if(ins->info < curr->info)
				curr = curr->left;
			else if(ins->info > curr->info)
				curr = curr->right;	
			else
				return;				
		}
		if(ins->info < parent->info)
			parent->left = ins;
		else
			parent->right = ins;		
	}
}
void del(int val) 
{
	struct node *parent = NULL, *curr = root;
	while(curr->info != val)
	{
		parent = curr;
		if(val < curr->info)
			curr = curr->left;
		else
			curr = curr->right;					
	}
	if(curr->left == NULL && curr->right == NULL)
	{
		if(parent == NULL)
		{
			root = NULL;
			free(curr);
		}
		else
		{
			if(curr->info < parent->info)
				parent->left = NULL;
			else
				parent->right = NULL;
			free(curr);
		}
	}
	else if(curr->left == NULL && curr->right != NULL)
	{
		if(parent == NULL)
		{
			root = curr->right;
			free(curr);
		}
		else
		{
			if(curr->info < parent->info)
				parent->left = curr->right;
			else
				parent->right = curr->right;
			free(curr);
		}		
	}
	else if(curr->left != NULL && curr->right == NULL)
	{
		if(parent == NULL)
		{
			root = curr->left;
			free(curr);
		}
		else
		{
			if(curr->info < parent->info)
				parent->left = curr->left;
			else
				parent->right = curr->left;
			free(curr);
		}		
	}
	else
	{
		struct node *leftmost = curr->right, *pre = curr;
		while(leftmost->left != NULL)
		{
			pre = leftmost;
			leftmost = leftmost->left;			
		}
		curr->info = leftmost->info;
		if(leftmost->info < pre->info)
			pre->left = leftmost->right;
		else
			pre->right = leftmost->right;
		free(leftmost);
	}		
}
void preorder(struct node *n) 
{
	if (n != NULL)
	{		
		printf("%d ", n->info);
		preorder(n->left);
    	preorder(n->right);
  	}
}
void inorder(struct node *n) 
{
	if (n != NULL)
	{
		inorder(n->left);
		printf("%d ", n->info);
    	inorder(n->right);
  	}
}
void postorder(struct node *n) 
{
	if (n != NULL)
	{
		postorder(n->left);		
    	postorder(n->right);
    	printf("%d ", n->info);
  	}
}
int main()
{
	int c, n;
	while(1)
	{
		printf("1. Insert\n");
		printf("2. Delete\n");
		printf("3. Search\n");
		printf("4. Preorder Traversal\n");
		printf("5. Inorder Traversal\n");
		printf("6. Postorder Traversal\n");
		printf("7. Clear\n");
		printf("8. Exit\n");
		printf("Enter choice:");
		scanf("%d", &c);
		switch(c)
		{
			case 1:
				printf("Enter value to insert:");
				scanf("%d", &n);
				insert(n);
				break;
			case 2:
				printf("Enter value to delete:");
				scanf("%d", &n);
				del(n);
				break;
			case 3:
				printf("Enter value to serach:");
				scanf("%d", &n);
				if(search(n) == NULL)
					printf("Not found\n");
				else
					printf("Found at depth %d\n", depth);
				break;
			case 4:
				printf("Preorder traversalis:");
				preorder(root);
				printf("\n");
				break;
			case 5:	
				printf("Inorder traversal:");
				inorder(root);
				printf("\n");
				break;
			case 6:	
				printf("Postorder traversal:");
				postorder(root);
				printf("\n");
				break;
			case 7:
				system("clear");
				break;
			case 8:
				exit(0);
			default:
				printf("Wrong choice!\n");
		}		
	}	
}