(StackTest.vm)
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/07/StackArithmetic/StackTest/StackTest.vm
// Executes a sequence of arithmetic and logical operations
// on the stack. 
// push constant 17
   @17
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 17
   @17
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// eq
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$EQ_TRUE_0
   D;JEQ
   @bool
   M=0
(StackTest$EQ_TRUE_0)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 17
   @17
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 16
   @16
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// eq
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$EQ_TRUE_1
   D;JEQ
   @bool
   M=0
(StackTest$EQ_TRUE_1)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 16
   @16
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 17
   @17
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// eq
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$EQ_TRUE_2
   D;JEQ
   @bool
   M=0
(StackTest$EQ_TRUE_2)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 892
   @892
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 891
   @891
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// lt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$LT_TRUE_0
   D;JLT
   @bool
   M=0
(StackTest$LT_TRUE_0)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 891
   @891
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 892
   @892
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// lt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$LT_TRUE_1
   D;JLT
   @bool
   M=0
(StackTest$LT_TRUE_1)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 891
   @891
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 891
   @891
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// lt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$LT_TRUE_2
   D;JLT
   @bool
   M=0
(StackTest$LT_TRUE_2)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 32767
   @32767
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 32766
   @32766
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// gt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$GT_TRUE_0
   D;JGT
   @bool
   M=0
(StackTest$GT_TRUE_0)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 32766
   @32766
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 32767
   @32767
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// gt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$GT_TRUE_1
   D;JGT
   @bool
   M=0
(StackTest$GT_TRUE_1)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 32766
   @32766
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 32766
   @32766
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// gt
   @bool
   M=-1
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
   @StackTest$GT_TRUE_2
   D;JGT
   @bool
   M=0
(StackTest$GT_TRUE_2)
   @bool
   D=M
   @SP
   A=M-1
   M=D
// push constant 57
   @57
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 31
   @31
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// push constant 53
   @53
   D=A
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
// push constant 112
   @112
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
// neg
   @SP
   A=M-1
   M=-M
// and
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D&M
// push constant 82
   @82
   D=A
   @SP
   M=M+1
   A=M-1
   M=D
// or
   @SP
   AM=M-1
   D=M
   A=A-1
   M=D|M
// not
   @SP
   A=M-1
   M=!M
