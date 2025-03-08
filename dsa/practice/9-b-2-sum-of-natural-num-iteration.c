/*
    Program to find sum of n natural number with iteration
*/

#include <stdio.h>

// Iterative function to find sum of first N natural numbers
int sum_iterative(int n) {
    int sum = 0;

    for (int i = 1; i <= n; i++) {
        sum += i;
    }

    return sum;
}

int main() {
    int num;
    printf("Enter n: ");
    scanf("%d", &num);
    printf("Sum of first %d natural numbers (Iterative): %d\n", num, sum_iterative(num));

    return 0;
}
