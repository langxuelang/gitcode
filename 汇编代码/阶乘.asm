;�������ʵ��һ�����Ľ׳�
MOV AX,1
MOV BL,A
xor BH,BH
j02:mul BX
dec BX
jnz j02    

A db 05H
B DW ?,?
mov B,AX