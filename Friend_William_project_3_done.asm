;William Friend

INCLUDE Irvine32.inc

.data
count    =    21
str0    BYTE "CPSC 232 - Program #3",0
str1    BYTE "Input a string (20 chars max) >> ",0
str2    BYTE "Orginal String is ",0
str3    BYTE "Reversed string is ",0
str4    BYTE "The string is a palindrome!",0
str5    BYTE "The string is not a palindrome.",0
errorString   BYTE "Error - Empty String Entered",0

array1    BYTE count DUP(0)
arrayRev  BYTE count DUP(0)
array2    BYTE count DUP(0)
array3    BYTE count DUP(0)

.code
main PROC   ; input
    mov    edx,OFFSET str0    ;str0    BYTE "CPSC 232 - Program #3",0
    call    WriteString
    call Crlf
    call Crlf
    mov    edx,OFFSET str1     ;str1    BYTE "Input a string (20 chars max) >> ",0
    call    WriteString
    mov    edx, OFFSET array1    ;array1    BYTE count DUP(0)
    mov    ecx, SIZEOF array1    
    call    ReadString
    call checkEmpty ;check if string empty
    call Reverse
    call ReverseClean
    exit
main ENDP

ReverseClean PROC
    mov edx, OFFSET array1    
    mov ecx, SIZEOF array1    
    mov esi, 0
    mov edi, 0

cleanString:
    mov al, array1[esi]
    cmp al, 19h
    jle skip
    cmp al, 39h ;0-@ needs 40
    jle capnum

    cmp al,'A' ;41
    jl skip
    cmp al, 'Z';5A
    jle capnum

    cmp al, 60h;5B-60
    jle capnum

    cmp al,'a';;61
    jl skip
    cmp al,'z';z 
    jle lower

    cmp al, 7Eh; 7B-7E
    jle capnum
    
capnum:
    mov array2[edi],al ;source
    inc edi
    jmp skip
    
lower:
    sub al, 20h
    mov array2[edi],al ;source
    inc edi

skip:
    inc esi
    loop cleanString
    mov ecx, edi
    mov esi, 0

pushStack:    
    movzx eax, array2[esi]; source
    push eax
    inc esi 
    loop pushStack
    mov ecx, edi
    mov esi, 0

popStack:    
    pop eax
    mov array3[esi], al ;target
    inc esi
    cmp al,0
    je emptyStack
    loop popStack
emptyStack:
    mov array3[esi], 0
    call Palindrome
    ret
ReverseClean ENDP

Palindrome PROC
    mov ecx, edi
    mov esi, 0
    mov edi, 0

check:
    mov al, array2[esi];source
    cmp al, array3[edi];target
    je equal
    jne notequal

    equal:
    inc esi                 ;check next letter
    inc edi
    loop check
    jmp done

    notequal:
    mov edx, OFFSET str5    ;str5    BYTE "It is not a palindrome.",0
    call WriteString
    call Crlf
    ret
    
    done:
    mov edx, OFFSET str4    ;str4    BYTE "It is a palindrome!",0
    call WriteString
    call Crlf
    ret
Palindrome ENDP


Reverse PROC
    mov edx, OFFSET array1    
    mov ecx, SIZEOF array1    
    mov esi, 0
    mov edi, 0

clean: ;use only constants no instructions(get rid of line feed)
    mov al, array1[esi]
    cmp al, 19h
    jle skip
    cmp al, 39h ;0-@ needs 40
    jle toNewArray

    cmp al,'A' ;41
    jl skip
    cmp al, 'Z';5A
    jle toNewArray

    cmp al, 60h;5B-60
    jle toNewArray

    cmp al,'a';;61
    jl skip
    cmp al,'z';z 
    jle toNewArray

    cmp al, 7Eh; 7B-7E
    jle toNewArray
toNewArray:
    mov arrayRev[edi],al ;source
    inc edi
    jmp skip
skip:
    inc esi
    loop clean
    mov ecx, edi
    mov esi, 0

pushStack:    ;push clean var onto stack
    movzx eax, arrayRev[esi]; source
    push eax
    inc esi 
    loop pushStack
    mov ecx, edi
    mov esi, 0

popStack:    ;pop reverse var onto stack
    pop eax
    mov arrayRev[esi], al ;target
    inc esi
    cmp al,0
    je emptyStack
    loop popStack
emptyStack:
    mov array3[esi], 0

    ;str3    BYTE "Reversed string is ",0
    mov edx, OFFSET str3
    call WriteString
    
    mov edx, OFFSET arrayRev ;arrayRev
    call WriteString
    call Crlf
    ret
Reverse ENDP

checkEmpty PROC

    mov edx, OFFSET array1    
    mov ecx, SIZEOF array1    
    mov esi, 0
    mov edi, 0
    mov al, array1[esi]
    cmp al, 0h  ;compare to null if null empty
    je error
    cmp al, 7eh ;compace to all other ascii, if anything other then null go back to main program
    jle return
    error:
    mov edx, OFFSET errorString ;errorString
    call WriteString
    call Crlf
    exit
    return:
    ret
checkEmpty ENDP

END main

