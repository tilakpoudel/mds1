/*
    Priority Queue using Array in C

    A Priority Queue is a special type of queue where each element has a priority, and elements with higher priority 
    are dequeued before elements with lower priority. If two elements have the same priority, they follow 
    the First-In-First-Out (FIFO) order.

    Implementation using Arrays
    We will use an array to store elements along with their priorities. The basic operations are:

    - Insertion (enqueue): Insert an element into the queue at the correct position based on priority.
    - Deletion (dequeue): Remove the element with the highest priority.
    - Display: Show all elements along with their priorities.

*/

#include <stdio.h>
#include <stdlib.h>

#define MAX 10  // Maximum size of the priority queue

// Structure to store an element and its priority
typedef struct {
    int value;
    int priority;
} PriorityQueue;

// Priority queue array and size variable
PriorityQueue pq[MAX];
int size = 0;  // Keeps track of the number of elements in the queue

// Function to insert an element into the priority queue
void enqueue(int value, int priority) {
    if (size == MAX) {
        printf("Priority Queue is full!\n");

        return;
    }

    // Insert the new element at the correct position based on priority
    int i;

    for (i = size - 1; i >= 0 && pq[i].priority > priority; i--) {
        pq[i + 1] = pq[i];  // Shift elements to the right
    }

    // Insert the new element
    pq[i + 1].value = value;
    pq[i + 1].priority = priority;
    size++;

    printf("Inserted (%d, Priority: %d)\n", value, priority);
}

// Function to remove the element with the highest priority
void dequeue() {
    if (size == 0) {
        printf("Priority Queue is empty!\n");

        return;
    }

    printf("Removed (%d, Priority: %d)\n", pq[0].value, pq[0].priority);

    // Shift all elements to the left
    for (int i = 1; i < size; i++) {
        pq[i - 1] = pq[i];
    }

    size--;
}

// Function to display the priority queue
void display() {
    if (size == 0) {
        printf("Priority Queue is empty!\n");

        return;
    }

    printf("Priority Queue: \n");

    for (int i = 0; i < size; i++) {
        printf("(%d, Priority: %d) ", pq[i].value, pq[i].priority);
    }

    printf("\n");
}

// Main function with menu-driven interaction
int main() {
    int choice, value, priority;

    while (1) {
        printf("\nPriority Queue Operations:\n");
        printf("1. Enqueue\n");
        printf("2. Dequeue\n");
        printf("3. Display\n");
        printf("4. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Enter value and priority: ");
                scanf("%d %d", &value, &priority);
                enqueue(value, priority);

                break;

            case 2:
                dequeue();

                break;

            case 3:
                display();

                break;

            case 4:
                printf("Exiting...\n");

                exit(0);

            default:
                printf("Invalid choice! Try again.\n");
        }
    }

    return 0;
}

/*
    Time Complexity
    - Insertion (enqueue): O(n) (since we shift elements to maintain order)
    - Deletion (dequeue): O(n) (shifting elements after removal).
    - Display (display): O(n).

    Testing

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 1
    Enter value and priority: 10 3
    Inserted (10, Priority: 3)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 1
    Enter value and priority: 20 2
    Inserted (20, Priority: 2)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 1
    Enter value and priority: 10 1
    Inserted (10, Priority: 1)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 3
    Priority Queue: 
    (10, Priority: 1) (20, Priority: 2) (10, Priority: 3) 

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 1
    Enter value and priority: 40 2
    Inserted (40, Priority: 2)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 3
    Priority Queue: 
    (10, Priority: 1) (20, Priority: 2) (40, Priority: 2) (10, Priority: 3) 

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 2
    Removed (10, Priority: 1)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 3
    Priority Queue: 
    (20, Priority: 2) (40, Priority: 2) (10, Priority: 3) 

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 2
    Removed (20, Priority: 2)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 3
    Priority Queue: 
    (40, Priority: 2) (10, Priority: 3) 

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 1
    Enter value and priority: 46 1
    Inserted (46, Priority: 1)

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 3
    Priority Queue: 
    (46, Priority: 1) (40, Priority: 2) (10, Priority: 3) 

    Priority Queue Operations:
    1. Enqueue
    2. Dequeue
    3. Display
    4. Exit
    Enter your choice: 4
    Exiting...
*/
