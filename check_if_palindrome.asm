include irvine32.inc


.data
string db  10 dup('$')
msgPal db  " is a Palindrome$"
msgNotPal db " is not a Palindrome$"

org 100h

.code
lea dx, string
mov ah, 0ah
int 21h

lea di, string+2
lea si, di
mov cl, string[1]
sub cl, 1
add si, cx
shr cx, 1

checkPal:
mov al, [di]
mov dl, [si]
cmp al, dl
jne printNotPal
inc di
dec si
loop checkPal

printPal:
lea dx, msgPal
jmp print

printNotPal:
lea dx, msgNotPal

print:
mov ah, 9h
int 21h

mov ah, 0
int 16h


