//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.extern printf
.global _start

_start:

//LOADING
ADR     X0, arr //loads the base memory address of arr to X0
ADR     X1, length //loads the memory address of length to X1
LDUR    X1, [X1] //loads the length into X1
ADR     X2, target //loads the memeory address of target to X2
LDUR    X3, [X2] //loads the target value into X3

//INITIAL INDEX CALCULATIONS
MOV     X10, 0 //X10 will represent the lower index
MOV     X12, X1 //X12 will represent the upper index
SUB     X12, X12, 1 //subtracting 1 to get in index (in previous line, we moved the length to X12, so now we have to subtract by 1)
ADD     X11, X10, X12 //X11 will represent the middle index of the array (where we split the array in half for binary search) (currently, this is the sum of the lower and upper indexes)
LSR     X11, X11, 1 //logical right shift of 1 will divide X11 by 2, and give us the middle index of the array

//BINARY SEARCH ALGORITHM
START:
CMP     X10, X12 //comparing the lower and upper indexes
B.GT    NOTFOUND //if lower index (X10) is greater than upper index (X12), then go to NOTFOUND
LSL     X14, X11, 3 //logical left shift of 3 to multiply the middle index by 3 (since we are working with .quad 8 byte numbers), stores result in X14
ADD     X15, X0, X14 //adds the middle index to the base address of arr, and stores the result in X15
LDUR    X20, [X15] //loads the integer stored at the middle index of the array into X20
CMP     X3, X20 //compares the target value (X3) with the current value at the middle of the array (X20)
B.EQ    FOUND //if the target and current middle value are equal, then go to FOUND

B.LT    LESS //else if the target is less than the current middle value, then go to LESS

ADD     X11, X11, 1 //else if the target is greater than the current middle value, increment middle index by 1
MOV     X10, X11 //make the current middle index (X11) the new lower index (X10)
ADD     X11, X10, X12 //adding the new lower and higher indexes together, storing result in X11
LSR     X11, X11, 1 //logical right shift of 1 will divide X11 by 2, and give us new middle index in X11
B       START //loop back to START to repeat binary search process on smaller array!

LESS:
SUB     X11, X11, 1 //decrement middle index by 1
MOV     X12, X11 //make the current middle index (X11) the new upper index (X12)
ADD     X11, X10, X12 //adding the new lower and higher indexes together, storing result in X11
LSR     X11, X11, 1 //logical right shift of 1 will divide X11 by 2, and give us new middle index in X11
B       START //loop back to START to repeat binary search process on smaller array!

NOTFOUND:
ADR     X0, msg2 //load address of msg2 (NOT in the array) into X0
ADR     X1, target //load address of target to X1
LDUR    X1, [X1] //loads value of target to X1
BL      printf //printing that the target is NOT in the array :(
B       END //end program

FOUND:
ADR     X0, msg1 //load address of msg1 (in the array) into X0
ADR     X1, target //load address of target to X1
LDUR    X1, [X1] //loads value of target to X1
BL      printf //printing that the target is in the array!
B       END //end program

END:
MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */



.data
arr:    .quad   -40, -25, -1, 0, 100, 300
length: .quad   6
target: .quad   -25
msg1:   .string "Target %ld is in the array.\n"
msg2:   .string "Target %ld is not in the array.\n"

.end
