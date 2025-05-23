
// binary search
// time complexity: O(log n)
// space complexity: O(1)

#include<stdio.h>

int count = 0;

int binary_search(int arr[], int n, int target) {
    int low = 0, high = n - 1, mid;

    while (low <= high) {
        count++;

        mid = (low + high) / 2;

        if (arr[mid] == target)
            return mid;
        else if (arr[mid] < target)
            low = mid + 1;
        else
            high = mid - 1;
    }

    return -1;
}

int main() {
    int n, target;
    printf("Enter number of elements: ");
    scanf("%d", &n);

    int arr[n];
    printf("Enter elements: ");

    for (int i = 0; i < n; i++)
        scanf("%d", &arr[i]);

    printf("Enter target to search: ");
    scanf("%d", &target);

    int index = binary_search(arr, n, target);

    if (index == -1)
        printf("%d  not found\n", target);
    else
        printf("%d found at index %d\n", target, index);

    printf("Number of comparision: %d\n", count);

    return 0;
}
