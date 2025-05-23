/*
    Program to find factorial using iterative method
*/

#include <stdio.h>

// Iterative function to find factorial
long long factorial(int n) {
    long long fact = 1;

    for (int i = 2; i <= n; i++) {
        fact *= i;
    }

    return fact;
}

int main() {
    int num;
    printf("Enter a number: ");
    scanf("%d", &num);
    printf("Factorial of %d is %lld\n", num, factorial(num));

    return 0;
}
