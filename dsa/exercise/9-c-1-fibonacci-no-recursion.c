/*
    Program to find nth  fibonacci number with recursion
*/

#include <stdio.h>

// Recursive function to find Nth Fibonacci number
int fibonacci(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int num;
    printf("Enter N: ");
    scanf("%d", &num);
    printf("Fibonacci number at position %d (Recursive): %d\n", num, fibonacci(num));

    return 0;
}
