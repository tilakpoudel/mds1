/*
7. WAP to implement circular queue using array.
Linear Queue vs Circular Queue

Feature	                Linear Queue	                                     Circular Queue
Structure	            Follows a straight, linear order.	                 Follows a circular order where the last position connects to the first.
Insertion (Enqueue)	    Happens at the rear end.	                         Happens at the rear end.
Deletion (Dequeue)	    Happens at the front end.	                         Happens at the front end.
Memory Utilization	    Inefficient as space is wasted when elements are dequeued.|	Efficient as space can be reused once an element is dequeued.
Overflow Condition	    Occurs when the rear reaches the last index, even if there are empty spaces at the front.|	Occurs only when all positions are occupied.
Implementation	        Implemented using arrays or linked lists.	        Implemented using arrays with modulo operations.
Performance	            Less efficient in memory usage.	                    More efficient in memory utilization.

Key Differences:
    - In a linear queue, once elements are removed from the front, the vacant space cannot be 
    reused (unless elements are shifted, which is costly).
    - In a circular queue, when the rear reaches the last index, it wraps around to the front if space is available, 
    making better use of memory.
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX 5  // Maximum size of the queue

// Structure to represent a circular queue
typedef struct {
    int items[MAX];
    int front;
    int rear;
} CircularQueue;

// Function to initialize the circular queue
void initQueue(CircularQueue *q) {
    q->front = -1;
    q->rear = -1;
}

// Function to check if the queue is empty
int isEmpty(CircularQueue *q) {
    return q->front == -1;
}

// Function to check if the queue is full
int isFull(CircularQueue *q) {
    return (q->rear + 1) % MAX == q->front;
}

// Function to add an element to the circular queue
void enqueue(CircularQueue *q, int value) {
    if (isFull(q)) {
        printf("Queue is full! Cannot enqueue %d\n", value);
        
        return;
    }
    if (isEmpty(q)) {
        q->front = 0;  // Set front to 0 if it's the first element
    }
    
    q->rear = (q->rear + 1) % MAX;  // Wrap around
    q->items[q->rear] = value;
    printf("Enqueued: %d\n", value);
}

// Function to remove an element from the circular queue
int dequeue(CircularQueue *q) {
    if (isEmpty(q)) {
        printf("Queue is empty! Cannot dequeue.\n");
        
        return -1;  // Return -1 to indicate an error
    }
    int item = q->items[q->front];
    if (q->front == q->rear) {
        // Queue has only one element, reset the queue
        q->front = q->rear = -1;
    } else {
        q->front = (q->front + 1) % MAX;  // Wrap around
    }
    printf("Dequeued: %d\n", item);
    return item;
}

// Function to get the front element of the circular queue
int peek(CircularQueue *q) {
    if (isEmpty(q)) {
        printf("Queue is empty! No front element.\n");
        
        return -1;  // Return -1 to indicate an error
    }
    
    return q->items[q->front];
}

// Function to display the circular queue
void display(CircularQueue *q) {
    if (isEmpty(q)) {
        printf("Queue is empty!\n");
        
        return;
    }
    printf("Queue elements: ");
    int i = q->front;
    
    while (1) {
        printf("%d ", q->items[i]);
        if (i == q->rear) break;
        i = (i + 1) % MAX;  // Wrap around
    }
    
    printf("\n");
}

// Main function to demonstrate the circular queue operations
int main() {
    CircularQueue q;
    initQueue(&q);
    int choice, value;

    do {
        printf("\nMenu:\n");
        printf("1. Enqueue\n");
        printf("2. Dequeue\n");
        printf("3. Peek\n");
        printf("4. Display\n");
        printf("0. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Enter value to enqueue: ");
                scanf("%d", &value);
                enqueue(&q, value);
                
                break;
            case 2:
                dequeue(&q);
                
                break;
            case 3:
                value = peek(&q);
                
                if (value != -1) {
                    printf("Front element: %d\n", value);
                }
                
                break;
            case 4:
                display(&q);
                
                break;
            case 0:
                printf("Exiting...\n");
                
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);

    return 0;
}

/*
    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 1
    Enter value to enqueue: 23
    Enqueued: 23

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 1  
    Enter value to enqueue: 50
    Enqueued: 50

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 4
    Queue elements: 23 50 

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 1
    Enter value to enqueue: 89
    Enqueued: 89

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 4
    Queue elements: 23 50 89 

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 3
    Front element: 23

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 2
    Dequeued: 23

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 4
    Queue elements: 50 89 

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 2
    Dequeued: 50

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 2
    Dequeued: 89

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 2
    Queue is empty! Cannot dequeue.

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 0
    Exiting...
*/
