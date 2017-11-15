bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	
	;s - list of elements
	;d1 - elements from even pos
	;d2 - elements from odd pos
	
	s db 1, 2, 3, 4, 5, 6, 7, 8, 9
	lenS equ ($-s)
	d1 times lenS/2+1 db 0
	d2 times lenS/2+1 db 0
    contD1 dd 0
    contD2 dd 0
    
    ;text
    format db "%d", 10, 13, 0
    
    ;debug format
    formatDB db "%d %d", 10, 13, 0
	
; our code starts here
segment code use32 class=code


start:
        mov esi, 0      ;contor for s list
        mov ecx, lenS   ;length of s list
        cmp ecx, 0      
        Je final        ;exit if length is 0

split:
        mov al, [s+esi] ;get an element from s list
        
        test esi, 00000001b  ;check if odd or even
        jnz oddPos
        
        evenPos:
            mov ebx, 0
            mov ebx, [contD1]  ;use ebx to access the memory
            mov [d1+ebx], al   ;add element
            inc dword [contD1] 
            
            jmp moveOn         ;jump in the split loop
            
        oddPos:
            mov ebx, 0
            mov ebx, [contD2]   ;use ebx to access the memory
            mov [d2+ebx], al    ;add element
            inc dword [contD2]  
               
        moveOn:
            
            inc esi    ;increase the pos in s list
            dec ecx    ;decrease the pos in s list
            
            cmp ecx, 0 
            jne split  ;if no end reached go again
             
;end
        
    mov ebx, 0       ;reset the counter
    mov ecx, [contD1]  ;length(d1) == length(d2) == length(s)/2
        
printLists1:
        
        mov eax, 0       ;clear eax
        mov al, [d1+ebx] ;get each element from d1

        push ecx  
        ;-----------
        push dword eax      ;push an element 
        push dword format   ;push "%d"
        call [printf]       
        add esp, 4*2        ;clean memory
        ;------------
        pop ecx
        
        inc ebx
        dec ecx
        
        cmp ecx, 0
        jne printLists1  ;if no end reached go again
;end

    mov ebx, 0
    mov ecx, [contD2]

printLists2:
        
        mov eax, 0
        mov al, [d2+ebx]

        push ecx
        ;-----------
        push dword eax
        push dword format
        call [printf]
        add esp, 4*2
        ;------------
        pop ecx
        
        inc ebx
        dec ecx
        
        cmp ecx, 0
        jne printLists2
;end          

        
    
final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
