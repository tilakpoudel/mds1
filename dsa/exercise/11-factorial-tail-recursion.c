/*
    Factorial Using Tail Recursion

    Concept of Tail Recursion
    - In tail recursion, the recursive call is the last operation in the function.
    - No extra computation is needed after returning from the recursive call.
    - The compiler optimizes tail recursion by converting it into a loop (Tail Call Optimization - TCO).

    - Time Complexity: O(n).
    - Eliminates extra function calls in the stack, making it more efficient than normal recursion.
*/

#include <stdio.h>

// Tail recursive function to calculate factorial
long long factorialTail(int n, long long result) {
    if (n == 0 || n == 1)  // Base case
        return result;
    
    return factorialTail(n - 1, n * result); // Recursive call with updated result
}

// Wrapper function
long long factorial(int n) {
    return factorialTail(n, 1);  // Start with result = 1
}

int main() {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    printf("Factorial of %d is %lld\n", n, factorial(n));

    return 0;
}
