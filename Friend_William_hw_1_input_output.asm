; HW 1

;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword


INCLUDE Irvine32.inc
BUFMAX = 128

.data
	; declare variables here



out1 BYTE "CPSC 232 - Program #1", 0
out2 BYTE "Enter your name >> ", 0
out3 BYTE "Enter your age >> ", 0
out4 BYTE "Your age is:  ", 0
out5 BYTE "Your age is:  ", 0


in1 BYTE 20 DUP(0)
in2 BYTE 20 DUP(0)
buffer   BYTE BUFMAX+1 DUP(0)

saveName BYTE BUFMAX+1 DUP(0)
saveAge DWORD 0

.code
main proc
	; write your code here
	mov	ebx,0				; no caption
	mov	edx,OFFSET out1		; contents
	call WriteString
	call Crlf
	call Crlf

	mov edx,OFFSET out2
	call WriteString
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET buffer   ; point to the buffer
	call	ReadString         	; input the string
	mov saveName,
	call Crlf

	mov edx,OFFSET out3
	call WriteString
	call ReadInt
	;mov saveAge,edx
	call Crlf

	mov edx,OFFSET out4
	call WriteString
	call Crlf

	mov edx,OFFSET out5
	call WriteString
	call Crlf


	invoke ExitProcess,0
main endp
end main