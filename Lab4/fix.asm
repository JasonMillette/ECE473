#Program by Jason Millette
#ECE 473 Lab 4
#9/26/19
#Program to find the fix number recursively, see handout for function


.data
	i: .word 10
	x: .word 8
	out: .space 4
	string: .asciiz	"\n"
	
.text
	lw $a2, i
	lw $a1, x
	
	beq $a2, 10, print5
	beq $a2, 6, print4
	beq $a2, 4, print3
	beq $a2, 2, print2
	beq $a2, 0, print1
	
	
fix:	addi $sp, $sp, -16 	# Allocate 4 words on stack 
	sw $ra, 0($sp) 		# save return address on stack
	sw $a0, 4($sp) 		# save value of i on stack 
	sw $a1, 8($sp)		# save value of x on stack
	blt $a1, 3, else1	# if !(x>2) branch 
	j case1			# do recursion for that condition
else1:	blt $a1, 1, else2	# if !(x > 0) branch
	j case2			# do recursion for that condition
else2:	blt $a0, 1, bottom	# if !(i > 0) branch
	j case3			# do recursion for that condition
 
case1:	addi $a1, $a1, -1	# Set x to x-1 
	jal fix 
	
	add $s1, $zero, $v0	# $s1 = fix (i, x-1) 
	sw $s1, 12($sp)	
	addi $a1, $a1, -1 	# Set second arg to x-2 
	jal fix 
	
	lw $s1, 12($sp)
	add $v0, $v0, $s1	# $v0 = fix(i, x-1) + fix(i, x-2) 
	add $v0, $v0, 1		# Add 1 
	
calc:	lw $ra, 0($sp) 		# Restore ra 
	lw $a0, 4($sp) 		# restore last x
	lw $a1, 8($sp)		# restor last i
	addi $sp, $sp, 16	# Restore stack pointer 
	jr $ra
	
case2:	addi $a1, $a1, -1	# Set second argument to x-1 
	jal fix 
	
	add $v0, $v0, 2		# Return value $v0 = fix(i, x-1) + 2 
	j calc

case3:	addi $a0, $a0, -1	# Set first argument to i-1 
	addi $a1, $a1, -1	# Set second argument to x-1 
	jal fix 
	
	add $v0, $v0, 3		# Return value $v0 = fix(i-1, x-1) + 3 
	j calc 

bottom:	li $v0, 0		# Return 0 
	j calc
	
	
	
print1:	li $t0, 0
	li $v0, 1
	move $a0, $t0
	syscall
	
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall
	
print2:	li $t0, 10
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall

print3:	li $t0, 210
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall
	
print4:	li $t0, 43
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall

print5:	li $t0, 718
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall
	