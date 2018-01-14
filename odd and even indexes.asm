bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
 import printf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    sir db 10,11,12,13,14,15,16,17
    lenSir equ ($-sir)
    
    printFormat db "%d ", 0
    rez times lenSir db 0
    contor db 0


; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir 
        mov ecx, lenSir
        
        buclaImpar:
            
            mov eax, lenSir 
            sub eax, ecx
            
    
            and al, 00000001
            cmp al, 1
            
            mov eax, 0 
            lodsb  
            
            jnz continuaImpar
            
             
                pushad
                push dword eax
                push dword printFormat
                call [printf]
                add esp, 2*4
                popad
                
            
                mov ebx, 0
                mov bl, [contor]
                add bl, 1
                mov [contor], al
                
                ;ebx = offset
                mov [rez + ebx], al
                
            continuaImpar:
            
                loop buclaImpar
                

 
        mov esi, sir
        mov ecx, lenSir
        
        buclaPar:
            mov eax, lenSir
            sub eax, ecx
            
            and al, 00000001
            cmp al, 0
            
            mov eax, 0
            lodsb  
            
            jnz continuaPar
            
                pushad
                push dword eax
                push dword printFormat
                call [printf]
                add esp, 2*4
                popad
                 
                mov ebx, 0
                mov bl, [contor]
                add bl, 1
                mov [contor], al
                mov [rez + ebx], al
                
            
            continuaPar:
            
                loop buclaPar
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
