 ;求最大公约数
 data segment
  A DB 0FH,14H
  B DB 0
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    MOV AL,A
    MOV BL,A+1
    ; add your code here
     CALL zx
      ADD B,30H
      MOV DL,B
      MOV AH,2
      INT 21H
      JMP j03 
zx PROC
    MOV AH,0
    CMP AL,BL
    JA j01
    XCHG AL,BL
j01:DIV BL
OR AH,AH
JZ j02
MOV AL,BL
MOV BL,AH
XOR AH,AH
JMP j01
j02:MOV B,BL
ret 
j03:       
   
code ends

end start ; set entry point and stop the assembler.
