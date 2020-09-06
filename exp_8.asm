assume cs:code

code segment

			mov ax,4c00h	;3
			int 21h			;2

	start:	mov ax,0		;3

	s:		nop		
			nop				;2
			;第二次运行到这里将执行EBF6，向前跳转10位，因此代码可以正常退出
			mov di,offset s
			mov si,offset s2
			mov ax,cs:[si]
			mov cs:[di],ax
			;EBF6替代放入的s段起始的两个内存单元中

	s0:		jmp short s

	s1:		mov ax,0		;3
			int 21h			;2
			mov ax,0		;3

	s2:		jmp short s1	;2
			nop

code ends
end start