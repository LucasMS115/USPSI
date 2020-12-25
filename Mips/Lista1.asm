.data
	v: .word 80:100
.text

	main:
	
		la $s0, v
		addi $t0, $zero, 2 # a
		addi $t1, $zero, 5 # b
		addi $t2, $zero, 30 # c
		addi $t3, $zero, 40 # 4
		addi $t4, $zero, 50 # i
		
		lw $t5, 12($s0)
		
		
		addi $s1, $zero, 400
		addi $s2, $zero, 10
		
		while:
		
			blt $t4, $s1, exit # se i < 100
			lw $a1, v($t4) # a1 = v[i]
			addi $a1, $a1, 1
			sw $a1, v($t4)
			
			bgt $a1, $s2, sim # se v[i] > 10
			
			sll $t1, $t2, 1 # b = c*2^1
			
			sub $t1, $t1, $t3
			
			j while
			
			
			sim:
				addi $t0, $t0, 1 # a++	
			
				
		
		exit:
			
			#End program
			li $v0, 10
			syscall
		
		
			
		