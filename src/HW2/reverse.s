//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:

//REVERSING ALL OF THE BYTES IN THE ARRAY (by loading first and last bytes to registers, swapping them to each other's memory addresses, and repeating the process moving inwards)
ADR     X0, arr //loads the base memory address of arr into X0
ADR     X1, length //loads the base memory address of length into X1
LDUR    X2, [X1] //loads the length into X2
LSL     X2, X2, 2 //length*4, the total number of bytes
ADD     X2, X2, X0 //the address of the byte at the end of the array

START:
SUB     X2, X2, 1 //decrementing ending memory address by 1
CMP     X0, X2 //comparing the memory addresses for the start and end of the array
B.GT    END //if the starting memory address is greater than the ending address (i.e. we have reached the middle of the array and have swapped/reversed every digit), end the loop

LDURB   W10, [X0] //else, load the current first byte into W10
LDURB   W20, [X2] //load the current last byte into W20
STURB   W10, [X2] //stores the byte in W10 to memory address of X2 (swaps)
STURB   W20, [X0] //stores the byte in W20 to memory address of X0 (swaps, the current first and last digits are reversed!)
ADD     X0, X0, 1 //increment starting memory address by 1
B       START //loop back to the start!


//SWAPPING THE DIGITS IN EACH BYTE
END:
ADR     X0, arr //loads the base memory address of arr into X0
ADR     X1, length //loads the base memory address of length into X1
LDUR    X2, [X1] //loads the length into X2
LSL     X2, X2, 2 //length*4, the total number of bytes
MOV     X5, 0 //increment counter, to compare to the total number of bytes (X2), to know when we're at the end of the array


START1:
LDURB   W10, [X0] //loads the current byte into W10
CMP     X5, X2 //compares the counter with the total number of bytes (X2)
B.EQ    END1 //if the counter equals total number of bytes, end the program

AND     W11, W10, 0b1111 //extracts the rightmost nibble in the byte, stores it in W11
LSL     W11, W11, 4 //moves the extracted nibble left to be the next hex digit
LSR     W10, W10, 4 //logical right shift by 4, so that the next digit is the new rightmost
ORR     W20, W10, W11 //bitwise or of W10 and W11, which is the result of reversing the hex digits in one nibble, stores result in W20
STURB   W20, [X0] //stores the reversed nibbles (1 byte) back into the same spot in memory
ADD     X5, X5, 1 //increments the counter
ADD     X0, X0, 1 //increments the position in memeory
B       START1 //loop back to the start!








END1:
MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */


.data
arr:    .word   0x12BFDA09,0x9089CDBA,0x56788910
length: .word   3

.end
