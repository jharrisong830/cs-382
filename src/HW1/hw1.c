#include <stdio.h>

/*
John Graham
I pledge my honor that I have abided by the Stevens Honor System.
BUBBLE SORT - State the sorting algorithm you chose in task 3
YES - State if you want to be considered for bonus points in task 3
*/

/**creates a copy of a string*/
void strcpy(char* src, char* dst) {
    int counter=0; //initialize counter
L1: if(src[counter]=='\0') { //if no character at the position in the counter (end of string), then end the program
        goto L2;
    }
    else { //otherwise, store the character at the counter at the same position in dst
        dst[counter]=src[counter];
        counter++; //increment the counter
        goto L1; //loop!
    }
L2: //end
}

/**computes the dot product of two vectors*/
int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    int counter=0;
    int dot_prod=0;
    int* a;
    int* b;
    L1:
    if(counter==length) { //if we've reached the end of the array, then end the program
        goto L2;
    }
    else { //otherwise, take the componenets at the current value, multiply them, and add that value to dot_prod
        a=(int*)((vec_a+(size_elem*counter)));
        b=(int*)((vec_b+(size_elem*counter)));
        dot_prod+=(*a)*(*b);
        counter++; //increment the counter
        goto L1; //loop!
    }
    L2: //end
    return dot_prod;
}

void sort_nib(int* arr, int length) {
    int* sort[8*length]; //array of individual digits
    int curr_num=0; //used for converting into array of individual digits
    int swap; //for bubble sort

    //NORMAL LOOPS

    /*for(int i=0; i<length; i++) {
        curr_num=arr[i];
        for(int j=0; j<8; j++) {
            sort[j+(8*i)]=(curr_num&0b1111); //extracts the rightmost digit
            curr_num=curr_num>>4; //shifts so that the next digit is the new rightmost
        }
    }

    for(int i=0; i<(length*8)-1; i++) { //BUBBLE SORT algorithm
        for(int j=0; j<(length*8)-i-1; j++) {
            if(sort[j]>sort[j+1]) {
                swap=sort[j];
                sort[j]=sort[j+1];
                sort[j+1]=swap;
            }
        }
    }

    for(int i=0; i<length; i++) { //converts the sorted digits back into full hex numbers
        arr[i]=sort[i*8]; //sets the leftmost digit of a hex number
        for(int j=1; j<8; j++) {
            arr[i]=arr[i]<<4; //shifts the digit to the left
            arr[i]=arr[i]|(int)sort[j+(8*i)]; //puts the next digit behind the first
        }
    }*/

    //GOTO LOOPS

    int i=0;
    int j=0;

    L1: //uses binary operations to extract each hex digit and put it into the sort array
    curr_num=arr[i];
    L2:
    sort[j+(8*i)]=(curr_num&0b1111); //extracts the rightmost digit
    curr_num=curr_num>>4; //shifts so that the next digit is the new rightmost
    j++;
    if(j<8) {
        goto L2;
    }
    else {
        j=0;
        i++;
        if(i<length) {
            goto L1;
        }
        else {
            i=0;
            j=0;
            goto L3;
        }
    }


    L3: //BUBBLE SORT algorithm
    if(sort[j]>sort[j+1]) {
        swap=sort[j];
        sort[j]=sort[j+1];
        sort[j+1]=swap;
    }
    j++;
    if(j<(length*8)-i-1) {
        goto L3;
    }
    else {
        i++;
        if(i<(length*8)-1) {
            j=0;
            goto L3;
        }
        else {
            i=0;
            j=1;
            goto L4;
        }
    }




    L4: //converts the sorted digits back into full hex numbers
    arr[i]=sort[i*8]; //sets the leftmost digit of a hex number
    L5:
    arr[i]=arr[i]<<4; //shifts the digit to the left
    arr[i]=arr[i]|(int)sort[j+(8*i)]; //puts the next digit behind the first
    j++;
    if(j<8) {
        goto L5;
    }
    else {
        i++;
        if(i<length) {
            j=0;
            goto L4;
        }
        else {
            goto L6;
        }
    }

    L6: //end
}

int main() {

    char str1[] = "382 is the best!";
    char str2[100] = {0};

    strcpy(str1, str2);
    puts(str1);
    puts(str2);

    int vec_a[3] = {12,34,10};
    int vec_b[3] = {10,20,30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));

    printf("%d\n", dot);

    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr, 3);
    for (int i = 0; i < 3; i ++) {
        printf("0x%08x ", arr[i]);
    }
    puts("");

    return 0;
}