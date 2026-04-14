.data
filename:.string "input.txt"
mode: .string "r"
yes: .string "Yes\n"
no: .string "No\n"

.text
.globl main
main:
addi sp ,sp,-32
sd ra,0(sp)

la a0,filename
la a1,mode
call fopen

mv s0,a0
sd a0,8(sp)
sd a1,16(sp)

mv a0,s0
li a1,0
li a2,2
call fseek

mv a0,s0
call ftell

li s1,0
addi s1,a0,-1

li s2,0

loop:

bgt s2,s1,final
mv a0,s0
mv a1,s1
li a2,0
call fseek

mv a0,s0
call fgetc

mv t0,a0

mv a0,s0
mv a1,s2
li a2,0
call fseek

mv a0,s0
call fgetc

mv t1,a0

bne t0,t1,not_pelindrom
addi s1,s1,-1
addi s2,s2,1
j loop

not_pelindrom:
la a0,no
call printf

mv a0,s0
call fclose

ld ra,0(sp)
addi sp,sp,32
ret

final:
la a0,yes
call printf

mv a0,s0
call fclose

ld ra,0(sp)
addi sp,sp,32
ret
