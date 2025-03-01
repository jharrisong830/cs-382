//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:

//LOADING MEMORY ADDRESSES
ADR     X1, vec1 //address of vec1 stored in X1
ADR     X2, vec2 //address of vec2 stored in X2
ADR     X3, dot //address of dot stored in X3

//COMPUTATIONS FOR FIRST COMPONENT
LDUR    X11, [X1] //stores vec1 in X11
LDUR    X22, [X2] //stores vec2 in X22
LDUR    X9, [X3] //stores dot in X9

MUL     X4, X11, X22 //multiplies components of vec1 (X11) and vec2 (X22), stores it in X4
ADD     X5, X9, X4 //adds X9 (dot) and X4 (most recent product), stores it in X5
MOV     X9, X5 //moves X5 data (current sum) to X9

//SECOND COMPONENT
LDUR    X11, [X1, 8] //stores 2nd component of vec1 in X11 (long int means that offset is 8 for each index)
LDUR    X22, [X2, 8] //stores 2nd component of vec2 in X22

MUL     X4, X11, X22 //multiplies components of vec1 (X11) and vec2 (X22), stores it in X4
ADD     X5, X9, X4 //adds X9 (dot) and X4 (most recent product), stores it in X5
MOV     X9, X5 //moves X5 data (current sum) to X9

//THIRD COMPONENT
LDUR    X11, [X1, 16] //stores 3rd component of vec1 in X11
LDUR    X22, [X2, 16] //stores 3rd component of vec2 in X22

MUL     X4, X11, X22 //multiplies components of vec1 (X11) and vec2 (X22), stores it in X4
ADD     X5, X9, X4 //adds X9 (dot) and X4 (most recent product), stores it in X5
MOV     X9, X5 //moves X5 data (FINAL DOT PRODUCT) to X9

STUR    X9, [X3] //moves the dot product value back to memory (address stored at X3)

MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */


.data
vec1:   .quad   10, 20, 30
vec2:   .quad   1, 2, 3
dot:    .quad   0

.end
