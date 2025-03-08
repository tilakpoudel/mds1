/*
    Program to generate fibonacci series using memoization.
    Optimized Approach (Using Memoization - O(n))
    Speed up the recursive approach using memoization (Dynamic Programming).

    Memoization is an optimization technique that stores previously computed results to avoid redundant calculations. 
    It is a form of caching used in recursive functions.

    ✅ Time Complexity: O(n)
    ✅ Space Complexity: O(n)
*/

#include <stdio.h>

#define MAX 100
int memo[MAX]; // Memoization array

// Recursive function with memoization
int fibonacci_memoized(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    if (memo[n] != -1) return memo[n]; // Return if already calculated

    memo[n] = fibonacci_memoized(n - 1) + fibonacci_memoized(n - 2);

    return memo[n];
}

// Function to print Fibonacci series using memoization
void print_fibonacci_memoized(int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", fibonacci_memoized(i));
    }
}

int main() {
    int n;
    printf("Enter the number of terms: ");
    scanf("%d", &n);

    // Initialize memoization array
    for (int i = 0; i < MAX; i++) memo[i] = -1;

    printf("Fibonacci Series (Memoized Recursive): ");
    print_fibonacci_memoized(n);
    
    return 0;
}
