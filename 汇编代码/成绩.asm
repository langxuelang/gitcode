;A�б�����100���ɼ����������ͳ��A��100����0�ֵĸ������ֱ𱣴���B�еĸ��ֽ�����ֽ�
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