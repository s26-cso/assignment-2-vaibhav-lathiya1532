.data
fmt:    .string "%d "
fmt_nl: .string "%d\n"

.text
.globl main
main:
addi sp, sp, -64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)
sd s4,16(sp)
sd s5,8(sp)

mv s0, a0
addi s0, s0, -1    
mv t6, a1
blez s0, exit

slli a0, s0, 3
call malloc
mv s1, a0           

slli a0, s0, 3
call malloc
mv s2, a0           

slli a0, s0, 3
call malloc
mv s3, a0        

li t0, 0
init_loop:
bge t0, s0, parse_loop_start
slli t1, t0, 3
add t2, s2, t1
li t3, -1
sd t3, 0(t2)
addi t0, t0, 1
j init_loop

parse_loop_start:
li s5, 0

parse_loop:
bge s5, s0, algo_start

addi t0, s5, 1
slli t0, t0, 3
add t1, t6, t0
ld a0, 0(t1)

addi sp, sp, -8
sd t6, 0(sp)
call atoi
ld t6, 0(sp)
addi sp, sp, 8

slli t0, s5, 3
add t1, s1, t0
sd a0, 0(t1)

addi s5, s5, 1
j parse_loop

algo_start:
li s4, -1      
li s5, 0      

outer_loop:
bge s5, s0, clear_stack

# t2 = current value
slli t0, s5, 3
add t1, s1, t0
ld t2, 0(t1)
stack_while:
    bltz s4, push_i

    slli t0, s4, 3
    add  t1, s3, t0
    ld   t3, 0(t1)

    
    slli t0, t3, 3
    add  t1, s1, t0
    ld   t4, 0(t1)

    bge  t4, t2, push_i

    slli t0, t3, 3
    add  t1, s2, t0
    sd   s5, 0(t1)

    addi s4, s4, -1
    j stack_while
push_i:
addi s4, s4, 1
slli t0, s4, 3
add t1, s3, t0
sd s5, 0(t1)

addi s5, s5, 1
j outer_loop


clear_stack:
bltz s4, print_results

slli t0, s4, 3
add t1, s3, t0
ld t2, 0(t1)

slli t0, t2, 3
add t1, s2, t0
li t3, -1
sd t3, 0(t1)

addi s4, s4, -1
j clear_stack

print_results:
li s5, 0

addi t2,s0,-1
print_loop:
bge s5, s0, fexit

slli t0, s5, 3
add t1, s2, t0
ld a1, 0(t1)

beq t2,s5,fexit

la a0, fmt
call printf

addi s5, s5, 1
j print_loop

fexit:
slli t3,t2,3
add t1,s2,t3
ld a1,0(t1)
la a0, fmt_nl
call printf

ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
ld s4,16(sp)
ld s5,8(sp)
addi sp, sp, 64

li a0, 0
ret
exit:
# restore
ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
ld s4,16(sp)
ld s5,8(sp)
addi sp, sp, 64

li a0, 0
ret
