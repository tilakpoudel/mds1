/*
    Program to find gcd using iterative approach
*/

#include <stdio.h>

// Iterative function to find GCD using Euclidean algorithm
int gcd_iterative(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }

    return a;
}

int main() {
    int a, b;
    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);
    printf("GCD of %d and %d (Iterative): %d\n", a, b, gcd_iterative(a, b));

    return 0;
}
