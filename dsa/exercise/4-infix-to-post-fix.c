/*
    Steps for Conversion
    1. Initialize an empty stack for operators.
    2. Scan the infix expression from left to right.
    3. Handle operands (A-Z, 0-9): Directly add them to the output.
    4. Handle operators (+, -, *, /, ^):
        - Pop operators from the stack if they have greater or equal precedence.
        - Push the current operator to the stack.
    5. Handle parentheses ( and ):
        - Push ( onto the stack.
        - When encountering ), pop from the stack until ( is found.
    6. At the end, pop all remaining operators in the stack.


    Operator	Precedence	Associativity
    ^	        3	        Right-to-left
    * /	        2	        Left-to-right
    + -	        1	        Left-to-right

*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAX 100  // Define stack size

// Stack structure
typedef struct {
    char arr[MAX];
    int top;
} Stack;

// Stack functions
void push(Stack *s, char ch) {
    if (s->top == MAX - 1) {
        printf("Stack overflow!\n");
        
        return;
    }

    s->arr[++(s->top)] = ch;
}

char pop(Stack *s) {
    if (s->top == -1) return '\0';
    
    return s->arr[(s->top)--];
}

char peek(Stack *s) {
    if (s->top == -1) return '\0';
    
    return s->arr[s->top];
}

int precedence(char op) {
    switch (op) {
        case '^': return 3;
        case '*': case '/': return 2;
        case '+': case '-': return 1;
        default: return 0;
    }
}

int isOperator(char ch) {
    return (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '^');
}

// Function to convert infix to postfix
void infixToPostfix(char *infix, char *postfix) {
    Stack s;
    s.top = -1;
    int j = 0;  // Postfix index

    for (int i = 0; infix[i] != '\0'; i++) {
        char ch = infix[i];

        // If the character is an operand, add it to postfix
        if (isalnum(ch)) {
            postfix[j++] = ch;
        }
        // If '(' push to stack
        else if (ch == '(') {
            push(&s, ch);
        }
        // If ')' pop from stack until '(' is found
        else if (ch == ')') {
            while (peek(&s) != '(') {
                postfix[j++] = pop(&s);
            }
            
            pop(&s);  // Remove '('
        }
        // If operator, pop higher precedence operators and push the current operator
        else if (isOperator(ch)) {
            while (s.top != -1 && precedence(peek(&s)) >= precedence(ch)) {
                postfix[j++] = pop(&s);
            }
            
            push(&s, ch);
        }
    }

    // Pop remaining operators
    while (s.top != -1) {
        postfix[j++] = pop(&s);
    }

    postfix[j] = '\0';  // Null terminate the postfix expression
}

// Main function
int main() {
    char infix[MAX], postfix[MAX];

    printf("Enter an infix expression: ");
    scanf("%s", infix);

    infixToPostfix(infix, postfix);

    printf("Postfix Expression: %s\n", postfix);

    return 0;
}

/*
    Testing:
    Enter an infix expression: a+b*c
    Postfix Expression: abc*+

    Enter an infix expression: (a+b)*c
    Postfix Expression: ab+c*

    Enter an infix expression: (a+b)-c^d
    Postfix Expression: ab+cd^-
*/
