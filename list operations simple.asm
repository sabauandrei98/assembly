bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    ; ===========PROBLEM STATEMENT================
    ; Given an 'input' list of bytes and two list 'src' and 'dst'
    ; Build 'output' s.t. :
    ; Each element from 'input' which has a coresponding element in 'src' will be the coresponding element from 'dst'
    ; (eg:  if input[2] == src[4]
    ;       -> output[2] == dst[4]
    
    ; (eg: if input[4] not in src
    ;       -> output[4] = input[4]
    
    ; (eg:) 
    ;  src [1, 2, 3, 4]
    ;  dst [101, 102, 103, 104]
    ;  input [0, 0, 1, 5, 2, 3]
    ;
    ;-> output[0, 0, 101, 5, 102, 103]
    
    src db 2, 4, 6, 9
    lenN equ ($-src)
    dst db 101, 102, 103, 104
    
    input db 1, 2, 3, 4, 5, 6, 7, 8, 9
    lenInput equ ($-input)
    
    output times lenInput db 0
    
    format db "%d", 10, 13, 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0  ; input list contor
        mov ecx, lenInput
        cmp ecx, 0
        JE final
        
    buclaInput:
        
        mov eax, 0
        mov al, [input + ebx] ; al = each element from input list
        
        mov ecx, lenN
        cmp ecx, 0
        JE printNorm
        
        mov ecx, 0
        
        ; take each element from src and check if it is equal to current element from input (al value)
        buclaN:
            
            mov edx, 0
            mov dl, [src + ecx]
            
            cmp al, dl
            ; if equal then go and print the element
            JE printElement
            
            ; if not we check the next element
            add ecx, 1
            cmp ecx, lenN
            jne buclaN
                 
        
        printNorm:
            ; if no element from src is equal to the current element from input (al value) then we write the current value (al)
            jmp sfarsitBucla
            
        printElement:
            ; if we find an element then we print the coresponding element from dst, (eg: found src[3] .. print dst[3])
            mov al, [dst+ ecx] 
                   
            sfarsitBucla:
            
                mov [output + ebx], al ; build output list
                
                ; a normal print
                push dword eax
                push dword format
                call [printf]
                add esp, 4*2
                ;------------
                
                add ebx, 1
                
                ; ebx = contor for input, loop until ebx == len(input)
                cmp ebx, lenInput
                jne buclaInput
  
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
