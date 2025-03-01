//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.extern printf
.global _start

_start:

ADR     X1, arr //loads the base address of arr in X1
ADR     X2, length //loads the base address of length in X2
LDR     X2, [X2] //loads the value of length into X2
MOV     X3, 0 //counter for length of array
LDR     X4, [X1] //X4 will store the current max number (load the first element in the array, for now)
MOV     X24, X4 //move to safe register

BL      findmax //branch/link to our recursive function
B       END //branch to end (to print and end the program!)



findmax:
SUB     SP, SP, 40 //allocate 5 stack frames
STR     X1, [SP, 0] //store the array address on the stack,,,
STR     X2, [SP, 8] //...then store the array length...
STR     X3, [SP, 16] //...then store the current counter...
STR     X4, [SP, 24] //...then store the current max number...
STR     LR, [SP, 32] ///...and store the return address

CMP     X2, X3 //compare the length with the counter
B.EQ    return //base case, if length==counter, return (we have gone through the whole array)

LSL     X10, X3, 3 ///else, left shift the current counter by 3 (i.e multiply by 8 for offest in the array), store in X10
LDR     X14, [X1, X10] //load the element in the array at the current offset into X14
CMP     X14, X4 //compare the element with the current max
B.LE    no_change //if the element is less than or the same as the current max, branch to no_change
MOV     X4, X14 //else, move the current element into X4 to make it the new current max
MOV     X24, X4 //move to X24 to preserve

    no_change:
ADD     X3, X3, 1 //increment the counter by 1
BL      findmax //recursive call

    return:
LDR     X1, [SP, 0] //load back the array address from the stack...
LDR     X2, [SP, 8] //...then load the array length...
LDR     X3, [SP, 16] //...then load the current counter...
LDR     X4, [SP, 24] //...then load the current max number...
LDR     LR, [SP, 32] //...and load the return address
ADD     SP, SP, 40 //deallocate
RET //return to the return address in LR



END:
ADR     X0, outstr //loads the base address of outstr in X0
MOV     X1, X24 //move the final max value to X1
BL      printf //print the max value!

MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */



.data 
arr:    .quad -10, 23, -100, 124, 66, 12
length: .quad 6
outstr: .string "%ld\n"

.end 
