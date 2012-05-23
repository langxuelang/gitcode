DATA    SEGMENT 
B DB "please input$" 
S DB "sucssed$"
A DB 1FH;十进制31
C DB '??';保存输入的数
D DB '?';保存输入数的二倍
E DB '?';保存输入数的一半    
DATA    ENDS

CODE    SEGMENT 
START:MOV AX, DATA
      MOV DS, AX
LP:      MOV DX,SEG B
      MOV DS,DX
      LEA DX,B
      MOV AH,9
      INT 21H
      MOV AL,A
      MOV BL,02H
      MUL BL
      AAM
      MOV D,AH
      MOV D+1,AL
      MOV AL,A
      AAM
      MOV BL,02H
      AAD 
      DIV BL
      AAM
      MOV E,AH
      MOV E+1,AL
      
      MOV AH,1
      INT 21H
      SUB AL,30H
      MOV C,AL
      
      INT 21H
      SUB AL,30H
      MOV C+1,AL
      MOV AL,A
      AAM
      
      MOV BH,C
      MOV BL,C+1
      
      CMP BX,AX
      JZ EQUAL
     
      JA BIG
      JB SMALL
SMALL:
MOV AH,C
MOV AL,C+1
MOV BH,E
MOV BL,E+1
CMP AX,BX
JB MORESMALL
MOV DL,'<'
MOV AH,2
INT 21H
JMP NO
MORESMALL:
MOV DL,'<'
MOV AH,2
INT 21H

MOV DL,'<'
MOV AH,2
INT 21H
JMP NO

BIG:
MOV AH,C
MOV AL,C+1
MOV BH,D
MOV BL,D+1
CMP AX,BX
JA MOREBIG
MOV DL,'>'
MOV AH,2
INT 21H
JMP NO      
MOREBIG:
MOV DL,'>'
MOV AH,2
INT 21H
MOV DL,'>'
MOV AH,2
INT 21H
JMP NO 
EQUAL:
JMP OK
NO:JMP LP
OK:
MOV DX,SEG S
MOV DS,DX
LEA DX,S
MOV AH,9
INT 21H
MOV AH,4CH
INT 21H
CODE    ENDS
END    START
