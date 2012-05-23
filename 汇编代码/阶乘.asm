;这个程序实现一个数的阶乘
MOV AX,1
MOV BL,A
xor BH,BH
j02:mul BX
dec BX
jnz j02    

A db 05H
B DW ?,?
mov B,AX