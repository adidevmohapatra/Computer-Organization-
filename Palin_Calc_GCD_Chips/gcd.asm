//Adidev Mohapatra 230007601

// File name: gcd.asm

// This program calculates the greatest common divisor (gcd) of two given 
// non-negative integers, which are stored in RAM[0] (R0) and RAM[1] (R1). 
// The gcd is stored in RAM[2] (R2).



// Put your code below this line

//////D is treated like a pointer where it is cleared and given a value each time
D=0
@remainder//make a variable for the remainder to use according to Euclidean's algo
M=0
@R1
D=M//access the r1 value 
@R0
D=D-M//subtract the r0 value from r1
@regular
D;JGT//going to the regular label
////////////////////////////////////////////////////////////////////////////////////////////////
//if the case is not regular, then it is a other case where variables are needed
D=0
@R0
D=M
@a//a gets the value of r0
M=D
@R1
D=M
@b//b gets the value of r1
M=D
@other//////jumps to the other label
0;JMP
////////////////////////////////////////////////////////////////////////////////////////////////
(regular)
D=0
@R1
D=M
@a//a gets the value of r0
M=D

D=0
@R0
D=M
@b//b gets the value of r1
M=D

(other)
D=0
@a
D=M
@remainder
M=D//a passes its value to the remainder variable as a new value
////////////////////////////////////////////////////////////////////////////////////////////////
//a loop that goes on continously until a remainder of zero is found
//so a while loop is set but a modulo loop is needed in order for the number do keep getting the remainder
(whileloop)
    @a
    D=M
    @remainder//the remainder will go back to its label and call in the new values from the method
    M=D
        (modulo)//modulo loop used from the algorithm where you get the remainder of it 
        D=0
        @b
        D=M
        @remainder
        M=M-D//The remainder function called for b as the function is moving over 

        D=0
        @b
        D=M
        @remainder
        D=D-M
        @modulo//modulo fuction called again until the b is 0 or negative 
        D;JLT

        D=0
        @b//accessing the value of b
        D=M
        @a////copying the value of b so the algo moves on 
        M=D

        D=0
        @remainder//accessing the value of remainder
        D=M
        @b///copying the value of remainder so algo moves on
        M=D

        @b
        @whileloop
        D;JNE//If the value is not 0 then go back to the while loop 

        D=0
        @a
        D=M
        @R2
        M=D

//end of program
(end)
@end
0;JMP