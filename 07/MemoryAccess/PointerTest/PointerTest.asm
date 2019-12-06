// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/07/MemoryAccess/PointerTest/PointerTest.vm
// Executes pop and push commands using the 
// pointer, this, and that segments.
// push constant 3030
   @3030
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop pointer 0
   @SP
   AM=M-1
   D=M
   @THIS
   M=D
// push constant 3040
   @3040
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop pointer 1
   @SP
   AM=M-1
   D=M
   @THAT
   M=D
// push constant 32
   @32
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop this 2
   @THIS
   D=M
   @2
   D=A+D
   @tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @tmp_addr
   A=M
   M=D
// push constant 46
   @46
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop that 6
   @THAT
   D=M
   @6
   D=A+D
   @tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @tmp_addr
   A=M
   M=D
// push pointer 0
   @THIS
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// push pointer 1
   @THAT
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// add
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D+M
// push this 2
   @THIS
   D=M
   @2
   A=A+D
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// sub
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
// push that 6
   @THAT
   D=M
   @6
   A=A+D
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// add
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D+M
(END)
   @END
   0;JMP
