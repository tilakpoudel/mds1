// Insertion sort
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
