bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;printf("Ana are mere")
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    msg db "Ana are mere", 0
    format db "Ana are %d mere si %d pere", 0
    n dd 0x2ff
    m dd 0x1234

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword msg
        call [printf] 
        add esp, 4*1
        
        ;prinf ("Ana are %d mere si % pere", n, m)
        push dword [m]
        push dword [n]
        push dword format
        call [printf]
        add esp, 4*3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
