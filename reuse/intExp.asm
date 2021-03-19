; intExp.asm - calculates the expression A=(A+B)-(C+D)

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

include Irvine32.inc
.data
AAA 


.code
; A = (A+B) - (C+D)
main PROC
    ;assign the integer values to registers
        ; A=eax=150






main ENDP
END main