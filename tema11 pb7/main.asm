bits 32

global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit


%include "tema.asm"

segment data use32 class=data
	format_string db "Elemente = %d", 10, 13, 0
    
	sir1 db 1, 2, 3, 6, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 0
	len1 equ ($-sir1)
	
	sir2 db 1, 2, 3, 5, 1, 2, 3, 4, 1, 2, 3, 0
	len2 equ ($-sir2)
	
	sir3 db 1, 2, 3, 6, 1, 2, 3, 4, 1, 2, 3, 5, 6, 0
	len3 equ ($-sir3)

segment code use32 class=code
start:
	
	push dword sir1
	push dword len1
	push dword sir2
	push dword len2
	call factorial
	
	mov ecx, 100
	mov esi, eax
	
	repeta1:
		mov eax, 0
		
		lodsb
		cmp al, 0
		je afara1
		
		pushad
		push dword eax
		push dword format_string
		call [printf]
		add esp, 2*4
		popad
		
		loop repeta1
		
	afara1:
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	push dword sir2
	push dword len2
	push dword sir3
	push dword len3
	call factorial
	
	mov ecx, 100
	mov esi, eax
	
	repeta2:
		mov eax, 0
		
		lodsb
		cmp al, 0
		je afara2
		
		pushad
		push dword eax
		push dword format_string
		call [printf]
		add esp, 2*4
		popad
		
		loop repeta2
		
	afara2:
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	push dword sir1
	push dword len1
	push dword sir3
	push dword len3
	call factorial
	
	mov ecx, 100
	mov esi, eax
	
	repeta3:
		mov eax, 0
		
		lodsb
		cmp al, 0
		je afara3
		
		pushad
		push dword eax
		push dword format_string
		call [printf]
		add esp, 2*4
		popad
		
		loop repeta3
		
	afara3:

	push 0
	call [exit]

