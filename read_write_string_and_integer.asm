include irvine32.inc

.data

str0 byte "CPSC 232 - Program #1",0ah,0dh,0 ;0ah and 0dh could be 10,13
str1 byte "Enter Your name >> ",0            ;0ah,0dh,0
str3 byte "Enter Your Age >> ",0             ;0ah,0dh,0
str4 byte "Your name is: ", 0
str5 byte "Your age is: ", 0

str2 byte 30 DUP(?)
num byte ?
num2 DWORD ?

str_size = 20
.code
main proc

mov edx, offset str0
call WriteString
call Crlf


;Print a message to user
mov edx,offset str1
call WriteString
;call Crlf

;Entering a string
mov edx, offset str2
mov ecx, str_size
call ReadString
;call Crlf

;Print message to user
mov edx, offset str3
;call Crlf
call WriteString
call ReadInt
mov num, al
;mov num2, eax
call Crlf

;Print message to user
mov edx, offset str4
call WriteString
mov edx, offset str2
call WriteString
call Crlf

;Print message to user
mov edx, offset str5
call WriteString
mov al, num
;mov eax, num
call WriteDec



exit
main endp
end main

