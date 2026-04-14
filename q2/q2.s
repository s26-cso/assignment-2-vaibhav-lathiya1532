.data
fmt:    .string "%d "
fmt_nl: .string "\n"

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
addi s0,s0,-1   
mv t6,a1        
blez s0,fexit

    
slli a0,s0,3
call malloc
 mv   s1, a0       
slli a0,s0,3
call malloc
mv s2,a0        # s2 = Results (Indices)

slli a0,s0,3
call malloc
mv  s3,a0        # s3 = Index Stack

   
li s5, 0
parse_loop:
bge  s5, s0, algo_start
addi t0, s5, 1
slli t0, t0, 3
add  t1, t6, t0
ld   a0, 0(t1)
    
    
addi sp, sp, -8
sd   t6, 0(sp)
call atoi
ld   t6, 0(sp)
addi sp, sp, 8
    
slli t0, s5, 3
 add  t1, s1, t0
sd   a0, 0(t1)     # Store IQ value
addi s5, s5, 1
j    parse_loop


algo_start:
li   s4, -1        # stack_top = -1
li   s5, 0         # i = 0

outer_loop:
bge  s5, s0, clear_stack
slli t0, s5, 3
add  t1, s1, t0
ld   t2, 0(t1)     

stack_while:
bltz s4, push_i    # Empty stack? Push current index
    # Peek at the index on top of the stack
slli t0, s4, 3
add  t1, s3, t0
ld   t3, 0(t1)     # t3 = index of a previous student

slli t0, t3, 3
add  t1, s1, t0
ld   t4, 0(t1)     

   
ble  t2, t4, push_i

  
slli t0, t3, 3
add  t1, s2, t0
sd   s5, 0(t1)    

addi s4, s4, -1   
j    stack_while

push_i:
addi s4, s4, 1     # Push current student index onto stack
slli t0, s4, 3
add  t1, s3, t0
 sd   s5, 0(t1)
    
addi s5,s5,1
j    outer_loop

clear_stack:
 bltz s4,print_results
slli t0,s4,3
add t1,s3,t0
ld t2,0(t1)     # Index with no greater element
    
slli t0,t2,3
add t1,s2,t0
li t3,-1
sd t3,0(t1)     # Result[t2] = -1
    
addi s4, s4, -1
j    clear_stack


print_results:
li s5, 0
print_loop:
bge  s5, s0, fexit
slli t0, s5, 3
add t1, s2, t0
ld a1, 0(t1)    
la a0, fmt
call printf
addi s5, s5, 1
j print_loop

fexit:
la   a0, fmt_nl
call printf
 # Restore and Return
ld  ra,56(sp)
ld  s0,48(sp)
ld  s1,40(sp)
ld  s2,32(sp)
ld  s3,24(sp)
ld  s4, 16(sp)
ld  s5,8(sp)
addi sp,sp,64
li a0,0
ret
    