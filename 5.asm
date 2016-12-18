.Model small  
.386
DATA SEGMENT
rowport dw 200h ;行
colport dw 201h ;列
controlport dw 203h ;控制口
led_cs dw 210h ;LCD
char db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6Fh,77h,7ch,39h,5eh,79h,71h ; 段码
table dw 0fefeh  ; 按键位置
  dw 0fefdh
	dw 0fefbh
	dw 0fef7h
	dw 0fdfeh
	dw 0fdfdh
	dw 0fdfbh
	dw 0fdf7h
	dw 0fbfeh
	dw 0fbfdh
	dw 0fbfbh
	dw 0fbf7h
	dw 0f7feh
	dw 0f7fdh
	dw 0f7fbh
	dw 0f7f7h

DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
beg:
MOV AX,DATA   
MOV DS,AX     

mov dx,controlport
mov al,10000010b ; 控制字，PB输入，PA，PC输出
out dx,al
L1: 
call key1
mov bh,ah
mov bl,al
call delay ; 消除按键抖动
call key1
cmp bl,al
jnz beg
cmp bh,ah
jnz beg 
mov ax,bx
call disp ;显示
call delay
jmp L1

key1 proc ; 按键检测
mov ah,0feh
key2: mov al,ah
mov dx,rowport
out dx,al
mov dx,colport
in al,dx
or al,0f0h
cmp al,0ffh
jne num1 ; 未检测到
rol ah,1  ; 逐行检测
jmp key2
num1: ret
key1 endp

delay proc ; 延时
push cx
mov cx,8000h
delay1:loop delay1
pop cx
ret
delay endp

disp proc ; 显示
push bx
push dx
key3: mov si,offset table
mov di,offset char
mov cx,16
key4: cmp ax,[si] ;确定按键编号
jz key5;
inc si
inc si
inc di
loop key4
key5: mov al,[di]  ;显示相应按键
mov dx,led_cs
out dx,al
mov al,01h ;显示在第一个数码管
inc dx
out dx,al
pop dx
pop bx
ret
disp endp

CODE ENDS
END START
