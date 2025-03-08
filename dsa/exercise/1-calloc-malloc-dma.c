/*
    Write a program to find sum and average of n numbers using malloc(), calloc(), realloc(),
    and free() in C.

    Key Differences Between malloc() and calloc()
    Function	Initialization	Speed	Use Case
    malloc()	No (contains garbage values)	Faster	When you don’t need initialization
    calloc()	Yes (sets memory to 0)	Slightly slower	When you need zero-initialized memory
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, i, choice;
    float sum = 0, avg;
    float *numbers;

    // Asking the user to choose malloc or calloc
    printf("Choose memory allocation method:\n");
    printf("1. malloc()\n2. calloc()\nEnter your choice: ");
    scanf("%d", &choice);

    // Asking the user for the number of elements
    printf("Enter the number of elements: ");
    scanf("%d", &n);

    switch (choice) {
        case 1:
            // Using malloc()
            numbers = (float *)malloc(n * sizeof(float));
            printf("Memory allocated using malloc()\n");
            
            break;
        case 2:
            // Using calloc()
            numbers = (float *)calloc(n, sizeof(float));
            printf("Memory allocated using calloc()\n");
            
            break;
        default:
            printf("Invalid choice!\n");
            
            return 1;
    }

    // Check if memory allocation was successful
    if (numbers == NULL) {
        printf("Memory allocation failed!\n");
        
        return 1;
    }

    // Accepting user input
    printf("Enter %d numbers:\n", n);
    
    for (i = 0; i < n; i++) {
        scanf("%f", &numbers[i]);
        sum += numbers[i]; // Calculating sum
    }

    // Displaying sum and average
    avg = sum / n;
    printf("Sum = %.2f\n", sum);
    printf("Average = %.2f\n", avg);

    // Asking if the user wants to reallocate memory
    int new_n;
    printf("\nDo you want to resize the array? (Enter new size or 0 to skip): ");
    scanf("%d", &new_n);

    if (new_n > 0) {
        numbers = (float *)realloc(numbers, new_n * sizeof(float));

        if (numbers == NULL) {
            printf("Memory reallocation failed!\n");
            
            return 1;
        }

        // If new size is greater, take additional input
        if (new_n > n) {
            printf("Enter %d more numbers:\n", new_n - n);
            
            for (i = n; i < new_n; i++) {
                scanf("%f", &numbers[i]);
                sum += numbers[i];
            }
        }

        // Updating sum and average with new data
        avg = sum / new_n;
        printf("Updated Sum = %.2f\n", sum);
        printf("Updated Average = %.2f\n", avg);
    }

    // Freeing allocated memory
    free(numbers);
    printf("Memory freed successfully!\n");

    return 0;
}
