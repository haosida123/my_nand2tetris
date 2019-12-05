// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
        // white()
    @WHITE
    0;JMP
    // @addr
        // while true{
(LOOP)
        //     if key{
        //         black();
        //     }
        //     else{
        //         white();
        //     }
    @KBD
    D=M
    @BLACK
    D;JNE
    @WHITE
    0;JMP
        // }
        // black(){
(BLACK)
        //     if screen[0]==-1 return;
    @SCREEN
    D=M+1
    @LOOP
    D;JEQ
        //     i = 0;
        //     do while i < 8191 {
        //         screen[i] = -1;
        //         i++
        //     }
    @i
    M=0
(LOOPBLACK)
    @i
    D=M
    @SCREEN
    A=D+A
    M=-1
    
    @i
    M=M+1
    D=M
    @8191
    D=D-A
    @LOOP
    D;JGT
    @LOOPBLACK
    0;JMP
        // }
        // return
        // white(){
(WHITE)
        //     if screen[0]==0 return;
    @SCREEN
    D=M
    @LOOP
    D;JEQ
        //     i = 0;
        //     do while i < 8191 {
        //         screen[i] = 0;
        //         i++
        //     }
        //     return
    @i
    M=0
(LOOPWHITE)
    @i
    D=M
    @SCREEN
    A=D+A
    M=0
    
    @i
    M=M+1
    D=M
    @8191
    D=D-A
    @LOOP
    D;JGT
    @LOOPWHITE
    0;JMP
        // }
        // end(){}
(END)
    @END
    0;JMP