assume cs:code,ss:stack,ds:data

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

string segment
		db 10 dup('0'),0
string ends



code segment
	
start:
			;ss:[sp]用于表示栈
			mov ax,stack
			mov ss,ax
			mov sp,128

			call init_reg
			call clear_screen
			call input_table
			call output_table

			mov ax,4c00h
			int 21h

;============================================
clear_screen:
			mov bx,0
			mov dx,0700h
			mov cx,2000
clear:
			mov es:[bx],dx
			add bx,2
			loop clear

			ret

;============================================

init_reg:
			mov ax,0B800h
			mov es,ax
			mov bx,data
			mov ds,bx
			ret
;============================================
input_table:
			;ds用于表示元数据地址
			mov ax,data
			mov ds,ax
			;es表示目标地址
			mov ax,table
			mov es,ax

			mov di,0		;ds:[di] 年份
			mov si,84		;ds:[si] 总收入
			mov bx,168		;ds:[bx] 员工数
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
			mov ax,ds:[si+0]
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

			ret


;============================================
output_table:

			mov ax,table
			mov ds,ax
			mov ax,string
			mov es,ax


			mov si,0	;ds:[si]
			mov di,160*3
			add di,4

			mov cx,21

outputtable:
			call show_year
			call show_sum
			call show_employee
			call show_avg_income
			
			add di,160
			add si,16
			loop outputtable	
			ret

			;			0123456789ABCDEF
			;db 21 dup('year summ ne ?? ')

			;db 10 dup('0'),0


;============================================			
show_year:
			push ax
			push bx
			push cx
			push ds
			push es
			push si
			push di


			mov bx,0B800h
			mov es,bx

			mov cx,4

showyear:
			mov al,ds:[si]
			mov es:[di],al
			add di,2
			inc si
			loop showyear

			pop di
			pop si
			pop es
			pop ds
			pop cx
			pop bx
			pop ax

			ret
;============================================

show_sum:
			push ax
			push dx
			push ds
			push si
			push di

			mov ax,ds:[si+5]
			mov dx,ds:[si+7]
			mov si,9
			add di,10*2
			call show_number

			pop di
			pop si
			pop ds
			pop dx
			pop ax

			ret
;============================================

show_number:
			push ax
			push bx
			push cx
			push dx
			push ds
			push es
			push si
			push di
			push bp

			call isShortDiv

			mov bx,string
			mov ds,bx
			mov bx,0B800h
			mov es,bx

			call show_string

			pop bp
			pop di
			pop si
			pop es
			pop ds
			pop dx
			pop cx
			pop bx
			pop ax
			ret

;============================================
show_employee:
			push ax
			push dx
			push ds
			push si
			push di

			mov ax,ds:[si+5]
			mov dx,0
			mov si,9
			add di,20*2
			call show_number

			pop di
			pop si
			pop ds
			pop dx
			pop ax

			ret


;============================================
show_avg_income:
			push ax
			push dx
			push ds
			push si
			push di

			mov ax,ds:[si+0DH]
			mov dx,0
			mov si,9
			add di,30*2
			call show_number

			pop di
			pop si
			pop ds
			pop dx
			pop ax

			ret
			
;============================================

show_string:
			push cx
			push ds
			push es
			push si
			push di
			mov cx,0

shownumber:
			mov cl,ds:[si]
			jcxz showNumberRet
			mov es:[di],cl
			add di,2
			inc si
			jmp shownumber


showNumberRet:
			pop di
			pop si
			pop es
			pop ds
			pop dx
			ret
;============================================

isShortDiv:
			mov cx,dx
			jcxz short_Div

			mov cx,10
			push ax
			mov bp,sp

			call long_Div

			add sp,2
			add cl,30h
			mov es:[si],cl
			dec si
			jmp isShortDiv

			ret
;============================================	

short_Div:
			mov cx,10
			div cx
			add dl,30h
			mov es:[si],dl
			mov cx,ax
			jcxz shortDivRet
			dec si
			mov dx,0
			loop short_Div

shortDivRet:
			ret

;============================================	
long_Div:
			mov ax,dx
			mov dx,0
			div cx
			push ax
			mov ax,ss:[bp+0]
			div cx
			mov cx,dx
			pop dx

			ret


code ends
end start

