;ª„±‡√∞≈›≈≈–ÚÀ„∑®
N equ 5
mov cx,N-1
j03:push cx
lea BX,A
j02:mov AL,[bx]
cmp AL,[BX+1]
jnb j01
xchg AL,[BX+1]
mov [BX],AL
j01:inc bx
loop j02
pop cx
loop j03  
A db 1,2,3,4,5