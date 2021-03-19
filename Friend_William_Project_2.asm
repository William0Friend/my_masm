;William Friend
include Irvine32.inc
 
.data
input1 DWORD ?
inputCopy DWORD ?
parityCount DWORD ?
prompt1 BYTE "CPSC 232 Program #2", 0
prompt2 BYTE "Input and unsigned decimal number >> ", 0
prompt3 BYTE "Number offset ones found = ", 0
prompt4 BYTE "The number is even", 0
prompt5 BYTE "The number is odd", 0

.code
main PROC

mov edx, offset prompt1                    ;prompt1 BYTE "CPSC 232 Program #2", 0
call WriteString                           ;Print a message to user
call Crlf

mov edx,offset prompt2                     ;prompt2 BYTE "Input and unsigned decimal number >> ", 0
call WriteString                           ;Print a message to user
call ReadDec                               ;Reading unsigned decimal number
mov input1, eax                            ;copy 
mov inputCopy, eax                         ;copy the users 32 bit number
call Crlf
     
mov ecx, 32                                ;initiate ecx to 32 since dealing with 32 bits

Lshift:                                    ;start shifting       
shr eax,1                                  ;shift eax right
jc Lcarryset
cmp eax,0
jz Loffset                                 ;exit when eax = 0
Lreenterloop:
loop Lshift                                ;loop back shift eax right once more

Lcarryset:
inc parityCount                            ;inc paritayCount
cmp parityCount, 32
jz Loffset
jmp Lreenterloop

Loffset:
mov edx, offset prompt3                     ;prompt3 BYTE "Number offset ones found = ",0
call WriteString                            ;Print message to user
mov eax, parityCount
call WriteDec
call Crlf
jmp Lmod

Lmod:
xor     edx, edx                            ;following achieves mod operation on variable
mov     eax, parityCount
mov     ecx, 2
div     ecx
cmp edx ,0
jz Leven                                    ;if edx = 0 even
jnz Lodd                                    ;if edx != 0 odd

Leven:
mov edx, offset prompt4                     ;prompt4 BYTE "The number is even", 0
call WriteString
call Crlf
jmp Lend                                    ;go to end of program

Lodd:
mov edx, offset prompt5                     ;prompt5 BYTE "The number is odd", 0
call WriteString                            ;go to end of program
call Crlf
jmp Lend

Lend:                                       ;successful end of program
exit
main endp
end main
