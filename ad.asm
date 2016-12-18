.Model small  
.386
DATA SEGMENT
AD_CS EQU 200h
LED_CS EQU 210h
num db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh,77h,7ch,39h,5eh,79h,71h ; 段码
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

start: mov ax,data
       mov ds,ax
rpt:   mov dx,AD_CS
       out dx,al  ;启动转换
       mov dx,AD_CS
       add dx,2  ; 程序查询方式 EOC
L1:    in al,dx
       test al,01h 
       jz L1 ; 转换未完成
       mov Dx,AD_CS
       inc dx
       in al,dx ; 读取转换数据
       call display ; 显示
       jmp rpt
       
       display proc
       mov si,offset num
       mov bx,si
       mov ch,al
       mov cl,4
       ror al,cl ;取出高4位
       and al,0fh
       mov ah,0
       add bx,ax
       mov al,[bx]
       mov dx,led_cs
       out dx,al
       mov al,02h ; 显示在第二位
       inc dx
       nop 
       out dx,al
       call delay
       mov al,ch
       and al,0fh ; 取出低四位
       mov ah,0
       add si,ax
       mov al,[si] 
       mov dx,led_cs ;送段码
       out dx,al
       mov al,01h ;显示在第一位
       inc dx
       out dx,al
       call delay
       ret
       display endp

       delay proc      ;延时
       push cx
       mov cx,600h
d1:    loop d1
       pop cx
       ret
delay endp  
CODE ENDS
END START
