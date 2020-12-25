.data
	newLine: .asciiz "\n" # nova linha
	
.text

	main:
	
		addi $s0, $zero, 10
		jal increaseReg
		jal nl
	
		li $v0, 1
		add $a0, $zero, $s0
		syscall
	
		# Ending
		li $v0, 10
		syscall
	
	increaseReg: 
		# Se for usar um registrador s em uma funcao, tem q salvar o valor original em algum lugar primeiro
		addi $sp, $sp, -4 # alocando 4 bytes (32 bits) na pilha 
		sw $s0, 0($sp) # guarda o valor de s0 na pos 0 da pilha
		
		addi $s0, $s0, 25 # adiciona a s0 o valor de s0 + 25 = 35
		
		# Printa o valor de s0
		li $v0, 1
		move $a0, $s0
		syscall
		
		lw $s0, 0($sp) # recupera o s0 original
		addi $sp, $sp, 4 # restaura a pilha
		
		jr $ra # volta pra onde a funcao foi chamada
		
	nl:
		li $v0, 4
		la $a0, newLine
		syscall
		
		jr $ra