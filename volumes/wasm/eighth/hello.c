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
    printf("WASM is running!");
    emscripten_run_script("alert('I have been called from C!')");
    // emscripten_run_script("set_background_color(1)");
    return 0;
}

