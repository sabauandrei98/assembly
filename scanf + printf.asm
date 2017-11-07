bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
	;read a, b (a: dword, b: word)
	;print: "<a>%<b> = <result>"
	;eg: for a = 23 and b = 5 it will print: "23 mod 5 = 3"
	
    a dd 0
    b dw 0
    formatRead db "%x", 0
    formatPrint db "%x mod %x = %x", 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov cx, [b]
        push dword a
        push dword formatRead
        call [scanf]
        add esp, 4*2
        
        push dword b
        push dword formatRead
        call [scanf]
        add esp, 4*2
        
        mov eax, [a]
        push dword eax
        pop word ax
        pop word dx
        div WORD [b]
        
        mov bx, dx
        mov edx, 0
        mov dx, bx
        
        push dword edx
        push dword [b]
        push dword [a]
        push dword formatPrint
        call [printf]
        add esp, 4*4
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
