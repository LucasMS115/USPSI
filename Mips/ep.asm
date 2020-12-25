.data

	fileName: .asciiz "myFile.txt"   ### a ser lida

	fileWords: .space 1024 # Guarda os dados "brutos"
	   .align 2
	   
	myArray: .space 1024 # guarda os numeros lidos
	 .align 2
	 
	labelFim: .asciiz "Ordenados:"
	separador: .asciiz " "

.text
.globl main
main:
	addi $sp, $sp, -4              #abre 1 espaco na pilha
	sw $ra, 0($sp)                 #salva $ra
	
	jal read_file
	
	move $a2, $v0
	move $a0, $v1
	
	li $a1, 0                      #$a1 = tipo 0 == selection | 1 == quick
	
	jal ordena                     #chama ordena
	
	lw $ra, 0($sp)                 #restaura $ra
	addi $sp, $sp, 4               #remove 1 espaco na pilha
	#jr $ra
	
	# print console 
	jal printArr	
	
	li $v0, 10
   	syscall

################################   ORDENA   ################################
ordena:
	addi $sp, $sp, -8              #abre 1 espaco na pilha
	sw $a0, 4($sp)                 #salva tamanho do array
	sw $ra, 0($sp)                 #salva $ra
	
	beq $a1, $zero, ordenar_selection
	addi $t0, $a0, -1
	move $a0, $a2
	
	li $a1, 0
	
	move $a2, $t0
	
	jal quick_sort
	
	j fim
	
	ordenar_selection:
	move $a1, $a0
	move $a0, $a2
	
	jal selection_sort
	
	fim:
	lw $v0, 4($sp)                 # retorna tamanho do array
	lw $ra, 0($sp)                 #restaura $ra
	addi $sp, $sp, 8               #remove 1 espaco na pilha
	
	jr $ra                         #pula para $ra

################################ QUICK SORT ################################
quick_sort:
	addi $sp, $sp, -28             #abre 7 espaços na pilha
	sw $a0, 24($sp)                #salva $a0
	sw $a1, 20($sp)                #salva $a1
	sw $a2, 16($sp)                #salva $a2
	sw $s0, 12($sp)                #salva $s0
	sw $s1, 8($sp)                 #salva $s1
	sw $s2, 4($sp)                 #salva $s2
	sw $ra, 0($sp)                 #salva $ra

	addi $s0, $a1, 0               #$s0 = p
	addi $s1, $a2, 0               #$s1 = r
	
	slt $t0, $s0, $s1              #$t0 = p < r
	beq $t0, $zero, end_if_quick   #if $t0 == 0 pula para end_if_quick
	
	jal particiona                 #chama particiona
	
	addi $s2, $v0, 0               #$s2 = q = retorno do particiona
	
	addi $a2, $s2, -1              #$a2 = q - 1
	jal quick_sort                 #chama quick_sort
	
	addi $a1, $s2, 1               #$a1 = q + 1
	addi $a2, $s1, 0               #$a2 = r
	jal quick_sort                 #chama quick_sort
	
	end_if_quick:
	
	lw $a0, 24($sp)                #restaura $a0
	lw $a1, 20($sp)                #restaura $a1
	lw $a2, 16($sp)                #restaura $a2
	lw $s0, 12($sp)                #restaura $s0
	lw $s1, 8($sp)                 #restaura $s1
	lw $s2, 4($sp)                 #restaura $s2
	lw $ra, 0($sp)                 #restaura $ra
	addi $sp, $sp, 28              #remove 7 espaços da pilha
	
	jr $ra                         #pula para $ra
	
particiona:
	addi $sp, $sp, -44             #abre 11 espaços na pilha
	sw $a1, 40($sp)                #salva $a1
	sw $a2, 36($sp)                #salva $a2
	sw $s0, 32($sp)                #salva $s0
	sw $s1, 28($sp)                #salva $s1
	sw $s2, 24($sp)                #salva $s2
	sw $s3, 20($sp)                #salva $s3
	sw $s4, 16($sp)                #salva $s4
	sw $s5, 12($sp)                #salva $s5
	sw $s6, 8($sp)                 #salva $s6
	sw $s7, 4($sp)                 #salva $s7
	sw $ra, 0($sp)                 #salva $ra
	
	addi $s0, $a1, 0               #$s0 = p
	addi $s1, $a2, 0               #$s1 = r
	
	sll $s2, $s1, 2                #$s2 = r * 4
	add $s2, $s2, $a0              #$s2 = &A[r]
	lw $s7, ($s2)                  #$s7 = x
	
	addi $s3, $s0, -1              #$s3 = i = p - 1
	
	addi $s4, $s0, 0               #$s4 = j
	
	begin_for:
		slt $t0, $s4, $s1      # $t0 = j < r
		beq $t0, $zero, end_for# if $t0 == 0 pula para end_for
		
		sll $s5, $s4, 2        #$s5 =  j * 4
		add $s5, $s5, $a0      #$s5 = &A[j]
		lw $s6, ($s5)          #$s6 = A[j]
		
		sle $t1, $s6, $s7      #$t1 = A[j] <= x
		beq $t1, $zero, end_if #if $t1 == 0 pula para end_if
		
		addi $s3, $s3, 1       #$s3 = $s3 + 1 = i++
		
		sll $a1, $s3, 2        #$a1 = i * 4
		add $a1, $a1, $a0      #$a1 = &A[i]
		
		addi $a2, $s5, 0       #$a2 = $s5 = &A[j]
		
		jal swap               #pula para swap
		
		end_if:
		
		addi $s4, $s4, 1       #$s4 = $s4 + 1 = j++
		
		j begin_for
		
	end_for:
	
	addi $s3, $s3, 1               #$s3 = $s3 + 1 = i++
	
	sll $a1, $s3, 2                #$a1 = i * 4
	add $a1, $a1, $a0              #$a1 = &A[i]
	
	sll $a2, $s1, 2                #$a2 = r * 4
	add $a2, $a2, $a0              #$a2 = &A[r]
	
	jal swap                       #pula para swap
	
	addi $v0, $s3, 0               #$v0 = i
	
	lw $a1, 40($sp)                #restaura $a1
	lw $a2, 36($sp)                #restaura $a2
	lw $s0, 32($sp)                #restaura $s0
	lw $s1, 28($sp)                #restaura $s1
	lw $s2, 24($sp)                #restaura $s2
	lw $s3, 20($sp)                #restaura $s3
	lw $s4, 16($sp)                #restaura $s4
	lw $s5, 12($sp)                #restaura $s5
	lw $s6, 8($sp)                 #restaura $s6
	lw $s7, 4($sp)                 #restaura $s7
	lw $ra, 0($sp)                 #restaura $ra
	addi $sp, $sp, 44              #remove 11 espacos da pilha

	jr $ra

	
##################### SELECTION SORT ##########################################	
selection_sort:
	addi $sp, $sp, -32             #abre 8 espacos na pilha
	sw $a0, 28($sp)                #salva $a0
	sw $a1, 24($sp)                #salva $a1
	sw $s0, 20($sp)                #salva $s0
	sw $s1, 16($sp)                #salva $s1
	sw $s2, 12($sp)                #salva $s2
	sw $s3, 8($sp)                 #salva $s3
	sw $s4, 4($sp)                 #salva $s4
	sw $ra, 0($sp)                 #salva $ra

	addi $s4, $a1, 0               #$s4 = tam
	addi $s0, $zero, 0             #$s0 = i = 0
	addi $s1, $a1, -1              #$s1 = tam - 1
	
	for_exterior:
		slt $t0, $s0, $s1      #$t0 = i < (tam - 1)
		beq $t0, $zero, end_for_exterior #if $t0 == 0 pula para end_for_exterior
		
		addi $s2, $s0, 0       #$s2 = min = i
		
		addi $s3, $s0, 1       #$s3 = j = (i + 1)
		for_interior:
			slt $t1, $s3, $s4#$t1 = j < tam
			beq $t1, $zero, end_for_interior#if $t1 == 0 pula para end_for_interior
			
			sll $t2, $s3, 2  #$t2 = j * 4
			add $t2, $t2, $a0#$t2 = &A[j]
			lw $t2, ($t2)    #$t2 = A[j]
			
			sll $t3, $s2, 2  #$t3 = min * 4
			add $t3, $t3, $a0#$t3 = &A[min]
			lw $t3, ($t3)    #$t3 = A[min]
			
			slt $t4, $t2, $t3#$t4 = A[j] < A[min]
			beq $t4, $zero, end_if_interior#if $t4 == 0 pula para end_if_interior
			move $s2, $s3    #$s2 = j
			
			end_if_interior:
			addi $s3, $s3, 1 #j++
			
			j for_interior   # pula para for_interior
		end_for_interior:
		
		beq $s0, $s2, end_if_exterior#if i == min pula para end_if_exterior
		
		sll $a1, $s0, 2          #$a1 = i * 4
		add $a1, $a1, $a0        #$a1 = &A[i]
		
		sll $a2, $s2, 2          #$a2 = min * 4
		add $a2, $a2, $a0        #$a2 = &A[min]
		
		jal swap                 #chama swap
		
		end_if_exterior:
		addi $s0, $s0, 1        #i++
		j for_exterior          #pula para for_exterior
	end_for_exterior:
	
	lw $a0, 28($sp)                #restaura $a0
	lw $a1, 24($sp)                #restaura $a1	
	lw $s0, 20($sp)                #restaura $s0
	lw $s1, 16($sp)                #restaura $s1
	lw $s2, 12($sp)                #restaura $s2
	lw $s3, 8($sp)                 #restaura $s3
	lw $s4, 4($sp)                 #restaura $s4
	lw $ra, 0($sp)                 #restaura $ra
	addi $sp, $sp, 32              #remove 8 espaços da pilha
	
	jr $ra                         #pula para $ra


################### FUNCAO AUXILIAR SWAP ######################################
swap:
	lw $t0, 0($a1)                 #$t0 = A[a] 
	lw $t1, 0($a2)                 #$t1 = A[b]
	
	sw $t1, ($a1)                  #A[a] = $t1
	sw $t0, ($a2)                  #A[b] = $t0
	
	jr $ra                         #pula para $ra
	
############################### LER ARQUIVO ###################################
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
				lb $t1, ($a1) # carrega em t1 o primeiro byte em a1
				subi $t1, $t1, 48 # ascii code -> int
				add $t0, $t0, $t1 
				lb $a0, 1($a1) # carrega o proximo
				jal next # testa o proximo e atualiza a0
				lw $ra, 4($sp) # restaura $ra
				beq $v0, 0, endDecimal
				
				j decimal
				
			endDecimal:
			
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

################################### Print Console ############################################

printArr:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $v0, 4
	la $a0, labelFim
	syscall
	
	li $t0, 0
	print:
	
		li $v0, 4
		la $a0, separador
		syscall
		
		beq $v1, $t0, endPrint
	
		li $v0, 1
		lw $a0, ($s1) 
		syscall
	
		addi $s1, $s1, 4
		subi $v1, $v1, 1
		
		j print
		
	endPrint:
	jr $ra