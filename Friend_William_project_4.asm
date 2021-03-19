;function mergesort(m)
;   var list left, right, result
;   if length(m) ≤ 1
;       return m
;   else
;       var middle = length(m) / 2
;       for each x in m up to middle - 1
;           add x to left
;       for each x in m at and after middle
;           add x to right
;       left = mergesort(left)
;       right = mergesort(right)
;       if last(left) ≤ first(right) 
;          append right to left
;          return left
;       result = merge(left, right)
;       return result

;function merge(left,right)
;   var list result
;   while length(left) > 0 and length(right) > 0
;       if first(left) ≤ first(right)
;           append first(left) to result
;           left = rest(left)
;       else
;           append first(right) to result
;           right = rest(right)
;   if length(left) > 0 
;       append rest(left) to result
;   if length(right) > 0 
;       append rest(right) to result
;   return result











include Irvine32.inc






TITLE Sort array (Array.asm)

; This program sorts an array with random integers
; and outputs them in order


.data
array BYTE 20, 10, 60, 5, 120, 90, 100 ; array with 7 values
arraysize = ($ - array) -1 ; size of array
count DWORD ? ; mem to hold ecx


total DWORD 0
listOne DWORD 2, 4, 6, 8, 10, 12, 14
listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15
listThree (lengthof listOne + lengthof listTwo) DUP(0)

.code
main PROC
	call SortArray ; call function to sort
	call ShowArray ; call function to show
	call DumpRegs		; display the registers
	call WaitMsg        ; Pause until a key is pressed
	exit
main ENDP

MakeList3 PROC

SortArray PROC
	mov esi, OFFSET array
	mov ecx, arraysize ; inner loop
L1:
	mov al, [esi]

;ok, here is a PUSH that is probably not necessary
;in this routine, i see 2 PUSH's and only 1 POP

	push esi ; save esi counter

;now, you save the inner loop count, which need not be loaded yet
;if i were going to use PUSH, though, this is a good place - rather than using the global variable "count"

	mov count, ecx ; save the outer loop count
	mov ecx, arraysize ; outer loop
L2:

;the problem here is, you have not adjusted ESI to point to a different byte on the first pass
;so, you compare the first byte with the first byte

	CMP al, [esi]; compare second value with previous

;for signed bytes ( -128 to +127 ), we use JG, JL, JGE, JLE
;for unsigned bytes ( 0 to 255 ), we use JA, JB, JAE, JBE
;and - there only needs to be one branch instruction
;if it does not branch on JGE, it "falls through" to JL case code

	JGE exchg ; perform exchange
	JLE dntxchg ; dont perform exchange

;here, the dntxchg and exchg code should be very similar, except for the byte swap
;on one, you LOOP - on the other, you POP and LOOP and do a bunch of other stuff :)
;as an added problem, when ECX is 1, and you dntxchg, the LOOP instruction falls through to the exchg code :(

dntxchg:
	inc esi
	loop L2 ; start loop again

exchg:
	mov ebx, [esi] ; store next value in temp
	xchg [esi], eax ; exchange value
	pop esi ; restore esi
	xchg [esi], ebx ; exchange value
	mov eax, [esi] ; reset eax to point to least
	push esi ; save esi
	inc esi ; point to next
	loop L2 ;

;here, you POP again - i think the stack will be misaligned - oops

	pop esi ; pop saved esi back
	inc esi ; point to next element
	mov ecx, count ; restore the loop
	loop L1 ; start all over
	
	ret
	SortArray ENDP


ShowArray PROC

	;show contents of array
	mov edi, OFFSET array
	mov ecx, arraysize
	inc ecx
L3:
	mov ebx, TYPE array
	call DumpMem
	loop L3

	ret
	ShowArray EndP
END main

;another thought....
;see if the ShowArray routine works first,
;by displaying the unsorted array
;you can temporarily comment
;out the call to SortArray to get that part working

;	call SortArray ; call function to sort
	call ShowArray ; call function to show
	call DumpRegs		; display the registers
	call WaitMsg        ; Pause until a key is pressed
	exit

;you might even make it part of the finished program -
;to show the unsorted array before sorting
	call ShowArray ; call function to show
	call SortArray ; call function to sort
	call ShowArray ; call function to show
	call DumpRegs		; display the registers
	call WaitMsg        ; Pause until a key is pressed
	exit




end main
















COMMENT !


total DWORD 0
listOne DWORD 2, 4, 6, 8, 10, 12, 14
listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15
listThree (lengthof listOne + lengthof listTwo) DUP(0)

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

	;combine arrays
	;send combined array to sort
	;print sorted array

    invoke ExitProcess,0
main endp


;----------------------------------------------------------
BubbleSort PROC USES eax ecx esi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD			; array size
;
; Sort an array of 32-bit signed integers in ascending order
; using the bubble sort algorithm.
; Receives: pointer to array, array size
; Returns: nothing
;-----------------------------------------------------------

	mov ecx,Count
	dec ecx			; decrement count by 1

L1:	push ecx			; save outer loop count
	mov esi,pArray		; point to first value

L2:	mov eax,[esi]		; get array value
	cmp [esi+4],eax	; compare a pair of values
	jge L3			; if [esi] <= [edi], don't exch
	xchg eax,[esi+4]	; exchange the pair
	mov [esi],eax

L3:	add esi,4		; move both pointers forward
	loop L2		; inner loop

	pop ecx		; retrieve outer loop count
	loop L1		; else repeat outer loop

L4:	ret
BubbleSort ENDP

!