/*
    Program to find sum of n natural numbers using recursion
*/
#include <stdio.h>

// Recursive function to find sum of first N natural numbers
int sum(int n) {
    if (n == 0)
        return 0;

    return n + sum(n - 1);
}

int main() {
    int num;
    printf("Enter n: ");
    scanf("%d", &num);
    printf("Sum of first %d natural numbers (Recursive): %d\n", num, sum(num));

    return 0;
}
