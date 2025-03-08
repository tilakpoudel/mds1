/**
 * Write a recursive program to solve Tower of Hanoi (TOH) problem and hence count the
    number of moves required 

    Problem Statement:
    The Tower of Hanoi is a mathematical puzzle where we have three rods (A, B, C) and N disks. 
    The goal is to move all disks from the source rod (A) to the destination rod (C) using an auxiliary rod (B) 
    with the following rules:

    1. Only one disk can be moved at a time.
    2. A larger disk cannot be placed on a smaller disk.
    3. Only the topmost disk from a rod can be moved.
    
    Recursive Approach:
    The recursive solution follows these steps:

    1. Move N-1 disks from source (A) to auxiliary (B) using destination (C).
    2. Move the Nth (largest) disk from A to C.
    3. Move N-1 disks from B to C using A

    Number of moves required: 2^n -1 
 */
#include <stdio.h>

// Function to solve Tower of Hanoi recursively
void towerOfHanoi(int n, char from_rod, char to_rod, char aux_rod, int *count) {
    if (n == 0) return;  // Base case: No disk to move

    // Move N-1 disks from source to auxiliary using destination
    towerOfHanoi(n - 1, from_rod, aux_rod, to_rod, count);

    // Move the Nth disk from source to destination
    printf("Move disk %d from %c to %c\n", n, from_rod, to_rod);
    (*count)++;  // Increment move count

    // Move N-1 disks from auxiliary to destination using source
    towerOfHanoi(n - 1, aux_rod, to_rod, from_rod, count);
}

int main() {
    int n, count = 0;
    printf("Enter the number of disks: ");
    scanf("%d", &n);

    printf("Solution for Tower of Hanoi with %d disks:\n", n);
    towerOfHanoi(n, 'A', 'C', 'B', &count);

    printf("\nTotal moves required: %d\n", count);  // Print total moves

    return 0;
}

/*
    Testing:

    Enter the number of disks: 5
    Solution for Tower of Hanoi with 5 disks:
    Move disk 1 from A to C
    Move disk 2 from A to B
    Move disk 1 from C to B
    Move disk 3 from A to C
    Move disk 1 from B to A
    Move disk 2 from B to C
    Move disk 1 from A to C
    Move disk 4 from A to B
    Move disk 1 from C to B
    Move disk 2 from C to A
    Move disk 1 from B to A
    Move disk 3 from C to B
    Move disk 1 from A to C
    Move disk 2 from A to B
    Move disk 1 from C to B
    Move disk 5 from A to C
    Move disk 1 from B to A
    Move disk 2 from B to C
    Move disk 1 from A to C
    Move disk 3 from B to A
    Move disk 1 from C to B
    Move disk 2 from C to A
    Move disk 1 from B to A
    Move disk 4 from B to C
    Move disk 1 from A to C
    Move disk 2 from A to B
    Move disk 1 from C to B
    Move disk 3 from A to C
    Move disk 1 from B to A
    Move disk 2 from B to C
    Move disk 1 from A to C

    Total moves required: 31
*/