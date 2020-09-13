assume cs:code,ds:data

data segment
		db "divider error",0 ;内存覆盖
data ends

stack segment
		db 128 dup(0)
stack ends

code segment
start:
			mov ax,stack
			mov ss,ax
			mov sp,128

			call cpy_new_int0
			call set_new_int0

			mov ax,1
			mov dx,1
			mov bx,1
			div bx

			mov ax,4c00h
			int 21h


;=======================================

set_new_int0:
			
			mov bx,0
			mov es,bx

			mov word ptr es:[0*4],7E00h
			mov word ptr es:[0*4+2],0

			ret
;=======================================
new_int0:

			jmp newint0
			db  'divider error',0

newint0:
			mov bx,0B800h
			mov es,bx
			mov bx,0
			mov ds,bx
			mov di,160*10
			add di,8*5

			mov si,7e03h
			;ds:[si]表示输出字符的位置

showString:
			mov dl,ds:[si]
			cmp dl,0
			je showStringRet
			mov es:[di],dl
			add di,2
			inc si
			jmp showString


			mov ax,4c00h
			int 21h



showStringRet:
			ret

new_int0_end:
			nop
;=======================================
;将new_int0中的指令复制到7e00:0000中
cpy_new_int0:
			mov bx,cs
			mov ds,bx
			mov si,OFFSET new_int0

			mov bx,0
			mov es,bx
			mov di,7E00h

			mov cx,OFFSET new_int0_end - new_int0
			cld
			rep movsb

			ret
code ends
end start