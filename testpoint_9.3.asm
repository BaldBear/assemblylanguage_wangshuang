assume cs:code

code segment
	start:
			mov ax,2000h
			mov ds,ax
			mov bx,0
	s:
			mov cl,ds:[bx]
			mov ch,0
			;执行loop s时，会先执行cx=cx-1，这里+1抵消后退出loop循环
			inc cx
			inc bx
			loop s
	ok:
			dec bx
			mov dx,bx

			mov ax,4c00h
			int 21h
code ends

end start