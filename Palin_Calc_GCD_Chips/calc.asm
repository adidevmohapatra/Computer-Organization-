//Adidev Mohapatra 230007601

// File name: calc.asm

// The program develops a calculator application. 
// The operands a and b are integer numbers stored in RAM[0] (R0) and RAM[1] (R1), respectively.
// The operation choice c is stored in RAM[2] (R2), respectively
// if c == 1, do a + b
// if c == 2, do a - b
// if c == 3, do a * b
// if c == 4, do a / b
// For Addition and Subtraction operations the operands a and b can be positive or negative.
// For Multiplication operation only ONE operand can be negative.
// For Division operation BOTH operands must be positive and must be greater than 0.
// Store the final result (quotient for Division) in RAM[3] (R3). Only the Division operation 
// stores the remainder in RAM[4] (R4).


// Put your code below this line
///////////////////////////////////////////////////////
///goes in a queue of 1,2,3,4 to see which operation to use and go to the right label

//////D is treated like a pointer where it is cleared and given a value each time

@R2
D=M
//////////
@1
D=D-A
@Add
D;JEQ
//////////
@1
D=D-A
@Sub
D;JEQ
//////////
@1
D=D-A
@Mult
D;JEQ
//////////
@1
D=D-A 
@Div
D;JEQ
///////////////////////////////////////////////////////
(Add)
//Value of R0 taken and put into r3
D=0
@R0
D=M
@R3
M=D
@R1
D=M 
//r1 value being subtracted from the r3 value
@R3
D=D+M
M=D
@end
0;JMP
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
(Sub)
//Value of R0 taken and put into r3
D=0
@R0
D=M
@R3
M=D
@R1
D=M 
//r1 value being subtracted from the r3 value
@R3
D=M-D
M=D
@end
0;JMP
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
(Mult)
D=0
D=M
@negtracker
M=D

D=0
@R0
D=M
@valone//making a variable for r0 value to change later
M=D

D=0
@R1
D=M
@valtwo//making a variable for r1 value to change later
M=D

D=0
@R0
D=M 
@negone
D;JGT//Condition JGT to see if r0 was negative then go into label negative one
@negtracker
M=M+1//the tracker is now at 1 for negative numbers

(negone)
D=0
@R1
D=M 
@negtwo
D;JGT//Condition JGT to see if r1 was negative then go into label negative two
@negtracker
M=M+1//the tracker is now at 2 for negative numbers

//a switch is being done to make r1 the first value while the r0 is the second value to help multiply easier
D=0
@R1
D=M
@valone
M=D 
D=0
@R0
D=M 
@valtwo
M=D 


///Error due to there being two negative numbers
(negtwo)
D=0
@negtracker 
D=M 
@error//goes to error label all the way down to throw the -1
D=D-1
D;JGT 

/////Loop
D=0
@i//setting an i varaible to zero before loop
M=D
(loop)
    @valone
    D=M 
    @R3 //Stores the first value of r0 
    M=M+D 
    @i 
    M=M+1 //i acts like an iterator for r1 to go over and over again
    @i 
    D=M 
    @valtwo
    D=D-M //that number is 
    @loop
    D;JLT //Means that value of r1 is negative and jumps to the end and doesnt go to the loop
@end 
0;JMP

//////////////////////////////////////////////////////////////////////////////////////////////////////////////s

(Div)
////Keeps a tracker of the negative numbers from r0&r1
D=0
@negtracker
M=D

D=0
@R0
D=M 
@neg1
D;JGT//Jumps if the number is negative to negative case 
@negtracker
M=M+1//adds to the tracker for 1

(neg1)
D=0
@R1
D=M 
@neg2
D;JGT 
@negtracker
M=M+1//adds to tracker for 2

(neg2)
D=0
@negtracker
D=M 
@error//error if the tracker hits a negative number
D;JGT//if positive it continues
D = 0
@R0
D=M 
@R1 
D=D-M
D=D+1
@2
D=D-A
D=D+1

@negremainder ///jumps to the remainder function if the value is positive 
D;JGE 

///program at this point essentially goes to the end if the remainder is not a factor in the problem
@R3
D=0 
M=0 
@R0 
D=M 
@R4
M=D 
D=0
@end
0;JMP 


(negremainder)
D=0
@R0 
D=M 
@R4
M=D//sets r4 to the remainder found when floor dividing essentially

D=0
@i //setting i as an iterator to go over and over again
M=D
////loop
(loopdivision)
    @R1 
    D=M 
    @R4 
    M=M-D 
    @i 
    M=M+1 //i++ essetially 
    D=0
    @R1 
    D=M 
    @R4
    D=D-M ///last digit plus the negative number gives the remainfer
    @loopdivision//calling it over and over again
    D;JLE ///jumps if the negative number is there 
    D=0
    @i 
    D=M 
    @R3
    M=D
    D=0 
@end //end of program
0;JMP


(error)//based on instructions from the lab acess @1024 and return a -1 error 
D=0
@1024
M=D
M=M-1
@end
0;JMP

(end)
@end
0;JMP