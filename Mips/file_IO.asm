.data
	fileName: .asciiz "C:\\Users\\BSBCo\\dev\\usp\\ac\\ep\\myFile.txt"   ### a ser lida
	fileWords: .space 1024 # Guarda os dados "brutos"
		   .align 2
	myArray: .space 1024 # guarda os numeros lidos
		 .align 2

.text

.globl main
main:

jal read_file
j the_end

	read_file:
	
		# usados para testar a validade dos digitos lidos
		li $t7, 10
		li $t8, 0
		li $t9, 9
		li $v1, 0 # counter do tamanho do array
	
		li $v0,13           	# abrir arq -> syscall code = 13
    		la $a0,fileName     	# a0 passa o endereco do arq
    		li $a1,0           	# file flag = read (0)
    		syscall
    		move $s0,$v0        	# descriptor. $s0 = file
	
		# ler arquivo COMPLETO
		li $v0, 14		# ler qrq -> syscall code = 14
		move $a0,$s0		# descriptor
		la $a1,fileWords  	# endereco do buffer que recebera os dados
		la $a2,1024		# tamanho do buffer
		syscall
	
	
		###
		
		subi $sp, $sp, 8
		la $s1, myArray
		sw $s1, 0($sp)
		sw $ra, 4($sp)
		
		loop:
			
			lb $t1, ($a1) # carrega em t0 o primeiro byte de em a1
			subi $t0, $t1, 48 # ascii code -> int
			
			# testa se t0 tem um algarismo valido 0 < t0 < 9
			blt $t0, $t8, exit 
   			bgt $t0, $t9, exit
   			#sb $t1, ($s2) # string saida
			
			lb $a0, 1($a1) # carrega o proximo byte
			jal next # testa o proximo byte e atualiza a0
			lw $ra, 4($sp) # restaura $ra
			
			beq $v0, 1, decimal
			beq $v0, 0, endDecimal
			
			decimal:
				mul $t0, $t0, $t7 #t0 = t0 * 10
				add $a1, $a1, $a3 # anda no arq
				lb $t1, ($a1) # carrega em t1 o primeiro byte de em a1
				subi $t1, $t1, 48 # ascii code -> int
				add $t0, $t0, $t1 
				lb $a0, 1($a1) # carrega o proximo
				jal next # testa o proximo e atualiza a0
				lw $ra, 4($sp) # restaura $ra
				beq $v0, 0, endDecimal
				
				j decimal
				
			endDecimal:
			
			# print
			li $v0, 4
			la $a0,fileWords
			syscall
			
			sw $t0, ($s1) # guarda t0 no array
			add $a1, $a1, $a3 # anda no arquivo
			addi $s1, $s1, 4 # anda no array entrada
			addi $v1, $v1, 1 # Conta o tamanho do array
				
			
			j loop
		
		exit:
			# restaura s1
			lw $s1, 0($sp)
			lw $ra, 4($sp)
			addi $sp, $sp, 8
		

		###
	
		# Fecha o arq
    		li $v0, 16        
    		move $a0,$s0      
    		syscall
    		
    		move $v0, $s1    		
    		jr $ra
	   	
   	next: 
   		# verifica se 0 < a0 < 9
   		subi $a0, $a0, 48
   		blt $a0, $t8, false 
   		bgt $a0, $t9, false 
   		
   		li $a3, 1 # anda 1 byte 
   		li $v0, 1 #tem mais digitos
   		jr $ra
   		
   		false:
   			li $a3, 3 # anda 3 bytes 
   			li $v0, 0 # nao tem mais digitos
   			jr $ra
  
  the_end: