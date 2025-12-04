#include <stdio.h>

// int EMSCRIPTEN_KEEPALIVE fib(int n){

int fib(int n){
    if(n == 0 || n == 1)
        return 1;
    else
        return fib(n - 1) + fib(n - 2);
}

int main(){
    printf("Hello world!\n");
    int res = fib(6);
    printf("fib(6) = %d\n", res);
    return 0;
}
