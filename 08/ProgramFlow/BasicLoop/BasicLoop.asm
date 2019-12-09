(BasicLoop.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/ProgramFlow/BasicLoop/BasicLoop.vm
// Computes the sum 1 + 2 + ... + argument[0] and pushes the 
// result onto the stack. Argument[0] is initialized by the test 
// script before this code starts running.
// push constant 0
   @0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// pop local 0         // initializes sum = 0
   @LCL
   D=M
   @0
   D=A+D
   @BasicLoop$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicLoop$tmp_addr
   A=M
   M=D
// label LOOP_START
(BasicLoop.LOOP_START)
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
// add
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D+M
// pop local 0	        // sum = sum + counter
   @LCL
   D=M
   @0
   D=A+D
   @BasicLoop$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicLoop$tmp_addr
   A=M
   M=D
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
// push constant 1
   @1
   D=A
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
// pop argument 0      // counter--
   @ARG
   D=M
   @0
   D=A+D
   @BasicLoop$tmp_addr
   M=D
   @SP
   AM=M-1
   D=M
   @BasicLoop$tmp_addr
   A=M
   M=D
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
// if-goto LOOP_START  // If counter > 0, goto LOOP_START
   @SP
   AM=M-1
   D=M
   @BasicLoop$JMP_0
   D;JEQ
   @BasicLoop.LOOP_START
   0;JMP
(BasicLoop$JMP_0)
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
