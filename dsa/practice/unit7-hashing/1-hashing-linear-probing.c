// Linear probing
// It is collision resolution techinque,


#include<stdio.h>
int a[10] = {NULL};

int hash(int k)
{
    return k % 10;
}

int indexWithLinearProbing(int i, int j) {
    return (i + j) % 10;
}

int indexWithQuadraticProbing (int i, int j) {
    return (i + (j*j)) % 10;
}

void insert(int k)
{
    int i = hash(k), index;
    // Linear probing
    // If the index is already occupied, we need to find the next available index
    // by checking the next indices in a circular manner
    for(int j = 0; j < 10; j++)
    {
        index = indexWithQuadraticProbing(i, j);

        if(a[index]==NULL)
        {
            a[index] = k;

            break;
        }
    }
}

// search an element
int search(int k)
{
    int i = hash(k), index;

    for(int j = 0; j < 10; j++)
    {
        index = indexWithQuadraticProbing(i, j);

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
        index = indexWithQuadraticProbing(i, j);

        if(a[index]==k)
        {
            a[index]=NULL;
            break;
        }
    }
}

int main()
{
    insert(10);
    insert(15);
    insert(89);
    insert(18);
    insert(49);
    insert(58);
    insert(69);
    insert(5);
    del(58);

    printf("%d\n", search(5));
    printf("%d\n", search(58));
}