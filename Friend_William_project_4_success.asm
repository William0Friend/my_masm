
include Irvine32.inc
; Program sorts two arrays in ascending order made of random positive integers
; the outputs mone array in ascending order 


.const

lengthListThree EQU (lengthof listOne + lengthof listTwo)

.data

;;;
;;; PlACE YOUR TESTS HERE
;;

listOne DWORD 2, 4, 6, 8, 10, 12, 14
listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15

;;;
;;; START MY CODE
;;;

listThree  dword lengthListThree dup(0)
counterListOne dword 0
counterListTwo dword 0

str0    byte "CPSC 232 - Program #3", 0
str1    byte "Input List: ", 0
str2    byte "Merged List: ", 0

.code

main proc
    
    ;str0    BYTE "CPSC 232 - Program #3",0
    mov    edx, offset str0    
    call WriteString
    call Crlf
    call Crlf
    
    ;str1    byte "Input List: ", 0
    mov     edx, offset str1    
    call WriteString
    ;listOne
    mov     ebx, (lengthof listOne) 
    mov     edx, offset listOne
    call printArray
    call Crlf

    ;str1    byte "Input List: ", 0
    mov    edx, offset str1    
    call WriteString
    ;listTwo
    mov     ebx, (lengthof listTwo)
    mov     edx, offset listTwo
    call printArray
    call Crlf
    
    ;str1    byte "Merge List: ", 0
    mov    edx, offset str2    
    call WriteString
    ;sort, merge, print
    xor     eax, eax
    mov     esi, offset listOne
    mov     edi, offset listTwo
    mov     edx, offset listThree

    call Merge

    mov     ebx, lengthof listThree
    call printArray
    exit
main endp


;=====================================================================
Merge proc uses edx
    mov     ecx, lengthListThree ;Set loop times

checkArrayLength:
    mov eax, counterListOne
    cmp eax, lengthof ListOne
    jl  lessThanLengthListOne
    jge endListOne

lessThanLengthListOne:
    mov eax, counterListTwo    
    cmp eax, lengthof listTwo
    jl lessThanLengthListTwo
    jge endListTwo

lessThanLengthListTwo:
    mov eax, [esi]
    cmp eax, [edi]
    jl  lesser
    je  equal
    jg  greater

lesser:
    mov eax, [esi]
    mov [edx], eax
    add edx, type dword
    add esi, type dword
    inc counterListOne
    loop checkArrayLength

equal:
    mov eax, [esi]
    mov [edx], eax
    add edx, type dword
    add esi, type dword
    inc counterListOne
    jmp greater

greater:
    mov eax, [edi]
    mov [edx], eax
    add edx, type dword
    add edi, type dword
    inc counterListTwo
    loop checkArrayLength

endListOne:
    mov eax, counterListOne
    cmp eax, lengthof listOne
    jl whileOne

    add eax, counterListTwo
    cmp eax, lengthof listThree
    je next
    jl endListTwo

whileOne:
    mov eax, [esi]
    mov [edx], eax
    add esi, type dword
    add edx, type dword
    inc counterListOne
    jmp endListOne

endListTwo:
    mov eax, counterListTwo
    cmp eax, lengthof listTwo
    jl whileTwo

    add eax, counterListOne
    cmp eax, lengthof listThree
    je next
    jl endListOne
     
whileTwo:
    mov eax, [edi]
    mov [edx], eax
    add edi, type dword
    add edx, type dword
    inc counterListTwo
    jmp endListTwo

next:
    ret

Merge endp
;==================================================================


printArray proc uses ebx ecx edx
    mov     ecx, ebx

    DisplayGLoop:
    mov     eax,[edx]
    call    WriteDec
    cmp ecx, 1
    je removelastcomma
    
    mov     eax, ','
    call WriteChar
    mov     eax, ' '
    call WriteChar
    add     edx, type dword
    loop    DisplayGLoop
    ret

startoftext:
    add  edx, type dword
	loop DisplayGLoop

removelastcomma:
	ret

printArray endp


end main



























































