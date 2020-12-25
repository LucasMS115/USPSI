#em mips chamam funcoes de procedures/procedimentos
.data
	message: .asciiz "Coé rapazeadaaa!\nBlz?\n"
	n1: .word 10
	n2: .word 25
.text
	main:
	
		lw $a1, n1($zero) # o a0 n pode usa 
		lw $a2, n2($zero)
	
		jal displayMessage
		jal sum
		
		
		#continuando o codigo(exemplo)
		li $v0, 1
		add $a0, $zero, $v1
		syscall
		
	
	# Dizer ao sistema q a execucao do programa acabou
	li $v0, 10
	syscall 
	
	displayMessage: 
		li $v0, 4
		la $a0, message
		syscall
		
		jr $ra #vola pra onde a funcao foi chamada
		
	sum:
		add $v1, $a1, $a2 #por convenção usa-se v1 para retornar valores e a para passar parametros
		jr $ra