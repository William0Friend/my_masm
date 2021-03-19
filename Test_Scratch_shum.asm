;CPSC 232 - Program #1

include irvine32.inc

.data

str0 byte "CPSC 232 - Program #1",0ah,0dh,0 
str1 byte "Enter Your name >> ",0           
str3 byte "Enter Your Age >> ",0            
str4 byte "Your name is: ", 0
str5 byte "Your age is: ", 0

str2 byte 20 DUP(?)
num byte ?
str_size = 20

.code
main proc

mov edx, offset str0
call WriteString
call Crlf


;Print a message to user
mov edx,offset str1
call WriteString


;Entering a string
mov edx, offset str2
mov ecx, str_size
call ReadString


;Print message to user
mov edx, offset str3
call WriteString
;Reading the age
call ReadInt
mov num, al
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
call WriteDec
call Crlf

exit
main endp
end main