/*
    Program to find the gcd using recursion
    Recursive Approach (Euclidean Algorithm, O(log(min(a,b))))
*/

#include <stdio.h>

// Recursive function to find GCD using Euclidean algorithm
int gcd_recursive(int a, int b) {
    if (b == 0)
        return a;

    return gcd_recursive(b, a % b);
}

int main() {
    int a, b;
    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);
    printf("GCD of %d and %d (Recursive): %d\n", a, b, gcd_recursive(a, b));

    return 0;
}
