bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll 
import fread msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume db 'ana.txt', 0
    mod_acces db 'r', 0
    descriptor dd 0
    len equ 100
    text times len db 0
    
    ;fread(str, size, count, descriptor)
    ;descriptor -> de unde citim
    ;str -> unde scriem
    ;size-> dim a ce citim
    ;count -> cat

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; fread(nume, mod_acces)
        push dword mod_acces 
        push dword nume
        call [fopen]
        add esp, 4*2
        
        ; 0 - if error
        cmp eax, 0
        je final
        mov [descriptor], eax
        
        ; fread(text, 1, len, descriptor)
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        ; eax - nr de caractere citite
        
        ;fclose (descr)
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
