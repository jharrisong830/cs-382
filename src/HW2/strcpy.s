//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:

//LOADING MEMORY ADDRESSES
ADR     X0, src_str //loads the base memory address of src_str into X0
ADR     X1, dst_str //loads the base memory address of dst_str into X1
MOV     X4, 0 //to compare against X5 (CURR_CHAR) to see if we have reached the null terminator of the string

//LOOPS
START:
LDURB   W5, [X0] //loads 1 byte of src_str into X5 (CURR_CHAR)
CMP     X5, X4 //compare CURR_CHAR with 0
B.EQ    END //if CURR_CHAR==0, we've reached the end of the string, end the loop

STURB   W5, [X1] //else, store CURR_CHAR back into memory at the address of dst_str
ADD     X0, X0, 1 //increments the memory address of src_str by 1 (moves to the next char)
ADD     X1, X1, 1 //increments the memory address of dst_str by 1 (so that we can store the next char)
B       START //loop back to the start!




END:
MOV     X0, 0       /* status := 0 */
MOV     X8, 93      /* exit is syscall #1 */
SVC     0           /* invoke syscall */



.data
src_str: .string "I love 382 and assembly!" //source string

.bss
dst_str: .skip 100 //destination string

.end
