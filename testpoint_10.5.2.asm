assume cs:code

data segment
	  ;0 2 4 6
	dw 0,0,0,0
	  ;8 A C E
	dw 0,0,0,0
data ends

code segment
	start:	mov ax,data
			mov ss,ax
			mov sp,16
			mov word ptr ss:[0],offset s
			mov ss:[2],cs
			call dworld ptr ss[0]
			nop

	s:		mov ax,offset s
			sub ax,ss:[0cH]
			mov bx,cs
			sub bx,ss:[0eh]
			; ax = 1 和 bx = 0
			
			mov ax,4c00h
			int 21h
code ends

end start