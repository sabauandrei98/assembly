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
	
	;octetul maxim din fiecare dublu cuvant
    sir dd 0x12345678, 0x11112222, 0x99887766
    lenSir equ ($-sir)/4
    pFormat db '%x ', 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        mov ecx, 4 * lenSir
        
        ;pornim cu ecx de pe 12 si cand ajungem pe 8 afisam un maxim de octecti
        ;ultimul maxim nu o sa fie afisat pentru ca ecx atunci cand ajunge la valoarea 0 nu se mai executa
        ;deci contorul trebuie sa fie cu o pozitie mai rapid ... asa ca o sa afisam la 9 5 1
        mov ebx, 4 * (lenSir - 1) + 1 ;folosim pe post de contor
        mov edx, 0 ; maxim local
        
        
        bucla:
            mov eax, 0
            lodsb
            
            cmp eax, edx ;comparam cu maximul local
            jng pas
            mov edx, eax ;interschimbam
            
            pas:
            
            cmp ebx, ecx ;daca nu suntem pe pozitia pe care se termina un double word, continuam
            jne continuam
            
                pushad
                push dword edx
                push dword pFormat
                call[printf]
                add esp, 2*4
                popad
            
                sub ebx, 4 ;scadem contorul
                mov edx, 0 ;reinitializam maximul local
                
            
            continuam:
            
            loop bucla
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
