; multi-segment executable file template.

data segment
A DB 32H,0FH;十进制的50与15
B DB 0
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    MOV AL,A
    MOV BL,A+1
    CALL zuixiao
    ADD B,30H 
    MOV DL,B
    MOV AH,2

    INT 21H    
    JMP endprom: 
zuixiao PROC
MOV AH,0
MOV BH,0
CMP AL,BL
JB j01
MOV DL,BL
JMP j05
j01:MOV DL,AL
j05:
MOV CL,02H
j03:PUSH AX
PUSH BX
DIV CL
CMP AH,0
JNZ j02
MOV AL,BL
DIV CL
CMP AH,0
JNZ j02
MOV B,CL
POP BX
POP AX
JMP find
j02:INC CL 
CMP CL,DL
JA none
POP BX
POP AX  
JMP j03
none:  
find:
RET        
zuixiao ENDP
endprom:    
ends

end start ; set entry point and stop the assembler.
