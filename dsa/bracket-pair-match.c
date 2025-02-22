/**
     Program to check bracket pair match
    Input: (a+b) - (d-e)
    Output: Balanced

    Input: (a+b) - (d-e))
    Output: Not Balanced
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100

// Stack structure
typedef struct {
    char arr[MAX];
    int top;
} Stack;

// Stack operations
void push(Stack *stack, char ch) {
    if (stack->top == MAX - 1) {
        printf("Stack Overflow\n");
        
        return;
    }
    stack->arr[++stack->top] = ch;
}

char pop(Stack *stack) {
    if (stack->top == -1) {
        
        return '\0'; // Indicates stack underflow
    }
    
    return stack->arr[stack->top--];
}

char peek(Stack *stack) {
    if (stack->top == -1) {
        return '\0';
    }
    
    return stack->arr[stack->top];
}

// Function to check if brackets are balanced
int isBalanced(char *expr) {
    Stack stack;
    stack.top = -1;

    for (int i = 0; i < strlen(expr); i++) {
        char ch = expr[i];

        // Push opening brackets onto stack
        if (ch == '(' || ch == '{' || ch == '[') {
            push(&stack, ch);
        } else if (ch == ')' || ch == '}' || ch == ']') {
            // Pop from stack and check matching
            char top = pop(&stack);

            if ((ch == ')' && top != '(') ||
                (ch == '}' && top != '{') ||
                (ch == ']' && top != '[')) {
                return 0; // Mismatched bracket
            }
        }
    }

    return stack.top == -1; // If stack is empty, brackets are balanced
}

int main() {
    char expr[MAX];

    printf("Enter an expression: ");
    scanf("%s", expr);

    if (isBalanced(expr)) {
        printf("Balanced\n");
    } else {
        printf("Not Balanced\n");
    }

    return 0;
}
