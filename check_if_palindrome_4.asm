;Write an x86 assembler program that does the following:
;a.	Get a string from the console (20 characters max). 
;b.	Stores the string in memory.
;c.	Reverse the string, store it in memory, and print it out.
;d.	Determine if the string is a palindrome or not.  Print out the answer.
;e.	If an empty string is entered, flag it as an error condition.
;f.	If more than 20 characters are entered, only use the first 20.  

;Images of four (4) test cases are provided in the attached zip file.

;This program should make use of the 32-bit Irvine assembler library (see Chapter 5 of the Irvine text).




include irvine32.inc
.data
msg byte "CPSC 232 - Program #3",0
msg1 byte "Input a string (20 chars max) >> ",0

reverseString byte " The reverse string is: " ,0

palindromeSuccess byte "The string is a palindrome",0
palindromeError byte "Error - Empty String Entered",0
palindromeError2 byte "The string is not a palindrome",0



;msg                                                                                                                                                                                                                                                                                            



.code

start:
    mov eax,03h           ; Get cursor position and shape
    int 10h

    ; Display a message to the user
    ; (NOTE: we only know it's in "msg1" but don't know the contents
    ;
    mov eax,seg msg1      ; DS:DX to point to msg1
    mov eds,ax
    mov edx,offset msg1

    mov ah,09h           ; Write the string (pointed by DS:DX) to stdout
    int 21h

    mov esi,offset str    ; Get the the destination string location, DS:SI

    ; Read a string in from the user, terminated by new line (0dh)
    ;
read:
    mov ah,01h           ; Read a character
    int 21h

    cmp al,0dh           ; if it's a line feed, then go to "next"
    je next


    mov [esi],al          ; otherwise, store the char in "str" and get the next one
    inc esi
    inc count            ; increment character count
    jmp read

    ; Below is where the actual code to compute a palindrome starts
next:
    mov di,offset str
    mov al,count
    mov cl,al
    mov ch,00h
    dec si
check:
    mov al,[si]
    cmp al,[di]
    jne nt
    dec si
    inc di
    loop check
w