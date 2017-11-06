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
    ;a,b-byte; c-word; e-doubleword; x-qword
    
    a db 0x12
    b db 0x10
    c dw 0x1000
    e dd 0x12345678
    x dq 0x123456789ABCDEF0
    
    
    ;test var
    ;a1 db -1
    ;a2 db 1

; our code starts here
segment code use32 class=code
    start:
        ; ...

        ;TEST
        ;mov al, [a1]
        ;mul byte [a2]
        
        
        ;(a-2)/(b+c)+a*c+e-x      
  
        ; bl - byte (a-2)
        mov bl, [a]
        sub bl, 2  
        
        ; cx - word (b+c)
        mov al, [b]
        cbw
        add ax, [c]
        mov cx, ax
        
        ; dx:ax - dword (a-2) / word (b+c)
        mov al, bl
        cbw 
        cwd
        idiv WORD cx
        
        ; eax - word ax (from dx:ax)
        cwde
        
        mov ebx, eax
        
           
        ; dx:ax - dword (a * c)
        mov al, [a]
        cbw
        imul WORD [c]
        
        ; eax - dx:ax
        
        ;with shift
        ;mov cx, dx   
        ;shl ecx, 16
        ;mov cx, ax 
        
        ;or
        
        push dx
        push ax
        pop eax
        mov ecx, eax
           
        
        ; ebx - (a-2)/(b+c)+a*c+e
        add ebx, ecx
        add ebx, [e]
        
        ; edx:eax - qword ebx
        mov eax, ebx
        cdq 
        
        ; ebx:ecx - qword x
        mov ecx, [x]
        mov ebx, [x+4]
        
        ; edx:eax - qword (ebx + x)
        sub eax, ecx
        sbb edx, ebx
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
