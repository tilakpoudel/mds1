/*
    nth fibonacci number with iterative approach
*/
#include <stdio.h>

// Iterative function to find Nth Fibonacci number
int fibonacci(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    
    int a = 0, b = 1, c;

    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }

    return b;
}

int main() {
    int num;
    printf("Enter N: ");
    scanf("%d", &num);
    printf("Fibonacci number at position %d (Iterative): %d\n", num, fibonacci(num));

    return 0;
}
