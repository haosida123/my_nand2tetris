(BasicTest.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/07/MemoryAccess/BasicTest/BasicTest.vm
// Executes pop and push commands using the virtual memory segments.
// push constant 10
   @10
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop local 0
   @LCL
   D=M
   @0
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// push constant 21
   @21
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 22
   @22
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop argument 2
   @ARG
   D=M
   @2
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// pop argument 1
   @ARG
   D=M
   @1
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// push constant 36
   @36
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop this 6
   @THIS
   D=M
   @6
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// push constant 42
   @42
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 45
   @45
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop that 5
   @THAT
   D=M
   @5
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// pop that 2
   @THAT
   D=M
   @2
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// push constant 510
   @510
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop temp 6
   @5
   D=A
   @6
   D=A+D
   @BasicTest$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicTest$tmp_addr
   A=M
   M=D
// push local 0
   @LCL
   D=M
   @0
   A=A+D
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// push that 5
   @THAT
   D=M
   @5
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
// push argument 1
   @ARG
   D=M
   @1
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
// push this 6
   @THIS
   D=M
   @6
   A=A+D
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// push this 6
   @THIS
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
// sub
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
// push temp 6
   @5
   D=A
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
