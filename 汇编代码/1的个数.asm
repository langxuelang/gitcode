;这个程序用来统计AL中1的个数
mov BL,00H
mov AL,05H
h2:or AL,AL
jz h1 
MOV CL,AL
dec CL
and AL,CL
inc BL

jmp h2
 
h1:
