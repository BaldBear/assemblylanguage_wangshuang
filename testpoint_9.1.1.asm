assume cs:code

data segment
	db 0,0
	;第二个字节为0即可
data ends

code segment
	start:
			mov ax,data
			mov ds,ax
			mov bx,0
			jmp word ptr [bx+1]

			mov ax,4c00h
			int 21h
code ends

end start