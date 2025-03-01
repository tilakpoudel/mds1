/*
    Steps to Evaluate Postfix Expression
    1. Initialize an empty stack.
    2.Scan the postfix expression from left to right:
        - If the character is a number, push it onto the stack.
        - If the character is an operator, pop two numbers from the stack, perform the operation, and push 
        the result back onto the stack.
    3. At the end, the stack should contain the final result.
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

#define MAX 100  // Stack size

// Stack structure
typedef struct {
    int arr[MAX];
    int top;
} Stack;

// Stack functions
void push(Stack *s, int value) {
    if (s->top == MAX - 1) {
        printf("Stack overflow!\n");
        
        return;
    }
    
    s->arr[++(s->top)] = value;
}

int pop(Stack *s) {
    if (s->top == -1) {
        printf("Stack underflow!\n");
        
        return -1;  // Error condition
    }

    return s->arr[(s->top)--];
}

int peek(Stack *s) {
    if (s->top == -1) return -1;
    
    return s->arr[s->top];
}

int isOperator(char ch) {
    return (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '^');
}

int applyOperator(int operand1, int operand2, char operator) {
    switch (operator) {
        case '+': return operand1 + operand2;
        case '-': return operand1 - operand2;
        case '*': return operand1 * operand2;
        case '/': return operand1 / operand2;
        case '^': return (int)pow(operand1, operand2);  // For power operation
        
        default: return 0;
    }
}

// Function to evaluate the postfix expression
int evaluatePostfix(char *postfix) {
    Stack s;
    s.top = -1;

    for (int i = 0; postfix[i] != '\0'; i++) {
        char ch = postfix[i];

        // If the character is a digit, push it to the stack
        if (isdigit(ch)) {
            push(&s, ch - '0');  // Convert char to integer (ASCII '0' = 48)
        }
        // If the character is an operator, pop two operands and apply the operator
        else if (isOperator(ch)) {
            int operand2 = pop(&s);
            int operand1 = pop(&s);
            int result = applyOperator(operand1, operand2, ch);
            push(&s, result);  // Push the result back onto the stack
        }
    }

    // Final result is the only item left in the stack
    return pop(&s);
}

// Main function
int main() {
    char postfix[MAX];

    printf("Enter a postfix expression: ");
    scanf("%s", postfix);

    int result = evaluatePostfix(postfix);

    printf("Result of the postfix expression: %d\n", result);

    return 0;
}

/*
    Testing:
    Enter a postfix expression: 23*45*+
    Result of the postfix expression: 26

    Enter a postfix expression: 623+-382/+*2^3+
    Result of the postfix expression: 52
*/
