;Write an x86 assembler program that does the following:
;a.	Get a string from the console (20 characters max). 
;b.	Stores the string in memory.
;c.	Reverse the string, store it in memory, and print it out. 
;d.	Determine if the string is a palindrome or not.  Print out the answer.
;e.	If an empty string is entered, flag it as an error condition.
;f.	If more than 20 characters are entered, only use the first 20.  

;Images of four (4) test cases are provided in the attached zip file.

;This program should make use of the 32-bit Irvine assembler library (see Chapter 5 of the Irvine text).



; Reversing a String (RevStr.asm)
; This program reverses a string.


;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

include irvine32.inc

.data

aName byte 20 DUP(0), 0
rName byte 20 DUP(0), 0
r1Name byte 20 DUP(0), 0
r2Name byte sizeof aName DUP(0), 0

;my data
prompt1 byte "CPSC 232 - Program #3",0
prompt2 byte "Input a string (20 chars max) >> ",0

reverseString byte "The reverse string is: " ,0

palindromeSuccess byte "The string is a palindrome",0
palindromeError byte "Error - Empty String Entered",0
palindromeError2 byte "The string is not a palindrome",0

str1    BYTE "Enter a Palindrome: ",0
str2    BYTE "Orginal String is ",0
str3    BYTE "Reversed string is ",0
str4    BYTE "It is a palindrome!",0
str5    BYTE "It is not a palindrome.",0
str6    BYTE " Would you like to check another string? (y/Y) ",0
yY    BYTE  ?
array1    BYTE count DUP(0)
array2    BYTE count DUP(0)
array3    BYTE count DUP(0)


;saveOriginal byte 20 DUP(?),0
;saveReverse byte 20 DUP(?),0



;nameSize byte sizeof aName
;nameSize DWORD 20
;nameSize = ($ - aName) - 1
nameSize = lengthof aName


.code
main proc

;;;;Prompt
;prompt1 byte "CPSC 232 - Program #3",0
mov edx, OFFSET prompt1
call WriteString
call Crlf

;prompt2 byte "Input a string (20 chars max) >> ",0
mov edx, offset prompt2
call WriteString


;get user inpt
mov edx, offset aName
mov ecx, nameSize

call ReadString


;;;Reverse String
; Push the name on the stack.
    mov	ecx, nameSize
	mov	 esi,0

L1:	movzx eax,aName[esi]	; get character
	push eax				; push on stack
	inc	 esi
	loop L1

; Pop the name from the stack in reverse
; and store it in the aName array.
	mov ecx, nameSize
	mov	 esi,0


L2:	pop  eax				; get character
	;cmp	al,
	mov	 rName[esi],al; maybe ah		; store in string
	inc	 esi
	loop L2


	mov	ecx, (lengthof aName - TYPE BYTE)
	mov	 esi, lengthof aName
Lrev:
	mov al, aName[esi]
	mov r1Name[ecx], al
	dec esi
	loop Lrev

	mov	ecx, (lengthof aName - TYPE BYTE)
	mov	 esi, lengthof aName

Lrev2:
	mov al, aName[esi]
	mov r2Name[ecx], al
	dec esi
	loop Lrev2




;reverseString byte " The reverse string is: " ,0
mov edx, offset reverseString
call WriteString

mov edx, offset rName 
call WriteString
call Crlf

mov edx, offset r1Name 
call WriteString
call Crlf

mov edx, offset r2Name 
call WriteString
call Crlf
;Determine if palindrome


	Invoke ExitProcess,0
main endp
end main

Palindrome PROC
    mov ecx, edi
    mov esi, 0
    mov edi, 0

check:
    mov al, source[esi]
    ;mov bl, target[edi]
    cmp al, target[edi]
    mov edx, OFFSET str5    
    call WriteString
    call Crlf
    inc esi
    dec edi
    jns check
    mov edx, OFFSET str4    
    call WriteString
    call Crlf
Palindrome ENDP







COMMENT !



.data
source  byte  "This is the source string",0
target  byte  SIZEOF source DUP(0),0

.code
main proc

	mov  esi,0				; index register
	mov  ecx,SIZEOF source	; loop counter
L80:
	mov  al,source[esi]		; get a character from source
	mov  target[esi],al		; store it in the target
	inc  esi				; move to next character
	loop L80					; repeat for entire string

	invoke ExitProcess,0
main endp
end main


mov edx, offset rName + 2
call WriteString

mov edx, offset rName + 3
call WriteString

mov edx, offset rName + 4
call WriteString

mov edx, offset rName + 5
call WriteString

mov edx, offset rName + 6
call WriteString

mov edx, offset rName + 7
call WriteString

mov edx, offset rName + 8
call WriteString

mov edx, offset rName + 9
call WriteString

mov edx, offset rName + 10
call WriteString

mov edx, offset rName + 11
call WriteString

mov edx, offset rName + 12
call WriteString

mov edx, offset rName + 13
call WriteString


mov edx, offset rName + 14
call WriteString

mov edx, offset rName + 15
call WriteString

mov edx, offset rName + 16
call WriteString


mov edx, offset rName + 2 ;because of new line causing it not to print
call WriteString
call Crlf

mov edx, offset rName + 2 ;because of new line causing it not to print
call WriteString
call Crlf

mov edx, offset aName + 4
call WriteString
call Crlf


mov edx, offset aName + 8
call WriteString
call Crlf

mov edx, offset aName + 16
call WriteString
call Crlf

;;works till here but is not printing
mov edx, offset aName + 29
call WriteString
call Crlf

;mov edx, offset aName + 4
;call WriteString
;call Crlf


;mov edx, offset aName + 8
;call WriteString
;call Crlf

;mov edx, offset aName + 16
;call WriteString
;call Crlf

;;works till here but is not printing
;mov edx, offset aName + 29
;call WriteString
;call Crlf

;mov edx, offset aName
;call WriteString
;call Crlf
;;;bring curser to new line for program response
;call Crlf

!