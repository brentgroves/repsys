#include <stdio.h>

int fib(int n){
    if(n == 0 || n == 1)
        return 1;
    else
        return fib(n - 1) + fib(n - 2);
}

int main(){
  // in this example main is not exported so it cannot be called from JS
    printf("Hello world!\n");
    int res = fib(5);
    printf("fib(5) = %d\n", res);
    return 0;
}
