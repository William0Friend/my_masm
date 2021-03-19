; Scratch paper for quizes 1,2,3

include Irvine32.inc

.data

num1

input1 DWORD ?
inputCopy DWORD ?

prompt1 BYTE "CPSC 232 Program #2", 0
prompt2 BYTE "Input and unsigned decimal number >> ", 0

prompt3 BYTE "Number offset ones found = ",0

prompt4 BYTE "The number is even", 0
prompt5 BYTE "The number is odd",0





.code

COMMENT !


ArraySize = 3
array BYTE ArraySize DUP(99h)		; 1001 pattern in each nybble

.code
main PROC
	call DisplayArray			; display the array
	
	mov esi,0
	shr array[esi+2],1     		; high byte
	rcr array[esi+1],1     		; middle byte, include Carry flag
	rcr array[esi],1     		; low byte, include Carry flag

	call DisplayArray			; display the array
	exit
main ENDP

;----------------------------------------------------
DisplayArray PROC
; Display the bytes from highest to lowest
;----------------------------------------------------
	pushad

	mov ecx,ArraySize
	mov esi,ArraySize-1
L1:
	mov  al,array[esi]
	mov  ebx,1				; size = byte
	call WriteBinB				; display binary bits
	mov  al,' '
	call WriteChar
	sub  esi,1
	Loop L1
	
	call Crlf
	popad
	ret
DisplayArray ENDP

; Displaying Binary Bits                (WriteBin.asm)

; This program displays a 32-bit integer in binary.

INCLUDE Irvine32.inc

.data
binValue DWORD 1234ABCDh		; sample binary value
buffer BYTE 32 dup(0),0

.code
main PROC

	mov	eax,binValue		; number to display
	mov	ecx,32			; number of bits in EAX
	mov	esi,offset buffer

L1:	shl	eax,1			; shift high bit into Carry flag
	mov	BYTE PTR [esi],'0'	; choose 0 as default digit
	jnc	L2				; if no Carry, jump to L2
	mov	BYTE PTR [esi],'1'	; else move 1 to buffer

L2:	inc  esi				; next buffer position
	loop L1				; shift another bit to left

	mov  edx,OFFSET buffer	; display the buffer
	call WriteString
	call Crlf
	exit
main ENDP


var1 DWORD 0

code segment 'CODE'
main PROC

	je	L1			; jump to short target
	mov  edx,offset var1	
L1:

	mov	ax,bx
	nop			; align next instruction
	mov	edx,ecx


	jz FarLabel
	nop	
	nop
	nop

	mov	ax,4C00h
	int	21h
main ENDP
code ends

other segment 'CODE'

FarLabel:
	


other ends




END main

mov  bl,8Fh                     ; BL = 10001111b
shl  bl,1                       ; CF = 1, BL = 00011110b
mov  al,0D0h                    ; AL = 11010000b
shr  al,1                       ; AL = 01101000b, CF = 0
mov  al,00000010b
shr  al,2                     ; AL = 00000000b, CF = 1
mov  al,01000000b             ; AL = 64
shr  al,3                     ; divide by 8, AL = 00001000b

;---------------------------------------------------------
BinToAsc PROC
;
; Converts 32-bit binary integer to ASCII binary.
; Receives: EAX = binary integer, ESI points to buffer
; Returns: buffer filled with ASCII binary digits
;--------------------------------------------------------
    push  ecx
    push  esi
    mov   ecx,32               ; number of bits in EAX
L1: shl   eax,1                ; shift high bit into Carry flag
    mov   BYTE PTR [esi],'0'   ; choose 0 as default digit
    jnc   L2                   ; if no Carry, jump to L2
    mov   BYTE PTR [esi],'1'   ; else move 1 to buffer
L2: inc   esi                  ; next buffer position
    loop  L1                   ; shift another bit to left
    pop   esi
    pop   ecx
    ret
BinToAsc ENDP
;
!
prompt2 BYTE "Input and unsigned decimal number >> ", 0

prompt3 BYTE "Number offset ones found = ",0

prompt4 BYTE "The number is even", 0
prompt5 BYTE "The number is odd",0


;prompt1 BYTE "CPSC 232 Program #2", 0
;Print a message to user
mov edx, offset prompt1
call WriteString
call Crlf

;prompt2 BYTE "Input and unsigned decimal number >> ", 0
;Print a message to user
mov edx,offset prompt2
call WriteString
;Reading tunsigned decimal number
call ReadInt
mov input1, eax
call Crlf

;prompt3 BYTE "Number offset ones found = ",0
;Print message to user
mov edx, offset prompt3
call WriteString
mov edx, offset str2
call WriteString
call Crlf

;Print message to user
mov edx, offset prompt4
call WriteString
mov al, num
call WriteDec
call Crlf



main PROC

;mov eax, A
;call DumpRegs
;INVOKE ExitProcess 0

exit
main endp
end main
