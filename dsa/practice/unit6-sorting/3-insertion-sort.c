// Insertion sort
// Time complexity: O(n^2)
// Space complexity: O(1)
// Stable: Yes
// Inplace: Yes
//
// Insertion sort is a simple sorting algorithm that works the way we sort playing cards in our hands.
// We start from the second element and compare it with the first element. If the second element is smaller than the first element, we swap them.
// We continue this process for the third element and so on.
// The key element is compared with the elements on its left and inserted at the correct position.
// The array is divided into two parts: sorted and unsorted. The sorted part is on the left side of the key element and the unsorted part is on the right side of the key element.
// The key element is compared with the elements on its left and inserted at the correct position.

#include <stdio.h>

void insertionSort(int a[], int n) {
    int i, j, key;
    for(i = 1; i < n; i++) {
        key = a[i];
        j = i - 1;

        while(j >= 0 && a[j] > key) {
            a[j+1] = a[j];
            j = j - 1;
        }

        a[j+1] = key;
    }
}

int main () {
    int a[] = {5, 3, 8, 6, 2};
    int n = 5;

    insertionSort(a, n);

    for(int i = 0; i < n; i++) {
        printf("%d \t ", a[i]);
    }

    return 0;
}
