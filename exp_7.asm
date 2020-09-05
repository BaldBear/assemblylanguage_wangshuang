assume cs:code,ds:data,ss:stack

data segment

		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
		dd	345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
		;以上是表示21年公司总收入的21个dword数据	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800
		;以上表示21年公司员工数量
data ends



table segment
		db 21 dup('year summ ne ?? ')
table ends



stack segment
		db  128 dup(0)
stack ends



code segment

start:
		;ds用于表示元数据地址
		mov ax,data
		mov ds,ax
		;ss:[sp]用于表示栈
		mov ax,stack
		mov ss,ax
		mov sp,128
		;es表示目标地址
		mov ax,table
		mov es,ax

		mov di,0		;ds:[di]
		mov si,84		;ds:[si]
		mov bx,168		;ds:[bx]
		mov bp,0		;es:[bp]

		mov cx,21
inputtable:
		;转移年份
		push ds:[di]
		pop es:[bp]
		push ds:[di+2]
		pop es:[bp+2]

		;			0123456789ABCDEF
		;db 21 dup('year summ ne ?? ')
		;转移总收入
		mov ax,ds:[si]
		mov dx,ds:[si+2]
		mov es:[bp+5],ax
		mov es:[bp+7],dx

		push ds:[bx]
		pop es:[bp+0AH]

		div word ptr ds:[bx]

		mov es:[bp+0DH],ax

		add di,4
		add si,4
		add bx,2
		add bp,16
		loop inputtable

		
		mov ax,4c00h
		int 21h


code ends
end start
		

