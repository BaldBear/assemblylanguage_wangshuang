assume cs:code

data segment
		db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment

start:
			mov ax,data
			mov ds,ax
			mov si,0

			call letter

			mov ax,data
			mov ds,ax
			mov ax,4c00h
			int 21h
			
;=================================
letter:
			mov cl,ds:[si]
			cmp cl,0
			je letterRet
			cmp cl,'a'
			jb next
			cmp cl,'z'
			ja next
			sub cl,20h
			mov byte ptr ds:[si],cl

next:		inc si
			jmp letter
letterRet:
			ret
code ends
end start