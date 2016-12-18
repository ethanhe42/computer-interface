.Model small  
.386
DATA SEGMENT

char db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,67h,77h,7ch,39h,5eh,79h,71h
；段码

DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:

MOV AX,DATA   
MOV DS,AX
    
MOV SI,0

GG:
MOV CX , 6
LEA  BX , char
MOV  AH , 01H
JJ:

MOV  AL , [BX+SI]
MOV  DX , 200H ; 送段码
OUT  DX , AL

MOV  AL,AH
MOV  DX,201H ; 送位码
OUT  DX,AL

CALL DELAY
SHL  AL , 1 ; 循环显示
MOV  AH , AL 
DEC  CX

CMP  CX,0  
JNZ  JJ
INC  SI
CMP  SI,10 ; 显示下一个字符
JNZ  GG
JMP  START

DELAY   proc near         ;延时函数，双重循环
		push bx
		push cx
		mov bx,8
d1:  	mov cx,0
d2:  	loop d2
  		dec bx
  		jne d1
		pop cx
		pop bx
  		ret
DELAY  	endp


CODE ENDS
END START
