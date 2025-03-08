/*
    Program to find factorial of number using recursive method
*/

#include <stdio.h>

// Recursive function to find factorial
long long factorial(int n) {
    if (n == 0 || n == 1)
        return 1;

        return n * factorial(n - 1);
}

int main() {
    int num;
    printf("Enter a number: ");
    scanf("%d", &num);
    printf("Factorial of %d is %lld\n", num, factorial(num));

    return 0;
}
