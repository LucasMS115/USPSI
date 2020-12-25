# Atividade AC aula 4
# Lucas Mendes Sales 11270736 - turma 94

.data

.text

	main:
		addi $a0, $zero, 1 # a
		addi $a1, $zero, 2 # b
		addi $a2, $zero, 3 # c
		addi $a3, $zero, 4 # c1
		addi $t0, $zero, 5 # c2
		addi $t1, $zero, 6 # c3
		
		sub $sp, $sp 16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		sw $t1, 4($sp)
		sw $t0, 0($sp)
		
		move $fp, $sp
		
		jal calculaRaiz
		
		lw $fp, 8($sp)
		lw $ra, 12($sp)
		addi $sp, $sp, 16
		
		#jr $ra
		li $v0, 10
   		syscall
		
		calculaDelta:
		
			sub $sp, $sp, 20
			
			sw $ra, 16($sp)
			sw $fp, 12($sp)
			sw $a2, 8($sp)
			sw $a1, 4($sp)
			sw $a0, 0($sp)
			
			move $fp, $sp
			
			mul $a1, $a1, 4 # b = b*4 
			mul $a0, $a0, 4 # a = a*4
			mul $a0, $a0, $a2 # a= a*c
			sub $v1, $a1, $a0 
			
			lw $a0, 0($sp)
			lw $a1, 4($sp)
			lw $a2, 8($sp)
			lw $fp, 12($sp)
			lw $ra, 16($sp)
			add $sp, $sp, 20
			
			jr $ra
		
		sqrt:
		
			sub $sp, $sp, 8
			sw $ra, 4($sp)
			sw $fp, 0($sp)
			
			move $fp, $sp

			jal calculaDelta
			addi $v1, $zero, 1 # sempre retorna 1
			
			lw $ra, 4($sp)
			lw $fp, 0($sp)
			addi $sp, $sp, 8
			
			jr $ra
		
		calculaRaiz:
		
			sub $sp, $sp, 12
			sw $ra, 8($sp)
			sw $fp, 4($sp)
			sw $a1, 0($sp)
			
			move $fp, $sp
			
			jal sqrt
			
			mul $a1, $a1, -1
			add $v1, $v1, $a1
			
			lw $a1, 0($sp)
			lw $fp, 4($sp)
			lw $ra, 8($sp)
			addi $sp, $sp, 12
			 
			jr $ra
			
