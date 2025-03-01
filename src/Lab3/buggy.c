#include "buggy.h"


void init(int* arr, int size, int* counter) {
	for (int i = 0; i < size; i ++) {
		arr[i] = 0;
	}
	(*counter) = 0;
}

void add(int* arr, int i, int count) {
	arr[count] = i; //removed the '++', which would start by placing '0' at the 2nd position (index 1)
}

void print_array(int* arr, int count) {
	for (int i = 0; i <= count; i ++) //changed to be '<=', since at the end of array count would be 19 and wont print last element properly (caused a delay in other elements being printed out earlier too)
		printf("%d ", arr[i]);
	printf("\n");
}

int contains(int* arr, int count, int target) {

	int i;
	for (i = 0; i < count; i++) { //changed the syntax (no semicolon, and ++ after the i)
		if (arr[i] == target)
			return 1;
		//else
			//return 0; //removed, would always hit 0 and return 0 for the function
	}
	return 0;
}
