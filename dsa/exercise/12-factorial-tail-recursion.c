#include<stdio.h>

long fact(int n, int a)
{
    if (n==0) return a;
    else return fact(n-1, n*a);
}

int main ()
{
    int n;

    printf("Enter n \n");
    scanf("%d", &n);
    printf("%d! = %ld", n, fact(n, 1));
}
