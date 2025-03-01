//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:
//file reading stuff here
MOV     X5, 0 //length counter
ADR     X1, buffer //setting buf

input:
MOV     X0, 0 //fd = 0
MOV     X2, 1 //nbyte = 1 (we are reading one byte at a time)
MOV     X8, 63 //syscall = 63 (read!)
SVC     0 //system call!
LDR     X3, [X1, 0] //load the address of the buffer
CMP     X3, #10 //comparing to \n
B.EQ    endloop //exit the loop if we reach \n
ADD     X5, X5, 1 //counting the length
ADD     X1, X1, 1 //incrementing X1 (address of string in memory) for the next character to be stored
B       input //loop!

endloop:
//X5 = length
//X1 = base address of the string
//X0 = result
MOV     W0, 0 //moving 0 to the result
MOV     W10, 1 //X10 will be powers of 10
MOV     W15, 10 //for multiplying powers of 10
SUB     X1, X1, 1 //decrement address by 1 so that we can move past the \n character

convert:
CBZ     X5, WRITE //go to WRITE if no length
LDRB    W11, [X1, 0] //loads current character to X11, using length (X5) as our current offset (decrements as we go) //TODO
SUB     W11, W11, 48 //converts from ascii value to integer value
MUL     W11, W11, W10 //multiply the current character by power of 10
MUL     W10, W10, W15 //W10*=10 (next power of 10)
ADD     W0, W0, W11 //adds value of current character to the result
SUB     X5, X5, 1 //decrement the length
SUB     X1, X1, 1 //decrement the base address of the string
B       convert //loop!

// ^^^code from lab 11 for reading





// vvv new code for printing (it is very scuffed i'm so sorry)
WRITE:
MUL     W22, W0, W0 //W22 = x^2 (we will use w22 for fidning the number of digits in the square)
MOV     X6, 0 //counter for new length of x^2
MOV     W10, 1 //powers of 10 (used later to extract each digit)
MUL     W20, W0, W0 //W20 = x^2 (for use in the later loop)

ADR     X1, output
len_loop:
UDIV    W22, W22, W15 //integer division of W22 by W15 (dividing by 10 each time)
ADD     X6, X6, 1 //increment the length
CBZ     W22, wri //if W22 = 0 (integer division by 10 yielded 0, and we are at the 1's place of x^2), then stop counting length and branch to wri
MUL     W10, W10, W15 //else, W10 * 10 (to get a new power of 10)
B       len_loop //Loop!

wri:
UDIV    W21, W20, W10 //extracting the current digit from x^2 by integer division by 10
ADD     W21, W21, 48 //add 48 to the value of that digit (ASCII)
STR     W21, [X1, 0] //store that value at the address of the output in memory
SUB     W21, W21, 48 //un-ASCII
MUL     W21, W21, W10 //to update for next loop
SUB     W20, W20, W21 //subtract to move on to the next digit
ADD     X1, X1, 1 //increase the address of the output that we will store to
SUB     X6, X6, 1 //decrement the length
CBZ     X6, write1 //if length = 0, then we stop looping and start printing! (we have extracted all of the digits and will start printing)
UDIV    W10, W10, W15 //setting next lowest power of 10
B       wri //else, loop!
write1:
MOV     W21, #10 //newline character
STR     W21, [X1, 0] //write newline character to be the last character in the output
ADR     X1, output //reset the address (set X1 to be base address of counter)
write_loop:
MOV     X0, 1 //fd = 1
MOV     X2, 1 //nbytes = 1
MOV     X8, 64 //syscall = write!!!
SVC     0 //system call time!!! :)
LDR     X3, [X1, 0] //load the current address of the output
CMP     X3, #10 //comparing with \n
B.EQ    END //end the program once we reach the newline character
ADD     X1, X1, 1 //increment the base address by 1 (store the next byte at the next address of output)
B       write_loop //loop!

END: //syscall to invoke end of program (I definitely know what this means now!)
MOV     X0, 0
MOV     X8, 93
SVC     0


.bss
buffer: .skip 8 //allocating memory for the buffer
output: .skip 8 //the destination of the output string
