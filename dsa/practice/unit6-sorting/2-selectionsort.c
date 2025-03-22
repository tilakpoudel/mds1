// Selection sort algorithm
#include <stdio.h>

void selectionSort(int a[], int n) {
    int i, j, min, temp;

    for(i = 0; i < n-1; i++) {
        min = i;

        for(j = i+1; j < n; j++) {
            if(a[j] < a[min]) {
                min = j;
            }
        }

        temp = a[i];
        a[i] = a[min];
        a[min] = temp;
    }
}

int main () {
    int a[] = {5, 3, 8, 6, 2};
    int n = 5;

    selectionSort(a, n);

    for(int i = 0; i < n; i++) {
        printf("%d \t ", a[i]);
    }

    return 0;
}

// Output: 2  3  5  6  8
// Explanation: The selection sort algorithm works as follows:
// 1. Find the minimum element in the array and swap it with the first element.
// 2. Find the minimum element in the remaining array and swap it with the second element.
// 3. Continue this process until the array is sorted.
// The output of the program is the sorted array {2, 3, 5, 6, 8}.
// The time complexity of the selection sort algorithm is O(n^2) in the worst case.
// The space complexity of the selection sort algorithm is O(1) as it sorts the array in-place.
// The selection sort algorithm is not stable, as it may change the relative order of equal elements.
// The selection sort algorithm is not adaptive, as it does not take advantage of pre-sorted elements.
// The selection sort algorithm is simple to implement but inefficient for large datasets.
