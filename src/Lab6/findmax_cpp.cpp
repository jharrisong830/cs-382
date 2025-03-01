#include <iostream>
using namespace std;

int findmax(int arr[], int counter, int length, int curr_max) {
    if(counter==length) {
        return curr_max;
    }
    if(arr[counter]>curr_max) {
        curr_max=arr[counter];
    }
    return findmax(arr, counter+1, length, curr_max);
}

int main() {
    int arr[6]={-10, 23, -100, 124, 66, 12};
    int max=findmax(arr, 0, 6, arr[0]);
    cout<<max<<endl;
    return 0;
}