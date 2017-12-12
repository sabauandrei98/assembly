bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll 
import fprintf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume db 'ana.txt', 0
    mod_acces db 'w', 0
    descriptor dd 0
    text db "Ana are mere", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; fopen(nume, mod_acces)
        push dword mod_acces 
        push dword nume
        call [fopen]
        add esp, 4*2
        
        ; 0 - if error
        cmp eax, 0
        je final
        mov [descriptor], eax
        
        ; write "Ana are mere"
        ; fprintf(descriptor, "Ana are mere")
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
  
        
        
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
