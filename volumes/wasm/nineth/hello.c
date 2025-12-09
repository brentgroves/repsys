#include <time.h>   // for time
#include <stdlib.h> // for rand
#include <stdio.h>
#include <emscripten.h>

int fib(int n){
    if(n == 0 || n == 1)
        return 1;
    else
        return fib(n - 1) + fib(n - 2);
}

int set_background_color_from_c(int n){
    char *msgOut;
    asprintf(&msgOut, "set_background_color(%d)", n);
    emscripten_run_script(msgOut);
    free(msgOut);  
    return 0;
}

// EM_JS(void, set_background_color, (int color_idx), {
//     var color = "red";
//     if (color_idx == 1) color = "blue";
//     else if (color_idx == 2) color = "green";
//     else if (color_idx == 3) color = "grey";

//     document.body.style.backgroundColor = color; // set the new background color
// });



int main(){
    printf("WASM is running!\n");
    
    srand(time(NULL));      	// initialize random seed
    int color_idx = rand() % 3; // could be 0, 1 or 2
    
    EM_ASM(
        // here you can write inline javascript code!
        console.log("(1) I have been printed from inline JavaScript!");
        console.log("I have no parameters and I do not return anything :(");
        // end of javascript code
    );
        
    // note the underscore and the curly brackets (to pass one or more parameters)
    EM_ASM_({
        console.log("(2) I have received a parameter! It is:", $0);
        console.log("Setting the background to that color index!");
        set_background_color($0);
    }, color_idx);
        
    // note that you have to specify the return type after EM_ASM_
    int result = EM_ASM_INT({
        console.log("(3) I received two parameters! They are:", $0, $1);
        console.log("Let's return their sum!");
        return sum($0, $1);
    
        function sum(a, b){
            return a + b;
        }
    }, 13, 10);
    
    // note that you have to specify the return type after EM_ASM_
    // THIS DOES NOT WORK!
    // int result2 = EM_ASM_INT({
    //     set_background_color($0)

    //     console.log("(3) I received one parameter! It is:", $0);
    //     console.log("Setting the background to that color index!");
    // }, 3);


    set_background_color_from_c(3);
    printf("(4) The C code received %d as result!\n", result);
    
    return 0;
}