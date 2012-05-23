;A中保存着100个成绩，这个程序统计A中100分与0分的个数，分别保存在B中的高字节与低字节
MOV BX,100
MOV word ptr B,0
j00:cmp byte ptr [A+BX-1],0
jnz j01
inc byte ptr B
j01:cmp byte ptr [A+BX-1],100
jnz j02
inc byte ptr B+1 
j02:dec BX
jmp j00   

A 100 dup(?)
B DW ?,?