include Irvine32.inc

.data

total DWORD 0

.code
main PROC

    mov ecx, 10

    L1:
    mov eax, ecx
    jnp L2      ;if parity odd
    jp L3     ;if parity even

    L2:
    add total, eax
    loop L1

    L3:
    loop L1



    invoke ExitProcess,0
main endp

end main
; 1 myByte BYTE 00h, 0FFh
; 2 myDouble DWORD 12345678h
    ;  1 mov al,myByte 
    ; 1 mov ah,[myByte+1]
    ; 2 mov ax,WORD PTR [myDouble+1]
    ; 3 mov al, 0
    ; 3 mov ah, 0
    ; 3 dec ah