bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;c+(a*a-b+7)/(2+a)
    ;a-byte; b-doubleword; c-qword
    
    a db 10
    b dd 3
    c dq 1500

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov eax, 0
        mov al, [a]
        mul byte [a]
        
        add ax, 7
        sub ax, [b]
        
        mov ebx, 0
        mov bl, [a]
        add bl, 2
        div bl
        
        mov ebx, [c+4]
        mov ecx, [c]
        
        mov ebx, eax
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
