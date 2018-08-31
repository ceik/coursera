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


    @KBD
    D=M
    @BLACK
    D;JNE

(WHITE)
    @8191
    D=A
    @n
    M=D

(WFILL)
    @SCREEN
    D=A
    @n
    D=D+M
    M=M-1
    A=D
    M=0
    @n
    D=M
    @WFILL
    D;JGE

(WLOOP)
    @KBD
    D=M
    @BLACK
    D;JNE
    @WLOOP
    0;JMP



(BLACK)
    @8191
    D=A
    @n
    M=D

(BFILL)
    @SCREEN
    D=A
    @n
    D=D+M
    M=M-1
    A=D
    M=-1
    @n
    D=M
    @BFILL
    D;JGE


(BLOOP)
    @KBD
    D=M
    @WHITE
    D;JEQ
    @BLOOP
    0;JMP
