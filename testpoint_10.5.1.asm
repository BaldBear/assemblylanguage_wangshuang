assume cs:code

stack segment
	dw 8 dup(0)
stack ends

code segment
	start:	mov ax,stack
			mov ss,ax
			mov sp,16
			mov ds,ax
			mov ax,0

			call word ptr ds:[0EH]
			;push ip，ds:[0EH]指向栈底内存，因此有jmp s

	s:		inc ax
			inc ax
			inc ax
			;因此最终ax=3
			
			mov ax,4c00h
			int 21h
code ends

end start