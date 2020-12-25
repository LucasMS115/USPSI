.data
	myArray: .space 16 # reserva 16 bytes
	#myArray: .word 111:4 # inicia um array de 4 posicoes com 111 em tudo
	newLine: .asciiz "\n" # nova linha
.text
	
	main:
	
		addi $s0, $zero, 11
		addi $s1, $zero, 22
		addi $s2, $zero, 33
		addi $s3, $zero, 44
		
		addi $t0, $zero, 0 #index = 0
		
		sw $s0, myArray($t0)
		addi $t0, $t0, 4
		sw $s1, myArray($t0)
		addi $t0, $t0, 4
		sw $s2, myArray($t0)
		addi $t0, $t0, 4
		sw $s3, myArray($t0)
		
		addi $t0, $zero, 0 # clear t0
		
		while:
		
			beq $t0, 16, exit
			lw $a1, myArray($t0)
			addi $t0, $t0, 4
			jal printInt
			jal nl
			j while
		
		exit:
			#End program
			li $v0, 10
			syscall
		
		
	
	
	
	printInt: 
		li $v0, 1
		add $a0,$zero , $a1
		syscall
		
		jr $ra #vola pra onde a funcao foi chamada
	
	nl:
		li $v0, 4
		la $a0, newLine
		syscall
		
		jr $ra