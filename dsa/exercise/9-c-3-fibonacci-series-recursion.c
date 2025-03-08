/*
    WAP to find the fibonacci series up to nth term using recursion
    Recursive Approach (O(2ⁿ))

    ✅ Note: This approach is inefficient for large n due to exponential time complexity.
*/

#include <stdio.h>

// Recursive function to find Fibonacci number
int fibonacci_recursive(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2);
}

// Function to print Fibonacci series using recursion
void print_fibonacci_recursive(int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", fibonacci_recursive(i));
    }
}

int main() {
    int n;
    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Series (Recursive): ");
    print_fibonacci_recursive(n);
    
    return 0;
}

