
include Irvine32.inc
; This program sorts an array with random integers
; and outputs them in order


.const
;lengthListOne  EQU lengthof listOne
;lengthListTwo EQU  lengthof listTwo
lengthListThree EQU (lengthof listOne + lengthof listTwo)
.data
;array BYTE 20, 10, 60, 5, 120, 90, 100 ; array with 7 values
;arraysize = ($ - array) -1 ; size of array
;count DWORD ? ; mem to hold ecx


;total DWORD 0
listOne DWORD 2, 4, 6, 8, 10, 12, 14
listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15
;listThree DWORD (lengthof listOne + lengthof listTwo) DUP(0)
;list3 DWORD (($-listOne)+($-listTwo)) DUP(?)


;listOne  dword 1,3,4,7,9,15,17
;listTwo  dword 2,6,8,10,11,14,18,19

;listOne  dword 1, 3, 5, 7, 9, 11, 13, 15
;listTwo  dword 2, 4, 6, 8, 10, 12, 14, 16


;listOne dword 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
;listTwo dword 1

;listOne dword 1
;listTwo dword 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15


;listOne  dword 1, 1, 1, 1
;listTwo  dword 2, 4, 6, 8, 10, 12, 14, 16

;listOne  dword 2, 4, 6, 8, 10, 12, 14, 16
;listTwo  dword 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1

;listOne  dword 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1
;listTwo dword 1,3,5,6,7,8,9,10

;listOne  dword 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1 
;listTwo  dword 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1

;
;listTwo dword 0,1,2,3,4,5,6
;listOne dword 0,1,2,3,4,5,6,7,8,9,10,11

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
    call DisplayG2
    call Crlf


    ;str1    byte "Input List: ", 0
    mov    edx, offset str1    
    call WriteString
    ;listTwo
    mov     ebx, (lengthof listTwo)
    mov     edx, offset listTwo
    call DisplayG2
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

    ;mov     edx, offset listThree
    mov     ebx, lengthof listThree
    call DisplayG2
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


DisplayG2 proc uses ebx ecx edx
    mov     ecx, ebx

    DisplayGLoop:
    mov     eax,[edx]
   ; cmp eax, STX
   ; je startoftext
    call    WriteDec
    cmp ecx, 1
    je removelastcomma
    
    mov     eax, ','
    call WriteChar
    mov     eax, ' '
    call WriteChar
    ;call    crlf
    add     edx,4
    loop    DisplayGLoop
    ret

startoftext:
    ;mov eax, 0
    add  edx,4
	loop DisplayGLoop

removelastcomma:
	ret

DisplayG2 endp
;DisplayOneAtATime proc
;    movzx   eax,byte ptr [esi]
;    push    eax
;    print   esp          ;display the string that is on the stack
;    pop     eax
;DisplayOneAtATime endp


end main



























































