bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                          
;A,B words. obtain dword c such that:
;bits 0-4 of C are 1
;bits 5-11 of C are the same with the bits 0-6 of A
;bits 16-31 of C have the following value 0000000001100101b
;bits 12-15 of C are the same with the bits 8-11 of B                     
                      
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    a dw 0000011000010010b
    b dw 0001101100000111b
    c dd 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;c ->0000 0000 0110 0101 1011 0010 0101 1111b
        ;c ->0065B25F
        
        ;c)bits 16-31 of C have the following value 0000000001100101b
        mov ax, 0000000001100101b
        mov cl, 16
        shl eax, cl
        
        ;a) bits 0-4 of C are 1
        or ax, 0000000000011111b 
        
        ;b) bits 5-11 of C are the same with the bits 0-6 of A
        mov bx, [a]
        and bx, 0000000000010010b
        mov cl, 5
        shl bx, cl ; shift bits 0-6 of A to position 5-11 
        or ax, bx 
        
        ;d)bits 12-15 of C are the same with the bits 8-11 of B  
        mov bx, [b]
        and bx, 0001101100000000b
        mov cl, 4
        shl bx, cl ; shift bits 8-11 of B to position 12-15 
        or ax, bx

        mov [c], eax
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
