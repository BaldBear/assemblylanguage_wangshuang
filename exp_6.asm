assume cs:code,ss:stack,ds:data

stack segment

	dw 0,0,0,0,0,0,0,0
stack ends

data segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
data ends

code segment


start:	mov ax, stack
		mov ss, ax
		mov sp, 10H

		mov ax, data
		mov ds, ax
		mov bx, 0

		mov cx, 4

looprow:
		push cx
		mov cx, 4
		mov si, 0

loopletter:
		
		mov al, ds:[bx + 3+si]
		and al,11011111B
		mov ds:[bx+3+si],al
		inc si
		loop loopletter

		pop cx
		add bx, 10H
		loop looprow



		mov ax, 4c00H
		int 21H

code ends
end start
