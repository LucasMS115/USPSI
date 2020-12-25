.data

	trueMsg: .asciiz "Condicao foi satisfeita\n"
	falseMsg: .asciiz "Condicao NAO foi satisfeita\n"

.text
	main:
	
		#addi $t0, $zero, 1
		#addi $t1, $zero, 10
		#li $t2, 2
	
		# b vdd # so vai
		# beq $t0, $t1, vdd # Branch if equal
		# bne $t0, $t1, lie # Branch if NOT equal
		# slt $s0, $t0, $t1 # t0 < t1 ? s0 <- 1(true) : s0 <- 0(false
		# beq $s0, $zero, lie
		# bne $s0, $zero, vdd 	 		
		# bgt $t0, $t1, vdd # se t0 > t1 va para vdd
		# blt $t0, $t1, vdd # se t0 < t1 va para vdd
		# bgtz $t0, vdd # se t0 > 0

	
	li $a0, 5 # a0 = 5
	jal Funcao # pula pra funcao
	move $s0, $v0
	li $v0, 10
	syscall
	Funcao:
	sub $sp,$sp,4 # abre um espaco na pilha
	sw $ra, 0($sp) # guarda ra na pilha
	li $t1, 1 # poe 1 em t1
	slti $t0, $a0, 2 # a0 < 2 ?
	beq $t0, $zero, Calcula # t0 = 0 ?
	add $v0, $zero, $zero # poe v0 = 0
	beq $a0, $zero, Sai # a0 = 0?
	add $v0, $t1, $zero # v0 = t1
	Sai:
	lw $ra, 0($sp) # restaura ra
	add $sp, $sp, 4 # zera a pilha
	jr $ra 
	Calcula:
	add $a1, $a0, $zero # copia a0 em a1
	Loop:
	sub $a1, $a1, $t1 # a1 = a1-1 
	jal Multiplica 
	add $a0, $v0, $zero # copia o resultado pra a0
	bne $a1, $t1, Loop # continua se a0 <> t1
	j Sai
	Multiplica:
	mult $a0, $a1 # lo recebe a0 * a1
	mflo $v0 # poe o resultado em v0
 	jr $ra 
 	
		#End program
		li $v0, 10
		syscall
		
	
	#labels
	vdd:
	
		li $v0, 4
		la, $a0, trueMsg
		syscall
	
		li $v0, 10
		syscall
	
	lie:
	
		li $v0, 4
		la, $a0, falseMsg
		syscall
	
		li $v0, 10
		syscall
