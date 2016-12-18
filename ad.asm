.Model small  
.386
DATA SEGMENT
AD_CS EQU 200h
LED_CS EQU 210h
num db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh,77h,7ch,39h,5eh,79h,71h
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

start: mov ax,data
       mov ds,ax
rpt:   mov dx,AD_CS
       out dx,al
       mov dx,AD_CS
       add dx,2
L1:    in al,dx
       test al,01h
       jz L1
       mov Dx,AD_CS
       inc dx
       in al,dx
       call display
       jmp rpt
       display proc
       mov si,offset num
       mov bx,si
       mov ch,al
       mov cl,4
       ror al,cl
       and al,0fh
       mov ah,0
       add bx,ax
       mov al,[bx]
       mov dx,led_cs
       out dx,al
       mov al,02h
       inc dx
       nop 
       out dx,al
       call delay
       mov al,ch
       and al,0fh
       mov ah,0
       add si,ax
       mov al,[si] 
       mov dx,led_cs
       out dx,al
       mov al,01h
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
