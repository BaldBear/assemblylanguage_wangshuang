assume cs:code,ds:data,ss:stack

data segment
			;0123456789ABCDEF
	db		'welcome to masm!'	;ds:[bx]

	db		00000010B 	;绿色	;ds:[si]
	db		00100100B  ;绿底白色
	db		01110001B  ;白底蓝色

data ends

stack segment
	db 		128 dup(0)
stack ends


code segment
	start:	mov ax,data
			mov ds,ax
			mov bx,0	;访问字符
			mov si,16	;访问属性


			mov ax,0b800h
			mov es,ax
			mov di,1024
			mov dx,0
			;es:[di]用于显示字符

			mov cx,3

	showmasm:
			push bx
			push cx
			push si
			push di
			;外循环，循环三次输出三行	

			mov cx,16	;内循环16次，输出16个字符
			mov dh,ds:[si]	;每行的颜色是一样的
	show:	
			mov dl,ds:[bx]
			mov es:[di],dx
			inc bx
			add di,2
			loop show

			pop di
			pop si
			pop cx
			pop bx

			add di,160	;换行
			inc si		;换颜色
			loop showmasm



			mov ax,4c00h
			int 21h
code ends

end start