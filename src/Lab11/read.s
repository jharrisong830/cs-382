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
CBZ     X5, END //end if no length
LDRB    W11, [X1, 0] //loads current character to X11, using length (X5) as our current offset (decrements as we go) //TODO
SUB     W11, W11, 48 //converts from ascii value to integer value
MUL     W11, W11, W10 //multiply the current character by power of 10
MUL     W10, W10, W15 //W10*=10 (next power of 10)
ADD     W0, W0, W11 //adds value of current character to the result
SUB     X5, X5, 1 //decrement the length
SUB     X1, X1, 1 //decrement the base address of the string
B       convert //loop!



END: //syscall to invoke end of program (I kinda know what this means now!)
MOV     X0, 0
MOV     X8, 93
SVC     0


.bss
buffer: .skip 8 //allocating memory for the buffer
