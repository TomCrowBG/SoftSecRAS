#include <stdint.h>
#include <stdio.h>

int main(void) {
    uint64_t num1 = 0xFFFFFFFFFFFFFFFF, num2 = 0xFFFFFFFFFFFFFFFF, output = 0;
    printf("RISC-V packed addition using %LX and %LX\n", num1, num2);

    printf("Output is %LX \n", output);
    if (output == num1 + num2){
        printf("Test passed! \n");
    }
    
    return 0;
}