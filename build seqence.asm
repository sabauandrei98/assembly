bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
;s1, s2
;s3 = s1 + rev(s2)

    s1 dd 0xAB, 0xCD, 0xFF
    l1 equ ($-s1)/4
    s2 dd 0x12, 0x34
    l2 equ ($-s2)/4
    s3 RESD (l1+l2)
    format db "0x%x, ", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; for(i = 0; i < l1; i++) {s3[i] = s1[i]}
        ; for(j = l2-1; j >=0; j--) {s3[i] = s2[j]; i++;}
        
        mov ECX, l1
        jecxz step2
        
        mov esi, 0
        b1:
            mov eax, [s1+esi]
            mov [s3+esi], eax
            add esi, 4
            loop b1
            
    step2:
            mov ecx, l2
            jecxz final
            mov edi, (l2-1) * 4
            
        b2:
            mov eax, [s2+edi]
            mov [s3+esi], eax
            sub edi, 4
            add esi, 4
            loop b2
            
    step3:
            mov ecx, l1+l2
            jecxz final
            
            mov esi, 0
        b3:
            mov eax, [s3+esi]
            
            pushad
            ;==============
            push dword eax
            push dword format
            call [printf]
            add esp, 4*2
            ;==============
            popad
            
            add esi, 4
            loop b3
        
        
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
