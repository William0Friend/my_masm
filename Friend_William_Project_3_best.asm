TITLE MY FIRST ASM (test1.asm)
INCLUDE Irvine32.inc

.data

prompt1 byte "Enter string to check palindrome: ", 0
prompt2 byte "This string is a palindrome.", 0
prompt3 byte "This string is not a palindrome. ", 0
strinp byte 50 DUP(?), 0
sizeofstr byte ?
palinflag byte 0
temp byte ?

.code

MAIN PROC

mov edx, offset prompt1
call WriteString

mov edx, offset strinp
mov ecx, lengthof strinp-1
call ReadString
dec eax
push offset strinp ;offset of array
push 0 ; start
push eax ; end (size of input string - 1)
call CheckPalindrome
cmp palinflag, 0
jz nopalindrome
mov edx, offset prompt2
call WriteString
jmp finish

nopalindrome:
	mov edx, offset prompt3
	call WriteString

finish:
	call DumpRegs
	exit
main ENDP

CheckPalindrome Proc
push ebp
mov ebp, esp

mov esi, [esp+16] ; offset strinp
mov eax, [esp+12] ; start
mov ebx, [esp+8] ; end
mov ecx, [esp+4]

cmp eax, [esp+8]
jz maketrue
add esi, [esp+8]
mov bl, [esi]
sub esi, [esp+8]
add esi, [esp+12]
mov dl, [esi]
sub esi, [esp+12]
cmp dl, bl
jnz makefalse
cmp al, [esp+8]
jae maketrue

mov esi, [esp+16] ; offset strinp
mov eax, [esp+12] ; start
mov ebx, [esp+8] ; end
push esi
inc eax
dec ebx
push eax
push ebx
call CheckPalindrome
jmp moveout
maketrue:
	mov palinflag, 1
	jmp moveout
makefalse:
	mov palinflag, 0

moveout:
pop ebp
ret 12
CheckPalindrome ENDP

END main