.data 
.equ space,24
.equ val, 0
.equ left,8
.equ right,16

.text
.globl make_node
make_node:
addi sp,sp,-16
sd ra,8(sp)

addi t2,a0,0
sw t2,0(sp) 
li a0,space
call malloc

lw t2,0(sp)

sw t2,val(a0)
sd x0,left(a0)
sd x0,right(a0)

ld ra,8(sp)
addi sp,sp,16
ret








.globl insert
insert:
addi sp,sp,-32
sd ra,0(sp)
sd a0,8(sp)
sw a1,16(sp)

loop1:
lw t0, val(a0)       # node value
lw t1, 16(sp)        # key
bge t0, t1, move_left
# go right
ld t2, right(a0)
beq t2, x0, right_insert
mv a0, t2
j loop1

move_left:
ld t2, left(a0)
beq t2, x0, left_insert
mv a0, t2
j loop1

left_insert:
sd a0,24(sp)
lw a0,16(sp)
call make_node
ld a2,24(sp)
sd a0,left(a2)

j exit

right_insert:
sd a0,24(sp)
lw a0,16(sp)
call make_node
ld a2,24(sp)
sd a0,right(a2)
j exit

exit:
ld ra,0(sp)
ld a0,8(sp)
addi sp,sp,32
ret




.globl get
get:

addi sp,sp,-32
sd ra,0(sp)
sd a0,8(sp)
sw a1,16(sp)

loop2:
beq a0,x0,done
lw t0,val(a0)
addi t1,a1,0
beq t0,t1,done
bge t0,t1,mov_left
ld a0,right(a0)
j loop2
mov_left:
ld a0,left(a0)
j loop2
done:
ld ra,0(sp)
addi sp,sp,32
ret




.globl getAtMost
getAtMost:
addi sp,sp,-32
sd ra,0(sp)
sw a0,8(sp)
sd a1,16(sp)

li t0,-1
loop3:
beq a1,x0,null
addi t1,a0,0
lw t2,val(a1)
beq t1,t2,num_exist
bgt t2,t1,go_left

lw a3,val(a1)
blt t0,a3,change
ld a1,right(a1)
j loop3

change:
addi t0,a3,0
ld a1,right(a1)
j loop3

go_left:
ld a1,left(a1)
j loop3

num_exist:
addi t0,t1,0
j null

null:
addi a0,t0,0
ld ra,0(sp)
addi sp,sp,32
ret
