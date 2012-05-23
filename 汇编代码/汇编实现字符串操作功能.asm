;字符串操作实现strcpy strcmp strlen strcat

data segment
   A DB "gtob$"
   AC DB 0
   C DB "gto$"
   B DB 100 dup('?') 
   newstr DB 100 dup('?') 
   CC DB 0
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    LEA BX,A
    CALL strlen
    CALL strcpy
    
    MOV DX,SEG B
   MOV DS,DX
    LEA DX,B
    MOV AH,9
    INT 21H
   LEA AX,A
    LEA BX,C
    CALL strcmp
   MOV DL,AL
    ADD DL,30H
    MOV AH,2
    INT 21H
    CALL strcat
    LEA DX,newstr
    MOV AH,9
    INT 21H
    JMP ENDT

strlen PROC

MOV CX,1
MOV AL,'$'
j02:CMP AL,[BX]
JZ j01
INC BX
INC CX
JMP j02
j01:        
RET    
strlen ENDP  


strcat PROC
LEA BX,A
CALL strlen
MOV SI,SEG A
MOV DS,SI
LEA SI,A

MOV DI,SEG newstr
MOV ES,DI
LEA DI,newstr
DEC CX
PUSH CX
CLD
REP MOVSB

MOV SI,SEG C
MOV DS,SI
LEA SI,C

MOV DI,SEG newstr
MOV ES,DI
LEA DI,newstr
POP CX
ADD DI,CX
LEA BX,C
CALL strlen

CLD
REP MOVSB    
RET
strcat ENDP


strcpy PROC 



MOV SI,SEG A
MOV DS,SI
LEA SI,A 

MOV DI,SEG B
MOV ES,DI
MOV DI,OFFSET B
CLD
REP MOVSB
   
RET
strcpy ENDP

strcmp PROC;入口参数AX，BX分别保存两个字符串变量的地址
PUSH AX   ;将地址压栈
PUSH BX
CALL strlen

MOV DX,CX ;获得BX的长度
POP BX
POP AX
PUSH AX   ;将地址压栈
PUSH BX
MOV BX,AX

CALL strlen
MOV AX,CX;获得AX的长度
MOV AC,AL
MOV CC,DL
CMP AL,DL
JNZ notequal
MOV SI,SEG A
MOV DS,SI
LEA SI,A

MOV DI,SEG C
MOV ES,DI
LEA DI,C
CLD
MOV CX,DX
REPE CMPSB
JNE notequal
MOV AL,0
POP BX
POP DX
JMP last 


notequal:
MOV AL,AC
CMP AL,CC
JB J06
MOV CH,0
MOV CL,CC
J06:
MOV CL,AC ;循环的控制变量

POP SI   ;将变量的地址弹出
POP DI

J08:


MOV DL,[SI]

MOV DH,[DI]
CMP DH,DL
JA big

CMP DH,DL
JB small

INC SI
INC DI
LOOP J08
MOV AL,AC
CMP AL,CC
JA big
JMP small
big:
MOV AL,1
JMP last
small:
MOV AL,2
JMP last

last:
RET    
strcmp ENDP


ENDT:
ends

end start ; set entry point and stop the assembler.
