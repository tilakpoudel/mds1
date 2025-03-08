/**
 * Program to find fibonacci series up to nth term iterative approach
 * 
 * ✅ Efficient: This approach runs in O(n) time complexity and does not require extra memory.
 */

 #include <stdio.h>

// Function to print Fibonacci series using iteration
void print_fibonacci_iterative(int n) {
    int a = 0, b = 1, c;
    printf("%d %d ", a, b); // Print first two terms

    for (int i = 2; i < n; i++) {
        c = a + b;
        printf("%d ", c);
        a = b;
        b = c;
    }
}

int main() {
    int n;
    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Series (Iterative): ");
    if (n == 1) {
        printf("0");
    } else if (n >= 2) {
        print_fibonacci_iterative(n);
    }
    
    return 0;
}
