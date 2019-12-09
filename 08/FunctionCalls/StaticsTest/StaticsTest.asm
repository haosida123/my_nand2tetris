   @261
   D=A
   @SP
   M=D
   @Sys.init
   0;JMP
(StaticsTest.Class1.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/StaticsTest/Class1.vm
// Stores two supplied arguments in static[0] and static[1].
// function Class1.set 0
(Class1.set)
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
// pop static 0
   @SP
   AM=M-1
   D=M
   @StaticsTest.Class1.0
   M=D
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
// pop static 1
   @SP
   AM=M-1
   D=M
   @StaticsTest.Class1.1
   M=D
// push constant 0
   @0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// return
   @LCL
   D=M
   @StaticsTest.Class1$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @StaticsTest.Class1$tmp_ret
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
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @StaticsTest.Class1$tmp_ret
   A=M
   0;JMP
// Returns static[0] - static[1].
// function Class1.get 0
(Class1.get)
// push static 0
   @StaticsTest.Class1.0
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// push static 1
   @StaticsTest.Class1.1
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
   @StaticsTest.Class1$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @StaticsTest.Class1$tmp_ret
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
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @StaticsTest.Class1$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @StaticsTest.Class1$tmp_ret
   A=M
   0;JMP
(StaticsTest.Class2.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/StaticsTest/Class2.vm
// Stores two supplied arguments in static[0] and static[1].
// function Class2.set 0
(Class2.set)
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
// pop static 0
   @SP
   AM=M-1
   D=M
   @StaticsTest.Class2.0
   M=D
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
// pop static 1
   @SP
   AM=M-1
   D=M
   @StaticsTest.Class2.1
   M=D
// push constant 0
   @0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// return
   @LCL
   D=M
   @StaticsTest.Class2$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @StaticsTest.Class2$tmp_ret
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
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @StaticsTest.Class2$tmp_ret
   A=M
   0;JMP
// Returns static[0] - static[1].
// function Class2.get 0
(Class2.get)
// push static 0
   @StaticsTest.Class2.0
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
// push static 1
   @StaticsTest.Class2.1
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
   @StaticsTest.Class2$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @StaticsTest.Class2$tmp_ret
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
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @StaticsTest.Class2$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @StaticsTest.Class2$tmp_ret
   A=M
   0;JMP
(StaticsTest.Sys.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/StaticsTest/Sys.vm
// Tests that different functions, stored in two different 
// class files, manipulate the static segment correctly. 
// function Sys.init 0
(Sys.init)
// push constant 6
   @6
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 8
   @8
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// call Class1.set 2
   @Class1.set$ret.0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
   
   @LCL
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @ARG
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THIS
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THAT
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @5
   D=A
   @2
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Class1.set
   0;JMP
(Class1.set$ret.0)
// pop temp 0 // Dumps the return value
   @SP
   AM=M-1
   D=M
   @5
   M=D
// push constant 23
   @23
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 15
   @15
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// call Class2.set 2
   @Class2.set$ret.0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
   
   @LCL
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @ARG
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THIS
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THAT
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @5
   D=A
   @2
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Class2.set
   0;JMP
(Class2.set$ret.0)
// pop temp 0 // Dumps the return value
   @SP
   AM=M-1
   D=M
   @5
   M=D
// call Class1.get 0
   @Class1.get$ret.0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
   
   @LCL
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @ARG
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THIS
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THAT
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @5
   D=A
   @0
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Class1.get
   0;JMP
(Class1.get$ret.0)
// call Class2.get 0
   @Class2.get$ret.0
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
   
   @LCL
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @ARG
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THIS
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @THAT
   D=M
   @SP
   M=M+1
   A=M-1
   M=D
   @5
   D=A
   @0
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Class2.get
   0;JMP
(Class2.get$ret.0)
// label WHILE
(StaticsTest.Sys.WHILE)
// goto WHILE
   @StaticsTest.Sys.WHILE
   0;JMP
