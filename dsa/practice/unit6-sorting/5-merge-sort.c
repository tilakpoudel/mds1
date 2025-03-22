// merge sort
// Time complexity: O(n log n) (worst case)
// Space complexity: O(n)
// Stable: Yes
// Inplace: No
//
// Merge sort is a divide-and-conquer algorithm that divides the array into two halves, sorts the two halves separately, and then merges them back together.
// The merge operation combines two sorted arrays into a single sorted array.
// The merge sort algorithm has a time complexity of O(n log n) in the worst case, making it efficient for large datasets.
// The space complexity of the merge sort algorithm is O(n) due to the auxiliary array used for merging.
// The merge sort algorithm is stable, as it preserves the relative order of equal elements.
// The merge sort algorithm is not inplace, as it requires additional space for the auxiliary array.
// The merge sort algorithm is efficient for large datasets and is widely used in practice.
// The merge sort algorithm is a recursive algorithm that divides the array into smaller subarrays until the base case is reached.
// The merge operation combines two sorted arrays into a single sorted array.


#include <stdio.h>

void exchange(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void merge(int a[], int l, int m, int r) {
    int n1 = m - l + 1;
    int n2 = r - m;

    int L[n1], R[n2];

    for(int i = 0; i < n1; i++) {
        L[i] = a[l + i];
    }

    for(int j = 0; j < n2; j++) {
        R[j] = a[m + 1 + j];
    }

    int i = 0, j = 0, k = l;

    while(i < n1 && j < n2) {
        if(L[i] <= R[j]) {
            a[k] = L[i];
            i++;
        } else {
            a[k] = R[j];
            j++;
        }
        k++;
    }

    while(i < n1) {
        a[k] = L[i];
        i++;
        k++;
    }

    while(j < n2) {
        a[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int a[], int l, int r) {
    if(l < r) {
        int m = l + (r - l) / 2;

        mergeSort(a, l, m);
        mergeSort(a, m + 1, r);

        merge(a, l, m, r);
    }
}

int main () {
    int a[] = {5, 3, 8, 6, 2};
    int n = 5;

    mergeSort(a, 0, n-1);

    for(int i = 0; i < n; i++) {
        printf("%d \t ", a[i]);
    }

    return 0;
}
// Output: 2  3  5  6  8