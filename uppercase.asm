bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll 
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    fileName db 'file.txt', 0
    fileLength equ 100
    
    writeMode db 'w', 0
    readMode db 'r', 0
    
    descriptor dd 0
    inputText times fileLength db 0
    
    printFormat db "%d ", 0
    printMaxFreq db "Max freq = %d", 10, 13, 0
    printMaxAlpha db "Max freq alpha = %c, freq = %d", 10, 13, 0
    
    lettersFreq times 26 db 0
    maxFreq db 0
    maxFreqPos db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; READ FROM FILE fopen(nume, mod_acces)
        push dword readMode 
        push dword fileName
        call [fopen]
        add esp, 4*2
        
        ; 0 = ERROR
        cmp eax, 0
        jne _ContinueProgram
        
        ; IF 0 -> EXIT
        push    dword 0     
        call    [exit]
        
    _ContinueProgram:
        
        mov [descriptor], eax
        
        ;READ DATA FROM FILE fread(text, 1, len, descriptor)
        push dword [descriptor]
        push dword fileLength
        push dword 1
        push dword inputText
        call [fread]
        add esp, 4*4
    
        ;PREPARE REG
        mov ecx, fileLength
        mov esi, inputText
       
    
    ;CHECK EACH ELEMENT
    _Read:
        mov eax, 0
        lodsb ; al <- each byte from inputText
        
        ;CHECK IF UPPER (65 <= X <= 90)
        cmp al, 65 
        jl _endRead
        
        cmp al, 90
        jg _endRead
        
        ;GET THE CORESPONDING POSITION IN ALPHABET
        sub al, 'A'
        
        ;INCREMENT THE LETTER IN FREQ VECTOR
        inc byte [lettersFreq + eax]
        
        ;GET THE MAX FREQUENCE
        mov dl, [lettersFreq + eax]
        cmp dl, [maxFreq]
        
        ;IF LESS, CONTINUE
        jl _continueLoop
        
        ;IF CURRENT VALUE IS GREATER -> STORE IT
        mov [maxFreq], dl
        
        _continueLoop:
        
        ;CONSOLE -> IF UPPER -> PRINT IT'S POSITION IN ALPHABET
        pushad
        push dword eax
        push dword printFormat
        call [printf]
        add esp, 4*2
        popad
        
        _endRead:
    
    loop _Read
    
    
        ;CONSOLE -> MAX FREQ
        pushad
        push dword [maxFreq]
        push dword printMaxFreq
        call [printf]
        add esp, 4*2
        popad
    
    
    
        ;PREPARE REG
        mov ecx, 26
        mov esi, lettersFreq
        mov ebx, 0
        mov edx, 0
        
    
    ;CHECK EACH ELEMENT FROM FREQ VECTOR
    _PrintFreqVector:
        mov eax, 0
        lodsb 
        inc bl
        
        ;CHECK WHICH ALPHABET POSITION HAS THE GREATEST FREQ
        cmp al, [maxFreq]
        jne _continuePrint
        mov dl , bl
        
        _continuePrint:
        
        ;CONSOLE -> PRINT EACH LETTER FREQ
        pushad
        push dword eax
        push dword printFormat
        call [printf]
        add esp, 4*2
        popad
    
    loop _PrintFreqVector
    

        ;CONSOLE -> PRINT LETTER
        mov eax, 0
        lea eax, [(edx + 65) - 1]
        
        
        pushad
        push dword [maxFreq]
        push dword eax
        push dword printMaxAlpha
        call [printf]
        add esp, 4*2
        popad

       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
