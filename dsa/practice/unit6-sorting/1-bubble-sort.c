// Bubble Sort
// Time Complexity: O(n^2)
// Space Complexity: O(1)
// Stable: Yes
// Inplace: Yes


#include <stdio.h>

void bubbleSort(int a[], int n) {
    int pass, i, temp, flag = 1;
    for(pass = 0; pass < n-1 && flag == 1; pass++) {
    
        flag = 0;
        for(i = 0; i < n-1-pass; i++) {
            if(a[i] > a[i+1]) {
                flag = 1;
                temp = a[i];
                a[i] = a[i+1];
                a[i+1] = temp;
            }
        }
    }
}

int main () {
    int a[] = {5, 3, 8, 6, 2};
    int n = 5;

    bubbleSort(a, n);

    for(int i = 0; i < n; i++) {
        printf("%d \t ", a[i]);
    }

    return 0;
}
