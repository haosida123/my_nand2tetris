   @261
   D=A
   @SP
   M=D
   @Sys.init
   0;JMP
(FibonacciElement.Main.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/FibonacciElement/Main.vm
// Computes the n'th element of the Fibonacci series, recursively.
// n is given in argument[0].  Called by the Sys.init function 
// (part of the Sys.vm file), which also pushes the argument[0] 
// parameter before this code starts running.
// function Main.fibonacci 0
(Main.fibonacci)
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
// push constant 2
   @2
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// lt                     // checks if n<2
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @FibonacciElement.Main$LT_TRUE_0
   D;JLT
   @bool
   M=0
(FibonacciElement.Main$LT_TRUE_0)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// if-goto IF_TRUE
   @SP
   AM=M-1
   D=M
   @Main.fibonacci$JMP_0
   D;JEQ
   @FibonacciElement.Main.IF_TRUE
   0;JMP
(Main.fibonacci$JMP_0)
// goto IF_FALSE
   @FibonacciElement.Main.IF_FALSE
   0;JMP
// label IF_TRUE          // if n<2, return n
(FibonacciElement.Main.IF_TRUE)
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
// return
   @LCL
   D=M
   @FibonacciElement.Main$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @FibonacciElement.Main$tmp_ret
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
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @FibonacciElement.Main$tmp_ret
   A=M
   0;JMP
// label IF_FALSE         // if n>=2, returns fib(n-2)+fib(n-1)
(FibonacciElement.Main.IF_FALSE)
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
// push constant 2
   @2
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
// call Main.fibonacci 1  // computes fib(n-2)
   @Main.fibonacci$ret.0
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
   @1
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Main.fibonacci
   0;JMP
(Main.fibonacci$ret.0)
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
// call Main.fibonacci 1  // computes fib(n-1)
   @Main.fibonacci$ret.1
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
   @1
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Main.fibonacci
   0;JMP
(Main.fibonacci$ret.1)
// add                    // returns fib(n-1) + fib(n-2)
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D+M
// return
   @LCL
   D=M
   @FibonacciElement.Main$tmp_addr
   M=D
   @5
   A=D-A
   D=M
   @FibonacciElement.Main$tmp_ret
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
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @THAT
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @THIS
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @ARG
   M=D
   @FibonacciElement.Main$tmp_addr
   AM=M-1
   D=M
   @LCL
   M=D
   @FibonacciElement.Main$tmp_ret
   A=M
   0;JMP
(FibonacciElement.Sys.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/FibonacciElement/Sys.vm
// Pushes a constant, say n, onto the stack, and calls the Main.fibonacii
// function, which computes the n'th element of the Fibonacci series.
// Note that by convention, the Sys.init function is called "automatically" 
// by the bootstrap code.
// function Sys.init 0
(Sys.init)
// push constant 4
   @4
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// call Main.fibonacci 1   // computes the 4'th fibonacci element
   @Main.fibonacci$ret.2
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
   @1
   D=D+A
   @SP
   D=M-D
   @ARG
   M=D
   @SP
   D=M
   @LCL
   M=D
   @Main.fibonacci
   0;JMP
(Main.fibonacci$ret.2)
// label WHILE
(FibonacciElement.Sys.WHILE)
// goto WHILE              // loops infinitely
   @FibonacciElement.Sys.WHILE
   0;JMP
