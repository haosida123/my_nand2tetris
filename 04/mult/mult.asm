// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.


// res=0, i=-R1
    @res
    M=0
    @R1
    D=M
    @i
    M=-D
    D=M
// while i<0{
(LOOP)
    @ENDLOOP
    D;JGE
//     res += R0
    @R0
    D=M
    @res
    M=D+M
//     i++
    @i
    M=M+1
    D=M

    @LOOP
    0;JMP
// }
(ENDLOOP)
// R2=res
    @res
    D=M
    @R2
    M=D
(END)
    @END
    0;JMP