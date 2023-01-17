//Adidev Mohapatra 230007601

// File name: palin.asm

// The program develops a Palindrome checker application. 
// The input to the program is a 5 digit integer A and is stored in RAM[0] (R0).
// A helper value of 10 is stored in RAM[8] (R8) by virtue of the tst file command.
// Number A is a positive integer.
// A has exactly 5 digits and no more no less.

// Program functions as follows: 
// Extract the individual digits from number A and store them in R2-R6 registers in that order.
// Result of 1 is stored in R1 if the number A is a Palindrome else result of 0 is stored in R1

// Put your code below this line

//////////Taking the value of r0 and storing it at a variaable 
D=0
@R0
D=M//accessing r0 value
@storenum
M=D//copying the r0 value

D=0
@R2
D=A
@placement//place holder check 
M=D
//////////////////////////////////////////////////////////////////////////////////////////////////
//Here the digits are being removed and placed from r2-r6 in the right registers as a function basically
(digitextraction)
@quotient
M=0
@digit///takes out the digit 
M=0
D=M
///////////////////////////////////////////////////////
/////loop needed to get the r2-r6 in the right places 
(loop)
    D=0
    @storenum//takes in the stored value
    D=M
    @R8
    D=D-M

    @quotient
    M=M+1

    @breakloop//loop breaks if 0 is equal
    D;JEQ
    @remainder//or else remainder label is accesed
    D;JLT
    @storenum//store num takes value from the D abovr
    M=D
    D=0
    
    @loop//iterates
    0;JMP
(breakloop)
////empty so loop is broken
//////////////////////////////////////////////////////////////////////////////////////////////////
//where the digits are being places in the respective r address
D=0
@placement
D=M
@R7
D=D-A
@endextraction///extraction finished as all digits set
D;JEQ
D=0
@digit//get value 
D=M
@placement//placed 
A=M
M=D
D=1
@placement//placed
M=D+M
D=0
@quotient
D=M
@storenum
M=D
@endextraction///extraction finished as all digits set
D;JEQ
D=0
@digitextraction//unconditional jump to go to extraction if everything is not set
0;JMP


(remainder)

@quotient
M=M-1
@storenum////////the remainder from the quotient goes the digit
D=M
@digit
M=D
@breakloop
0;JMP


(endextraction)
//empty to signal end of extraction

////////////////////////////////////////////////////////////////////////////////////////////////
///purpose here is to check if the numbers come out to be the same 
///r4 is ignored due to being the middle value
@R3
D=M//extracting the value of r3
@R5
D=D-M//taking value from r5 and subtracting it from r3
@end
D;JNE//if not 0 then go to r1 to show palindrome,else program ends
D=0

@R2
D=M//extracting the value of r2
@R6
D=D-M//taking value from r6 and subtracting it from r2
@end
D;JNE//if not 0 then go to r1 to show palindrome,else program ends
D=0

@R1
M=1
////////////////////////////////////////////////////////////////////////////////////////////////
//end of program
(end)
@end
0;JMP