// shell sort
// Time complexity: O(n^2) (worst case)
// Space complexity: O(1)
// Stable: No
// Inplace: Yes
//

#include <stdio.h>

void shellSort(int a[], int n) {
    int i, j, gap, temp;

    for(gap = n/2; gap > 0; gap /= 2) {
        for(i = gap; i < n; i++) {
            temp = a[i];

            for(j = i; j >= gap && a[j-gap] > temp; j -= gap) {
                a[j] = a[j-gap];
            }

            a[j] = temp;
        }
    }
}

int main () {
    int a[] = {5, 3, 8, 6, 2};
    int n = 5;

    shellSort(a, n);

    for(int i = 0; i < n; i++) {
        printf("%d \t ", a[i]);
    }

    return 0;
}
// Output: 2  3  5  6  8
// Explanation: The shell sort algorithm works as follows:
// 1. Divide the array into smaller subarrays of a specific gap size.
// 2. Sort the subarrays using insertion sort.
// 3. Reduce the gap size and repeat the process until the gap size is 1.
// The output of the program is the sorted array {2, 3, 5, 6, 8}.
// The time complexity of the shell sort algorithm is O(n^2) in the worst case. 