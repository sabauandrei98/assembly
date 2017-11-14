bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
<<<<<<< HEAD
    ; ...
    a dd 1, 2, 3, 4
    len equ ($-a)/4
=======
    ; ...
    a dd 1, 2, 3, 4
    len equ ($-a)/4
>>>>>>> 24f517a7389aec497cc50ef2b106d59952639c90
    format db "%d", 10, 13, 0

; our code starts here
segment code use32 class=code
    start:
<<<<<<< HEAD
        ; ...
        ;for (int i = 0; i < len; i++)
        ;   printf(format, a[i])
        mov ebx, 0
        mov ecx, len
        cmp ecx, 0
        JE final
    bucla:
        mov eax, [a+ebx]
        
        ;pushad
        push dword ecx
        ;-----------
        push dword eax
        push dword format
        call [printf]
        add esp, 4*2
        ;------------
        ;popad
        pop dword ecx
        
        add ebx, 4
        dec ecx
        
        cmp ecx, 0
=======
        ; ...
        ;for (int i = 0; i < len; i++)
        ;   printf(format, a[i])
        mov ebx, 0
        mov ecx, len
        cmp ecx, 0
        JE final
    bucla:
        mov eax, [a+ebx]
        
        ;pushad
        push dword ecx
        ;-----------
        push dword eax
        push dword format
        call [printf]
        add esp, 4*2
        ;------------
        ;popad
        pop dword ecx
        
        add ebx, 4
        dec ecx
        
        cmp ecx, 0
>>>>>>> 24f517a7389aec497cc50ef2b106d59952639c90
        jne bucla
    
final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
