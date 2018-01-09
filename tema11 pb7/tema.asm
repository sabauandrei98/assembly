import printf msvcrt.dll
extern printf
bits 32

%ifndef _TEMA_ASM_ ; 
%define _TEMA_ASM_ ; 
                        
				
	formatChar1 db "debug1=%d", 10, 13, 0
	formatChar2 db "debug2=%d", 10, 13, 0
	formatChar3 db "ecx=%d", 10, 13, 0
	aux dd 0
	list times 100 db 0
	
	

;definire procedura
factorial: ; 
	mov eax, 0
	
	mov edx, [esp + 4]
	mov ebx, [esp + 12]
	
	mov ecx, ebx
	mov [aux], ecx
	
	cmp ebx, edx
	jl executa
	mov ecx, edx
	mov [aux], ecx
	
	executa:
	mov esi, [esp + 8]
	add esi, [aux]
	sub esi, ecx
	lodsb
	mov ebx, eax
	
	;DEBUG
	pushad
	push dword ebx
	push dword formatChar1
	call [printf]
	add esp, 2*4
	popad
	
	
	mov esi, [esp + 16]
	add esi, [aux]
	sub esi, ecx
	lodsb
	mov edx, eax
	
	;DEBUG
	pushad
	push dword edx
	push dword formatChar2
	call [printf]
	add esp, 2*4
	popad
	
	;DEBUG
	pushad
	push dword ebx
	push dword formatChar3
	call [printf]
	add esp, 2*4
	popad
	
	cmp edx, ebx
	jne final
	
	mov ebx, [aux]
	sub ebx, ecx
	mov byte [list + ebx], al
	
	loop executa
	

	final:
	mov eax, list
	
	ret 4 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)

%endif