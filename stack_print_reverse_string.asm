include irvine32.inc


.DATA
MSG1 DB "ENTER A STRING: $"
MSG2 DB 0DH, 0AH, "REVERSED STRING: $"
.CODE
MAIN PROC
    
    MOV AX, DS
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG1
;    INT 21H
     
    XOR CX, CX
    
    MOV AH, 1
    READ:
;    INT 21H 
    CMP AL, 0DH 
    JE ENDOFSTRING
    INC CX
    MOV DL, AL 
    MOV DH, 0H
    PUSH DX
    JMP READ 
     
    ENDOFSTRING:
    MOV AH, 9
    LEA DX, MSG2
    ;INT 21H
    
    PRINT:
    MOV AH, 2
    POP DX
    ;INT 21H
    DEC CX
    CMP CX, 0
    JNE PRINT

    MAIN ENDP
END MAIN

