.data
	n1: .word 10
	n2: .word 25
.text

	lw $t0, n1($zero)
	lw $t1, n2($zero)
	lw $s0, n1($zero)
	lw $s1, n2($zero)
	addi $s2, $zero, 7 # adicoina o valor de 0 + 5 ao registrador s2 
	addi $s3, $zero, 2
	
	add $t2, $t0, $t1 # t2 <- t0 + t1 = n1 + n2
	sub $t3, $s1, $s0 # t3 <- s1 - s0 = n2 - n1
	mul $t4, $s2, $s3 # t4 <- s2*s3 = 5*2
	mult $t0, $s2 # t0*s2 o resultado vai para o registrador lo (p/ maiores q 16 bits)
	mflo $t5 # move from lo -> t5 (se fosse mto grande tinha q ser mfhi)
	sll $t6, $t0, 3 # pega o valor que esta em t0 = 10, multiplica ele por 2^3 = 8 e guarda o res em t6
	div $t7, $t0, $s3 # t7 <- t0/s3 = 10/2 = 5
	div $s4, $t0, 5 # s4 <- t0/5 = 10/5 = 2
	div $t1, $t0 # lo <- t1/t0 = 25/10 = 2 com resto 5
	mflo $s5 # o quociente fica em lo 
	mfhi $s6 # o resto fica em hi
	
	li $v0, 1
	add $a0, $zero, $t2 # adiciona o valor de t2 em a0
	syscall
	
	li $v0, 1
	move $a0, $t3 # move o valor de t3 para a0
	syscall
	
	li $v0, 1
	add $a0, $zero, $t4
	syscall
	
	li $v0, 1
	add $a0, $zero, $t5
	syscall
	
	li $v0, 1
	add $a0, $zero, $t6
	syscall
	
	li $v0, 1
	add $a0, $zero, $t7
	syscall
	
	li $v0, 1
	add $a0, $zero, $s4
	syscall
	
	li $v0, 1
	add $a0, $zero, $s5
	syscall
	
	li $v0, 1
	add $a0, $zero, $s6
	syscall
