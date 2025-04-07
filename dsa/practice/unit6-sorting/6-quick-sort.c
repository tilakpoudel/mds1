// WAP to sort array using quick sort

int partition(int a[], int low, int high) {
    int pivot = a[high]; // pivot
    int i = (low - 1); // Index of smaller element

    for (int j = low; j < high; j++) {
        // If current element is smaller than or equal to pivot
        if (a[j] <= pivot) {
            i++; // increment index of smaller element
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }

    // Swap the pivot element with the element at index i + 1
    int temp = a[i + 1];
    a[i + 1] = a[high];
    a[high] = temp;

    return i + 1;
}
void quickSort(int a[], int low, int high) {
    if (low < high) {
        // pi is partitioning index, a[pi] is now at right place
        int pi = partition(a, low, high);

        // Recursively sort elements before partition and after partition
        quickSort(a, low, pi - 1);
        quickSort(a, pi + 1, high);
    }
}
int main() {
    int a[] = {10, 7, 8, 9, 1, 5};
    int n = sizeof(a) / sizeof(a[0]);

    quickSort(a, 0, n - 1);

    printf("Sorted array: \n");
    for (int i = 0; i < n; i++)
        printf("%d ", a[i]);
    printf("\n");

    return 0;
}