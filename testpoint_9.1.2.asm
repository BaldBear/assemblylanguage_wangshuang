assume cs:code

data segment
	dd 12345678h
data ends

code segment
	start:
			mov ax,data
			mov ds,ax
			mov bx,0
			;低位字节代表IP，因此为0即可
			mov [bx],0
			;高位字节代表CS
			mov [bx+2],cs

			jmp dword ptr ds:[0]

			mov ax,4c00h
			int 21h
code ends

end start