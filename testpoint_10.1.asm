assume cs:code

stack segment
	db 16 dup(0)
stack ends

code segment
	start:	mov ax,stack
			mov ss,ax
			mov sp,16
			;mov ax,____
			mov ax,1000h
			push ax
			;mov ax,____
			mov ax,0
			push ax
			retf


code ends

end start