;Quiz 5

include Irvine32.inc


.data
store DWORD ?

.code
main proc
	mov eax,0
	mov ecx,10
	Lout:
	push ecx
	mov ecx, 5
	Lin:
	inc eax
	mov store,eax
	loop Lin
	pop ecx
	loop Lout

	invoke ExitProcess,0
main endp
end main
