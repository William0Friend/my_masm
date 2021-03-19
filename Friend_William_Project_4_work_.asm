
include Irvine32.inc
; This program sorts an array with random integers
; and outputs them in order


.const

lengthListThree EQU (lengthof listOne + lengthof listTwo)
.data
;array BYTE 20, 10, 60, 5, 120, 90, 100 ; array with 7 values
;arraysize = ($ - array) -1 ; size of array
;count DWORD ? ; mem to hold ecx


;total DWORD 0
;listOne DWORD 2, 4, 6, 8, 10, 12, 14
;listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15
;listThree DWORD (lengthof listOne + lengthof listTwo) DUP(0)
;list3 DWORD (($-listOne)+($-listTwo)) DUP(?)


;listOne  dword 1,3,4,7,9,15,17
;listTwo  dword 2,6,8,10,11,14,18,19

;listOne  dword 1, 3, 5, 7, 9, 11, 13, 15
;listTwo  dword 2, 4, 6, 8, 10, 12, 14, 16

listOne  dword 1, 1, 1, 1
listTwo  dword 2, 4, 6, 8, 10, 12, 14, 16


;lengthListTwo dword 
listThree  dword lengthListThree dup(0)

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

L1:
L3: 

    mov     eax, [esi]
    cmp     eax, [edi]
    je      equal
    jl      lesser  ;Jump if less
    jg      greater  ;Jump if greater
    
    
    loop    L3
    mov     ecx, 1
    ;je      equal
    loop    L1
    jmp     J2

lesser:
    mov     eax,[esi]
    mov     [edx], eax
    
    cmp     esi, offset listTwo;======== edx,
    jne      a
    je       b
    
    a:
    add     esi, type dword
    add     edx, type dword
    loop    L3

    b:
    mov    eax, [edi]
    mov     [edx], eax
    ret

greater:
    mov     eax, [edi]
    mov     [edx], eax
    
    
    cmp     esi, offset listTwo;======== edx,
    jne      a2
    je       b2
    

    a2:
    add     edi, type dword
    add     edx, type dword
    loop    L3

    b2:
    mov    eax, [esi]
    mov    edx, eax
    ret
    
equal:
    cmp     esi, offset listTwo;======== edx,
    jne      a3
    je       b3
   

    a3:
    cmp     edi, offset listOne;======== edx,
    jne      a4
    je       b4
    ;mov     eax,[esi]
    ;mov     [edx], eax
    ;add     esi, type dword
    ;add     edx, type dword
    dec     edi; or esi
    loop    L3

    b3:
    mov     eax,[esi]
    mov     [edx], eax
    add     esi, type dword
    add     edx, type dword
    loop    L3

    a4:
    ;mov     eax,[edi]
    ;mov     [edx], eax
    ;add     edi, type dword
    ;add     edx, type dword
    ;dec     ecx
    dec     esi; or edi
    jmp     L3
    
    b4:
    mov     eax,[edi]
    mov     [edx], eax
    add     edi, type dword
    add     edx, type dword
    dec     ecx
    jmp     L3


J2:
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




























































COMMENT !

;=====================================================================
Merge proc
    mov     ECX,lengthof a3 ;Set loop times
TheLoop:
TheJump:
    mov     ax,[ESI]
    cmp     ax,[EDI]
    jl      lesser  ;Jump if less
    jg      greater ;Jump if greater
    je      equal   ;jump if equal    
    Loop    TheLoop
    jmp     EndJump
lesser:
    mov     ax,[ESI]
    mov     [EDX],ax
    add     ESI,2
    add     EDX,2
    jmp     TheJump

greater:
    mov     ax,[EDI]
    mov     [EDX],ax
    add     EDI,2
    add     EDX,2
    jmp     TheJump

equal:
    ;mov     ax,[EDI]
    ;mov     [EDX],ax
    mov     ax,[ESI] ;since eqaul doesnt matter which yu put in new array
    mov     [EDX],ax
    add     ESI,2
    add     EDX,2
    jmp     TheJump
EndJump:
    ret
Merge endp


;==================================================================
Display proc
    mov     ECX,lengthof a3 ;Set loop times
    mov     EDX,offset a3

DisplayLoop:
    mov     ax,[EDX]
    add     EDX,2
    call    writedec
    call    crlf
    loop    DisplayLoop
    ret
Display endp
;===================================================================
end main
!
