//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.extern printf
.global _start

_start:
ADR     X1, starting //load address of starting in X1
LDR     X1, [X1] //load starting value in X1
ADR     X2, ending //load address of ending in X2
LDR     X2, [X2] //load ending value in X2

BL      range //branch and link to the recursive range functiom
B       END //once we return, branch to the end of the program!


range:
SUB     SP, SP, 24 //allocate 3 stack frames
STR     X1, [SP, 0] //store starting on stack...
STR     X2, [SP, 8] //...then store ending...
STR     LR, [SP, 16] //...and store return address

CMP     X1, X2 //base case, compare starting and ending
B.EQ    return //if they are equal, branch to retrun!

ADR     X0, outstr //else, load address of outstr to X0 (for printf)
MOV     X21, X1 //move to X21 to preserve
MOV     X22, X2 //move to X22 to preserve
BL      printf //print the current starting!
MOV     X1, X21 //move back
MOV     X2, X22 //move back
ADD     X1, X1, 1 //increment starting by 1
BL      range //recursive call

    return:
LDR     X1, [SP, 0] //load back the starting value from the stack...
LDR     X2, [SP, 8] //...then load ending...
LDR     LR, [SP, 16] //...and load return address
ADD     SP, SP, 24 //deallocate
RET //return to return address in LR




END:
MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */


.data
starting:   .quad 10
ending:     .quad 15
outstr:     .string "%ld\n"

.end
