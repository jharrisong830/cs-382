//John Graham
//I pledge my honor that I have abided by the Stevens Honor System.

#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    int32_t num1;
    for(int i=32; i>0; i--) {
        num1=num;
        num1=num1>>i;
        if(num1&1==1) {
            display(1);
        }
        else {
            display(0);
        }
    }
    printf("\n");
}

int main(int argc, char const *argv[]) {
    display_32(382);
    return 0;
}
