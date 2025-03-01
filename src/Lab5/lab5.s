//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:

//LOADING MEMORY ADDRESSES
ADR     X11, p1 //address of p1 stored in X12
ADR     X12, p2 //address of p2 stored in X12
ADR     X13, p3 //address of p3 stored in X13

//STORING POINT VALUES
LDUR    X4, [X11] //stores p1-x in X4
LDUR    X5, [X12] //stores p2-x in X5
LDUR    X6, [X13] //stores p3-x in X6
LDUR    X14, [X11, 8] //stores p1-y in X14
LDUR    X15, [X12, 8] //stores p2-y in X15
LDUR    X16, [X13, 8] //stores p3-y in X16

//COMPUTATIONS FOR SQUARE OF LENGTH BETWEEN p1 AND p3 (side c)
SUB     X7, X6, X4 //subtracts p3-x from p1-x, stores the result in X7
MUL     X7, X7, X7 //computes the square of the previous result, stores it in X7
SUB     X8, X16, X14 //subtracts p3-y from p1-y, stores the result in X8
MUL     X8, X8, X8 //computes the square of the previous result, stores it in X8
ADD     X21, X7, X8 //adds the squares (now equal to the distance squared between p1 and p3), and stores it in X21

//COMPUTATIONS FOR SQUARE OF LENGTH BETWEEN p1 AND p2 (side a)
SUB     X7, X5, X4 //subtracts p2-x from p1-x, stores the result in X7
MUL     X7, X7, X7 //computes the square of the previous result, stores it in X7
SUB     X8, X15, X14 //subtracts p2-y from p1-y, stores the result in X8
MUL     X8, X8, X8 //computes the square of the previous result, stores it in X8
ADD     X22, X7, X8 //adds the squares (now equal to the distance squared between p1 and p2), and stores it in X22

//COMPUTATIONS FOR SQUARE OF LENGTH BETWEEN p2 AND p3 (side b)
SUB     X7, X6, X5 //subtracts p3-x from p2-x, stores the result in X7
MUL     X7, X7, X7 //computes the square of the previous result, stores it in X7
SUB     X8, X16, X15 //subtracts p3-y from p2-y, stores the result in X8
MUL     X8, X8, X8 //computes the square of the previous result, stores it in X8
ADD     X23, X7, X8 //adds the squares (now equal to the distance squared between p2 and p3), and stores it in X23

//CONDITIONALS
ADD     X24, X22, X23 //adds the squares of sides a and b, stores the sum in X24
ADD     X25, X23, X21 //adds the squares of sides b and c, stores the sum in X25
ADD     X26, X22, X21 //adds the squares of sides a and c, stores the sum in X26


CMP     X21, X24 //compares the square of c with the sum of the squares of sides a and b (is a^2 + b^2 = c^2 ????)
B.EQ    YES //if equal, go to the yes label

CMP     X22, X25 //compares the square of a with the sum of the squares of sides b and c (is b^2 + c^2 = a^2 ????)
B.EQ    YES //if equal, go to the yes label

CMP     X23, X26 //compares the square of b with the sum of the squares of sides a and c (is a^2 + c^2 = b^2 ????)
B.EQ    YES //if equal, go to the yes label

ADR     X1, no //else, load address of yes to X1
B       DONE //then go to the done label (end the program)

YES:
ADR     X1, yes //if equal, load address of yes to X1

DONE:
MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */



.data
p1:     .quad   1, 2
p2:     .quad   2, 3 //these three points will not form a right triangle
p3:     .quad   3, 1
yes:    .string "It is a right triangle."
no:     .string "It is not a right triangle."

.end
