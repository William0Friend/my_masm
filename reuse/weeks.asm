; intExp.asm - calculates the expression A=(A+B)-(C+D)

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

;include Irvine32.inc

.data
 Sunday = 1
 Monday = 2
 Tuesday = 3
 Wednesday = 4
 
 Thursday = 5
 Friday = 6
 Saturday = 7


.code
    daysArray BYTE Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
main PROC

  ;Dont do shit

    invoke ExitProcess,0
main ENDP
END main