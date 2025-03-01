//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.extern printf
.global _start

_start:

ADR     X1, a //load address of A into X1
LDR     D0, [X1] //load value of A into D1

ADR     X1, b //load address of B into X1
LDR     D1, [X1] //load value of B into D1

ADR     X1, N //load address of N into X1
LDR     X2, [X1] //load value of N into X2

ADR     X1, T //load address of T into X1
LDR     D3, [X1] //load value of T into D3

ADR     X0, coeff //load address of coeff into X1

MOV     X28, 0 //X28 will be upcast register source, move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FMOV    D4, D28 //D4 will hold our C value
MOV     X5, 0 //X5 will be a designated counter variable


BL      bisection //branch and link to the bisection function
B       END //go to the end to print the results and terminate the program


bisection: //args: arr, A, B, N, T, C
SUB     SP, SP, 56 //allocate 7 frames on stack
STR     LR, [SP, 0] //store return address on stack
STR     X0, [SP, 8] //store address of coeff on stack
STR     D0, [SP, 16] //store A on stack
STR     D1, [SP, 24] //store B on stack
STR     X2, [SP, 32] //store N on stack
STR     D3, [SP, 40] //store T on stack
STR     D4, [SP, 48] //store C on stack


FADD    D4, D0, D1 //add A+B, store it in D4 (for calculating C)
MOV     X28, 2 //move 2 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FDIV    D4, D4, D28 //divide D4 by 2. D4 now equals C
FMOV    D27, D4 //move C to a safe register

FMOV    D10, D4 //D10 will always store X for f(x) (here: C)
MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FMOV    D11, D28 //D11 will always store the result of f(x) (here: f(C))
BL      fx //calculate f(C)
FMOV    D21, D11 //D21 = f(C)

MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FCMP    D21, D28 //compare f(C) with 0
B.GT    positive //if f(C) > 0, branch to positive
FNEG    D25, D3 //else, D25 = -T
FCMP    D21, D25 //compare f(c) with -T
B.GT    return //if f(c) > -T, return (we are done!)
B       else //else...

    positive:
FCMP    D21, D3 //compare f(c) with T
B.LT    return //if f(C) < T, return (we are done!)

    else: //...start calculating f(A) and f(B) to determine the new interval
FMOV    D10, D0 //D10 will always store X for f(x) (here: A)
MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FMOV    D11, D28 //D11 will always store the result of f(x) (here: f(A))
BL      fx //calculate f(A)
FMOV    D22, D11 //D22 = f(A)

FMOV    D10, D1 //D10 will always store X for f(x) (here: B)
MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FMOV    D11, D28 //D11 will always store the result of f(x) (here: f(B))
BL      fx //calculate f(B)
FMOV    D23, D11 //D23 = f(B)

MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FCMP    D21, D28 //compare f(c) with 0
B.GT    pos //if f(C) > 0, branch to pos

    neg:
MOV     X28, 0 //else, move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FCMP    D22, D28 //compare f(A) with 0
B.LT    set_a //if f(A) < 0 (same sign), set C as new A value
B       set_b //else (opposite sign), set C as the new B value

    pos:
MOV     X28, 0 //move 0 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FCMP    D22, D28 //compare f(A) with 0
B.GT    set_a //if f(A) > 0 (same sign), set C as new A value
B       set_b //else (opposite sign), set C as new B value

    set_a:
FMOV    D0, D4 //move current C value to be new A value
B       recursion //go to the recursive call

    set_b:
FMOV    D1, D4 //move current C value to be new B value

    recursion:
BL      bisection //recursive call!


    return:
LDR     LR, [SP, 0] //load return address from stack
LDR     X0, [SP, 8] //load address of coeff from stack
LDR     D0, [SP, 16] //load A from stack
LDR     D1, [SP, 24] //load B from stack
LDR     X2, [SP, 32] //load N from stack
LDR     D3, [SP, 40] //load T from stack
LDR     D4, [SP, 48] //load C from stack
ADD     SP, SP, 56 //deallocate 7 frames on stack
RET //return!




fx: //args: arr, X, N, counter
SUB     SP, SP, 40 //allocate 5 frames on stack
STR     LR, [SP, 0] //store return address on stack
STR     X0, [SP, 8] //store address of coeff on stack
STR     D10, [SP, 16] //store X on stack
STR     X2, [SP, 24] //store N on stack
STR     X5, [SP, 32] //store counter on stack

MOV     X3, X2 //copy N to X3 (for counting purposes)
ADD     X3, X3, 1 //add 1 to N (for counting purposes)
CMP     X5, X3 //compare counter with N
B.EQ    return_fx //if counter == N, return (we have gone through all coefficients)

MOV     X28, 1 //move 1 to upcast register
SCVTF   D28, X28 //upcast X28 to double
FMOV    D12, D28 //move 1 to D12 (D12 will store the result of x^i)
MOV     X13, 0 //X13 will be a new counter for computing the power
    power: //compute x^i
CMP     X13, X5 //compare power counter with the value of the current counter
B.EQ    power_end //if power and current counter are equal, we are finished finding x^i (go to power_end)
FMUL    D12, D12, D10 //else, multiply D12 by X (x^i accumulates in D12)
ADD     X13, X13, 1 //increment the power counter
B       power //loop!
    power_end:
LSL     X6, X5, 3 //logical left shift the current counter by 3 bits/multiply by 8 (to get correct offset for array), store in X6
LDR     D14, [X0, X6] //store the current coefficient in D14
FMUL    D12, D12, D14 //multiply x^i by the current coefficient
FADD    D11, D11, D12 //add the result to the accumulating sum for f(x)

ADD     X5, X5, 1 //increment the counter
BL      fx //recursive call!



    return_fx:
LDR     LR, [SP, 0] //load return address from stack
LDR     X0, [SP, 8] //load address of coeff from stack
LDR     D10, [SP, 16] //load X from stack
LDR     X2, [SP, 24] //load N from stack
LDR     X5, [SP, 32] //load counter from stack
ADD     SP, SP, 40 //deallocate 5 frames on stack
RET //return!







END: //calculations are done, start printing!
ADR     X0, msg1 //load the address of msg1 in X0
FMOV    D0, D27 //move the root from safe register to D0 (for printing C value)
FMOV    D1, D21 //move the most recently calculated value of f(C) to D1, to be printed
BL      printf //print!


MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */



.data
coeff:  .double 0.2, 3.1, -0.3, 1.9, 0.2
N:      .dword 4
T:      .double 0.01
a:      .double -1
b:      .double 1 
msg1:   .string "x = %lf    f(x) = %lf\n"

.end
