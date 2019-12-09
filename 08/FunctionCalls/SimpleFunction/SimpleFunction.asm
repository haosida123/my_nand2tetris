(SimpleFunction.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/SimpleFunction/SimpleFunction.vm
// Performs a simple calculation and returns the result.
// function SimpleFunction.test 2
(SimpleFunction.test)
   @SP
   M=M+1
   A=M-1
   M=0
   @SP
   M=M+1
   A=M-1
   M=0
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
// push local 1
   @LCL
   D=M
   @1
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
// not
   @SP
   A=M-1
   M=!M
// push argument 0
   @ARG
   D=M
   @0
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
// return
   @LCL
   D=M
   @SimpleFunction$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @SimpleFunction$tmp_ret
   M=D
   @SP
   AM=M-1
   D=M
   @ARG
   A=M
   M=D
   D=A+1
   @SP
   M=D
   @SimpleFunction$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @SimpleFunction$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @SimpleFunction$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @SimpleFunction$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @SimpleFunction$tmp_ret
   A=M
   0;JMP
