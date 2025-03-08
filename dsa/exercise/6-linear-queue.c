/*
    Write a program to implement Linear Queue using array data structure.
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX 5  // Maximum size of the queue

// Structure to represent a queue
typedef struct {
    int items[MAX];
    int front;
    int rear;
} Queue;

// Function to initialize the queue
void initQueue(Queue* q) {
    q->front = -1;
    q->rear = -1;
}

// Function to check if the queue is empty
int isEmpty(Queue* q) {
    return q->front == -1;
}

// Function to check if the queue is full
int isFull(Queue* q) {
    return q->rear == MAX - 1;
}

// Function to add an element to the queue
void enqueue(Queue* q, int value) {
    if (isFull(q)) {
        printf("Queue is full! Cannot enqueue %d\n", value);
        
        return;
    }
    if (isEmpty(q)) {
        q->front = 0;  // Set front to 0 if it's the first element
    }

    q->rear++;
    q->items[q->rear] = value;
    printf("Enqueued: %d\n", value);
}

// Function to remove an element from the queue
int dequeue(Queue* q) {
    if (isEmpty(q)) {
        printf("Queue is empty! Cannot dequeue.\n");
        
        return -1;  // Return -1 to indicate an error
    }
    int item = q->items[q->front];
    if (q->front == q->rear) {
        // Queue has only one element, reset the queue
        q->front = q->rear = -1;
    } else {
        q->front++;
    }
    
    printf("Dequeued: %d\n", item);
    
    return item;
}

// Function to get the front element of the queue
int peek(Queue* q) {
    if (isEmpty(q)) {
        printf("Queue is empty! No front element.\n");
        
        return -1;  // Return -1 to indicate an error
    }
    
    return q->items[q->front];
}

// Function to display the queue
void display(Queue* q) {
    if (isEmpty(q)) {
        printf("Queue is empty!\n");
        
        return;
    }
    
    printf("Queue elements: ");
    
    for (int i = q->front; i <= q->rear; i++) {
        printf("%d ", q->items[i]);
    }
    printf("\n");
}

// Main function to demonstrate the queue operations
int main() {
    Queue q;
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
    Output:

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 1
    Enter value to enqueue: 20
    Enqueued: 20

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
    Queue elements: 20 50 

    Menu:
    1. Enqueue
    2. Dequeue
    3. Peek
    4. Display
    0. Exit
    Enter your choice: 3
    Front element: 20
*/
